import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/core/storage/key_value_store.dart';
import 'package:summa/features/billing/billing_controller.dart';
import 'package:summa/features/auth/auth_controller.dart';
import 'package:summa/features/auth/token_store.dart';
import 'package:summa/features/categories/category_controller.dart';
import 'package:summa/features/outbox/outbox.dart';
import 'package:summa/features/wallets/entry_models.dart';
import 'package:summa/features/wallets/ledger_controller.dart';
import 'package:summa/features/wallets/wallet_models.dart';
import 'package:summa/features/wallets/wallets_controller.dart';

import '../auth/fake_auth_api.dart';
import '../categories/fake_category_api.dart';
import '../wallets/fake_ledger_api.dart';
import '../wallets/fake_wallet_api.dart';
import '../billing/fake_billing_api.dart';

QueuedEntry _entry(String id, {int amount = 1000}) => QueuedEntry(
  mutationId: id,
  walletId: 'w1',
  kind: EntryKind.expense,
  amountMinor: amount,
  currency: 'IRT',
  note: 'نان',
  categoryId: 'c-food',
  outsideTotals: false,
  createdAt: DateTime.utc(2026, 11, 22, 8),
);

class _Rig {
  _Rig(this.store) {
    wallets.wallets.add(
      const Wallet(
        id: 'w1',
        name: 'ملی',
        kind: WalletKind.bank,
        currency: 'IRT',
        bank: '',
        archived: false,
        balanceMinor: 100000,
      ),
    );
    final auth = FakeAuthApi(profileName: 'سارا');
    container = ProviderContainer(
      overrides: [
        keyValueStoreProvider.overrideWithValue(store),
        authApiProvider.overrideWithValue(auth),
        tokenStoreProvider.overrideWithValue(
          MemoryTokenStore(auth.currentTokens),
        ),
        ledgerApiProvider.overrideWithValue(ledger),
        billingApiProvider.overrideWithValue(FakeBillingApi()),
        walletApiProvider.overrideWithValue(wallets),
        categoryApiProvider.overrideWithValue(FakeCategoryApi(ledger)),
      ],
    );
  }

  final KeyValueStore store;
  final wallets = FakeWalletApi();
  late final ledger = FakeLedgerApi(wallets);
  late final ProviderContainer container;

  Future<OutboxController> signedIn() async {
    await container.read(authControllerProvider.future);
    final outbox = container.read(outboxProvider.notifier);
    await Future<void>.delayed(Duration.zero); // let the saved queue load
    return outbox;
  }
}

void main() {
  test('a queued entry survives a restart', () async {
    final store = MemoryKeyValueStore();
    final first = _Rig(store);
    final outbox = await first.signedIn();
    await outbox.enqueue(_entry('m1'));
    first.container.dispose();

    final second = _Rig(store);
    await second.signedIn();

    expect(
      second.container.read(outboxProvider).pending.single.mutationId,
      'm1',
    );
    expect(second.container.read(outboxProvider).pending.single.note, 'نان');
  });

  test(
    'flushing sends in order with the original mutation id and date',
    () async {
      final rig = _Rig(MemoryKeyValueStore());
      final outbox = await rig.signedIn();
      await outbox.enqueue(_entry('m1', amount: 100));
      await outbox.enqueue(_entry('m2', amount: 200));

      await outbox.flush();

      expect(rig.ledger.mutations, ['m1', 'm2']);
      expect(rig.ledger.entries.map((e) => e.amountMinor), [100, 200]);
      expect(rig.container.read(outboxProvider).pending, isEmpty);
    },
  );

  test(
    'with no connection everything stays queued, and later goes out',
    () async {
      final rig = _Rig(MemoryKeyValueStore());
      final outbox = await rig.signedIn();
      await outbox.enqueue(_entry('m1'));
      await outbox.enqueue(_entry('m2'));
      rig.ledger.offline = true;

      await outbox.flush();
      expect(rig.container.read(outboxProvider).pending, hasLength(2));
      expect(rig.ledger.entries, isEmpty);

      rig.ledger.offline = false;
      await outbox.flush();
      expect(rig.container.read(outboxProvider).pending, isEmpty);
      expect(rig.ledger.entries, hasLength(2));
    },
  );

  test(
    'a refused entry moves to the failed list and the next one is sent',
    () async {
      final rig = _Rig(MemoryKeyValueStore());
      final outbox = await rig.signedIn();
      await outbox.enqueue(_entry('bad'));
      await outbox.enqueue(_entry('good'));
      rig.ledger.refuseRecord = WalletFailure.invalid;
      await outbox.flush(); // both refused
      rig.ledger.refuseRecord = null;

      final state = rig.container.read(outboxProvider);

      expect(state.pending, isEmpty);
      expect(state.failed.map((f) => f.entry.mutationId), ['bad', 'good']);
      expect(state.failed.first.reason, WalletFailure.invalid);
    },
  );

  test('a failed entry can be dismissed and the state is saved', () async {
    final store = MemoryKeyValueStore();
    final rig = _Rig(store);
    final outbox = await rig.signedIn();
    await outbox.enqueue(_entry('bad'));
    rig.ledger.refuseRecord = WalletFailure.notFound;
    await outbox.flush();

    await outbox.dismissFailed('bad');

    final saved =
        jsonDecode((await store.read(outboxKey))!) as Map<String, Object?>;
    expect(saved['failed'], isEmpty);
    expect(rig.container.read(outboxProvider).failed, isEmpty);
  });

  test('two flushes at once send each entry once', () async {
    final rig = _Rig(MemoryKeyValueStore());
    final outbox = await rig.signedIn();
    await outbox.enqueue(_entry('m1'));

    await Future.wait([outbox.flush(), outbox.flush()]);

    expect(rig.ledger.mutations, ['m1']);
  });

  test('sending the same mutation id twice records it once', () async {
    final rig = _Rig(MemoryKeyValueStore());
    final outbox = await rig.signedIn();
    await outbox.enqueue(_entry('m1'));
    await outbox.enqueue(_entry('m1')); // a double tap that got queued twice

    await outbox.flush();

    expect(rig.ledger.entries, hasLength(1));
  });

  test('an empty outbox flushes without touching the server', () async {
    final rig = _Rig(MemoryKeyValueStore());
    final outbox = await rig.signedIn();
    rig.ledger.offline = true; // would throw if anything were sent

    await outbox.flush();

    expect(rig.ledger.entries, isEmpty);
  });

  group('cached snapshots', () {
    test('a successful load is remembered and served when offline', () async {
      final rig = _Rig(MemoryKeyValueStore());
      await rig.signedIn();
      await rig.container.read(walletsControllerProvider.future);
      rig.wallets.offline = true;
      rig.container.invalidate(walletsControllerProvider);

      final cached = await rig.container.read(walletsControllerProvider.future);

      expect(cached.wallets.single.name, 'ملی');
      expect(cached.wallets.single.balanceMinor, 100000);
    });

    test('entries and categories are cached the same way', () async {
      final rig = _Rig(MemoryKeyValueStore());
      await rig.signedIn();
      await rig.ledger.record(
        'a',
        walletId: 'w1',
        kind: EntryKind.income,
        amountMinor: 55,
        note: 'x',
        clientMutationId: 'seed',
        categoryId: 'c-salary',
      );
      await rig.container.read(ledgerControllerProvider.future);
      await rig.container.read(categoriesControllerProvider.future);
      rig.ledger.offline = true;
      final categoryApi =
          rig.container.read(categoryApiProvider) as FakeCategoryApi;
      categoryApi.offline = true;
      rig.container
        ..invalidate(ledgerControllerProvider)
        ..invalidate(categoriesControllerProvider);

      final entries = await rig.container.read(ledgerControllerProvider.future);
      final categories = await rig.container.read(
        categoriesControllerProvider.future,
      );

      expect(
        (entries.single.amountMinor, entries.single.kind),
        (55, EntryKind.income),
      );
      expect(categories.map((c) => c.name), contains('حقوق'));
    });

    test(
      'offline with nothing cached is an error, not an empty list',
      () async {
        final rig = _Rig(MemoryKeyValueStore());
        await rig.signedIn();
        rig.wallets.offline = true;

        await expectLater(
          rig.container.read(walletsControllerProvider.future),
          throwsA(isA<WalletException>()),
        );
      },
    );

    test('a non-connection failure is never hidden by the cache', () async {
      final rig = _Rig(MemoryKeyValueStore());
      await rig.signedIn();
      await rig.container.read(walletsControllerProvider.future);
      rig.wallets.listFailure = WalletFailure.unknown; // a server error
      rig.container.invalidate(walletsControllerProvider);

      await expectLater(
        rig.container.read(walletsControllerProvider.future),
        throwsA(isA<WalletException>()),
      );
    });
  });

  test('signing out wipes everything kept on the device', () async {
    final store = MemoryKeyValueStore();
    final rig = _Rig(store);
    final outbox = await rig.signedIn();
    await outbox.enqueue(_entry('m1'));
    await rig.container.read(walletsControllerProvider.future);
    for (final key in AuthController.localDataKeys) {
      await store.write(key, 'x');
    }

    await rig.container.read(authControllerProvider.notifier).signOut();

    for (final key in AuthController.localDataKeys) {
      expect(await store.read(key), isNull, reason: key);
    }
  });
}
