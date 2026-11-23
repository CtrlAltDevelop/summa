import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/grpc/grpc_providers.dart';
import '../../core/storage/key_value_store.dart';
import 'auth_api.dart';
import 'auth_models.dart';
import 'token_store.dart';

final authApiProvider = Provider<AuthApi>(
  (ref) => GrpcAuthApi(ref.watch(grpcChannelProvider)),
);

final tokenStoreProvider = Provider<TokenStore>((ref) => SecureTokenStore());

/// Who is signed in right now.
sealed class AuthState {
  const AuthState();
}

class SignedOut extends AuthState {
  const SignedOut();
}

class SignedIn extends AuthState {
  const SignedIn({required this.tokens, required this.profile});

  final Tokens tokens;
  final Profile profile;

  SignedIn copyWith({Tokens? tokens, Profile? profile}) =>
      SignedIn(tokens: tokens ?? this.tokens, profile: profile ?? this.profile);
}

/// No automatic retry: an offline start must surface as an error the gate can
/// show with a retry button, not loop silently.
final authControllerProvider = AsyncNotifierProvider<AuthController, AuthState>(
  AuthController.new,
  retry: (_, _) => null,
);

class AuthController extends AsyncNotifier<AuthState> {
  AuthApi get _api => ref.read(authApiProvider);
  TokenStore get _store => ref.read(tokenStoreProvider);

  /// Picks the session up from secure storage. A refused token is refreshed
  /// once; if that fails the stored session is dropped. Offline errors
  /// propagate so the gate can offer a retry instead of signing out.
  @override
  Future<AuthState> build() async {
    final stored = await _store.read();
    if (stored == null) return const SignedOut();
    try {
      return await _resume(stored);
    } on AuthException catch (e) {
      if (e.failure == AuthFailure.offline) rethrow;
      await _store.clear();
      return const SignedOut();
    }
  }

  Future<AuthState> _resume(Tokens tokens) async {
    try {
      return SignedIn(tokens: tokens, profile: await _api.me(tokens.access));
    } on AuthException catch (e) {
      if (e.failure != AuthFailure.unauthorized) rethrow;
      final fresh = await _api.refresh(tokens.refresh);
      await _store.write(fresh);
      return SignedIn(tokens: fresh, profile: await _api.me(fresh.access));
    }
  }

  Future<CodeChallenge> requestCode(String phone) => _api.startLogin(phone);

  /// Trades the code for tokens, stores them and loads the profile.
  Future<void> verifyCode({
    required String ticket,
    required String code,
  }) async {
    final tokens = await _api.verifyCode(ticket: ticket, code: code);
    await _store.write(tokens);
    final profile = await _api.me(tokens.access);
    state = AsyncData(SignedIn(tokens: tokens, profile: profile));
  }

  Future<void> saveName(String name) async {
    final current = state.requireValue;
    if (current is! SignedIn) return;
    final profile = await withAccess(
      (access) => _api.updateName(access, name.trim()),
    );
    state = AsyncData(
      (state.requireValue as SignedIn).copyWith(profile: profile),
    );
  }

  /// Runs an authorised call; on a refused token refreshes once and retries.
  /// If the refresh is refused too, the session ends.
  Future<T> withAccess<T>(Future<T> Function(String access) call) async {
    final current = state.requireValue;
    if (current is! SignedIn) {
      throw const AuthException(AuthFailure.unauthorized);
    }
    try {
      return await call(current.tokens.access);
    } on AuthException catch (e) {
      if (e.failure != AuthFailure.unauthorized) rethrow;
    }
    try {
      final fresh = await _api.refresh(current.tokens.refresh);
      await _store.write(fresh);
      state = AsyncData(current.copyWith(tokens: fresh));
      return await call(fresh.access);
    } on AuthException catch (e) {
      if (e.failure == AuthFailure.unauthorized) await _endSession();
      rethrow;
    }
  }

  Future<void> signOut() async {
    final current = state.value;
    if (current is SignedIn) {
      try {
        await _api.logout(current.tokens.access);
      } on AuthException {
        // The server could not be told; the local session still ends.
      }
    }
    await _endSession();
  }

  /// What is kept on the device for the signed-in person. It must never
  /// outlive the session: the next person to sign in would see it.
  static const localDataKeys = ['wallets', 'entries', 'categories', 'outbox'];

  Future<void> _endSession() async {
    await _store.clear();
    final local = ref.read(keyValueStoreProvider);
    for (final key in localDataKeys) {
      await local.delete(key);
    }
    state = const AsyncData(SignedOut());
  }
}
