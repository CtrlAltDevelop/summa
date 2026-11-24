import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:summa/app.dart';

void main() {
  testWidgets('gallery shows every shared widget and ends the count', (
    t,
  ) async {
    await t.pumpWidget(
      const ProviderScope(child: SummaApp(initialRoute: galleryRoute)),
    );
    await t.pumpAndSettle();

    expect(find.text('گالری اجزا'), findsOneWidget);
    expect(find.text('دکمه اصلی'), findsOneWidget);
    expect(find.text('کارت شیشه‌ای'), findsOneWidget);
    expect(find.text('موفق'), findsOneWidget);
    expect(find.text('۱۲٬۸۵۰٬۰۰۰'), findsOneWidget);
  });

  testWidgets('reduced motion shows the final count immediately', (t) async {
    await t.pumpWidget(
      const ProviderScope(
        child: MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: SummaApp(initialRoute: galleryRoute),
        ),
      ),
    );
    await t.pump();
    await t.pump();
    expect(find.text('۱۲٬۸۵۰٬۰۰۰'), findsOneWidget);
  });
}
