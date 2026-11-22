import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/auth_models.dart';
import 'package:summa/features/auth/token_store.dart';

import 'fake_auth_api.dart';

ProviderContainer _container(FakeAuthApi api, MemoryTokenStore store) {
  final container = ProviderContainer(
    overrides: [
      authApiProvider.overrideWithValue(api),
      tokenStoreProvider.overrideWithValue(store),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('starts signed out when nothing is stored', () async {
    final c = _container(FakeAuthApi(), MemoryTokenStore());
    expect(await c.read(authControllerProvider.future), isA<SignedOut>());
  });

  test('picks up a stored session', () async {
    final api = FakeAuthApi(profileName: 'سارا');
    final c = _container(api, MemoryTokenStore(api.currentTokens));

    final state = await c.read(authControllerProvider.future);

    expect(state, isA<SignedIn>());
    expect((state as SignedIn).profile.displayName, 'سارا');
  });

  test('refreshes an expired access token once while resuming', () async {
    final api = FakeAuthApi(profileName: 'سارا');
    final store = MemoryTokenStore(
      const Tokens(access: 'stale', refresh: 'refresh-1'),
    );
    final c = _container(api, store);

    final state = await c.read(authControllerProvider.future);

    expect(state, isA<SignedIn>());
    expect(api.calls.where((x) => x == 'refresh'), hasLength(1));
    expect((await store.read())!.access, api.validAccess);
  });

  test('drops the session when refresh is refused', () async {
    final api = FakeAuthApi()..refreshRefused = true;
    final store = MemoryTokenStore(
      const Tokens(access: 'stale', refresh: 'refresh-1'),
    );
    final c = _container(api, store);

    expect(await c.read(authControllerProvider.future), isA<SignedOut>());
    expect(await store.read(), isNull);
  });

  test('keeps the stored session and reports an error when offline', () async {
    final api = FakeAuthApi()..meFailure = AuthFailure.offline;
    final store = MemoryTokenStore(api.currentTokens);
    final c = _container(api, store);

    await expectLater(
      c.read(authControllerProvider.future),
      throwsA(isA<AuthException>()),
    );
    expect(await store.read(), isNotNull);
  });

  test('verifying a code stores tokens and signs in', () async {
    final api = FakeAuthApi();
    final store = MemoryTokenStore();
    final c = _container(api, store);
    await c.read(authControllerProvider.future);

    final challenge = await c
        .read(authControllerProvider.notifier)
        .requestCode('09123456789');
    await c
        .read(authControllerProvider.notifier)
        .verifyCode(ticket: challenge.ticket, code: FakeAuthApi.validCode);

    final state = c.read(authControllerProvider).value;
    expect(state, isA<SignedIn>());
    expect(await store.read(), isNotNull);
  });

  test('a wrong code throws and leaves the user signed out', () async {
    final c = _container(FakeAuthApi(), MemoryTokenStore());
    await c.read(authControllerProvider.future);

    await expectLater(
      c
          .read(authControllerProvider.notifier)
          .verifyCode(ticket: FakeAuthApi.ticket, code: '000000'),
      throwsA(
        isA<AuthException>().having(
          (e) => e.failure,
          'failure',
          AuthFailure.wrongCode,
        ),
      ),
    );
    expect(c.read(authControllerProvider).value, isA<SignedOut>());
  });

  test('withAccess refreshes once and retries after a refused token', () async {
    final api = FakeAuthApi(profileName: 'سارا');
    final c = _container(api, MemoryTokenStore(api.currentTokens));
    await c.read(authControllerProvider.future);
    api.validAccess = 'rotated-elsewhere';

    final profile = await c
        .read(authControllerProvider.notifier)
        .withAccess((access) => api.me(access));

    expect(profile.displayName, 'سارا');
    expect(api.calls.where((x) => x == 'refresh'), hasLength(1));
  });

  test('withAccess ends the session when refresh is refused too', () async {
    final api = FakeAuthApi(profileName: 'سارا');
    final store = MemoryTokenStore(api.currentTokens);
    final c = _container(api, store);
    await c.read(authControllerProvider.future);
    api
      ..validAccess = 'rotated-elsewhere'
      ..refreshRefused = true;

    await expectLater(
      c
          .read(authControllerProvider.notifier)
          .withAccess((access) => api.me(access)),
      throwsA(isA<AuthException>()),
    );
    expect(c.read(authControllerProvider).value, isA<SignedOut>());
    expect(await store.read(), isNull);
  });

  test('sign out clears the store and tells the server', () async {
    final api = FakeAuthApi(profileName: 'سارا');
    final store = MemoryTokenStore(api.currentTokens);
    final c = _container(api, store);
    await c.read(authControllerProvider.future);

    await c.read(authControllerProvider.notifier).signOut();

    expect(c.read(authControllerProvider).value, isA<SignedOut>());
    expect(await store.read(), isNull);
    expect(api.calls, contains('logout'));
  });

  test('saving a name updates the profile', () async {
    final api = FakeAuthApi();
    final c = _container(api, MemoryTokenStore(api.currentTokens));
    await c.read(authControllerProvider.future);

    await c.read(authControllerProvider.notifier).saveName('  رضا ');

    final state = c.read(authControllerProvider).value as SignedIn;
    expect(state.profile.displayName, 'رضا');
  });
}
