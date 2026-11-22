import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';
import 'package:summa/features/health/health_service.dart';

HealthService _fake(HealthResult result) =>
    HealthService(() async => result.ok ? 'ok' : 'down');

Future<void> _pump(WidgetTester tester, HealthService service) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [healthServiceProvider.overrideWithValue(service)],
      child: const SummaApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows the ready state when the backend answers ok', (t) async {
    await _pump(t, _fake(const HealthResult(ok: true, latency: Duration.zero)));
    expect(find.text('سرور آماده است'), findsOneWidget);
  });

  testWidgets('shows the failure state when the backend is down', (t) async {
    await _pump(
      t,
      _fake(const HealthResult(ok: false, latency: Duration.zero)),
    );
    expect(find.text('اتصال برقرار نشد'), findsOneWidget);
  });

  testWidgets('retry button asks again', (t) async {
    var calls = 0;
    await _pump(
      t,
      HealthService(() async {
        calls++;
        return 'ok';
      }),
    );
    expect(calls, 1);
    await t.tap(find.text('دوباره بررسی کن'));
    await t.pumpAndSettle();
    expect(calls, 2);
  });

  testWidgets('lays out right-to-left', (t) async {
    await _pump(t, _fake(const HealthResult(ok: true, latency: Duration.zero)));
    final context = t.element(find.text('اتصال به سرور'));
    expect(Directionality.of(context), TextDirection.rtl);
  });
}
