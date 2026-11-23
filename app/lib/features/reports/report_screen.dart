import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../wallets/choices.dart';
import '../wallets/wallet_labels.dart';
import '../wallets/wallet_models.dart';
import 'report_controller.dart';
import 'report_models.dart';

/// A month of income and spending, by category and by day.
class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends ConsumerState<ReportScreen> {
  int _offset = 0;
  String _currency = baseCurrency;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final query = ReportQuery(monthOffset: _offset, currency: _currency);
    final report = ref.watch(reportProvider(query));
    final window = shamsiMonthWindowAt(DateTime.now(), _offset);
    return SmScreen(
      title: l10n.reportTitle,
      children: [
        Row(
          children: [
            _Link(
              label: l10n.reportPrev,
              onTap: () => setState(() => _offset--),
            ),
            Expanded(
              child: Center(
                child: Text(
                  formatJalaliMonth(window.start.toLocal()),
                  style: SmType.body,
                ),
              ),
            ),
            _Link(
              label: l10n.reportNext,
              onTap: () => setState(() => _offset++),
            ),
          ],
        ),
        const SizedBox(height: SmSpace.lg),
        ...report.when(
          loading: () => [const Center(child: Text('…', style: SmType.body))],
          error: (_, _) => [Text(l10n.reportFailed, style: SmType.body)],
          data: (r) => _content(context, r),
        ),
      ],
    );
  }

  List<Widget> _content(BuildContext context, Report r) {
    final l10n = AppLocalizations.of(context);
    final unit = currencyLabel(l10n, r.currency);
    String money(int minor) => '${formatMinor(minor, r.currency)} $unit';
    final expenses = r.byCategory.where((c) => c.kind == 'expense').toList();
    final incomes = r.byCategory.where((c) => c.kind == 'income').toList();
    return [
      if (r.currencies.length > 1 || r.currency != baseCurrency) ...[
        Choices<String>(
          values: {...r.currencies, r.currency}.toList(),
          selected: r.currency,
          label: (c) => currencyLabel(l10n, c),
          onSelected: (c) => setState(() => _currency = c),
        ),
        const SizedBox(height: SmSpace.lg),
      ],
      SmGlassCard(
        padding: const EdgeInsets.all(SmSpace.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n.reportIncome}: ${money(r.incomeMinor)}',
              style: SmType.body,
            ),
            Text(
              '${l10n.reportExpense}: ${money(r.expenseMinor)}',
              style: SmType.body,
            ),
            Text(
              '${l10n.reportNet}: ${money(r.netMinor)}',
              style: SmType.title.copyWith(
                color: r.netMinor < 0 ? SmColors.danger : SmColors.success,
              ),
            ),
            Text(
              l10n.reportEntries(toPersianDigits('${r.entries}')),
              style: SmType.caption,
            ),
            if (r.topExpenseCategory.isNotEmpty)
              Text(l10n.reportTop(r.topExpenseCategory), style: SmType.caption),
          ],
        ),
      ),
      if (r.entries == 0) ...[
        const SizedBox(height: SmSpace.lg),
        Text(l10n.reportEmpty, style: SmType.body),
      ],
      if (expenses.isNotEmpty) ...[
        const SizedBox(height: SmSpace.xl),
        Text(l10n.reportByCategory, style: SmType.caption),
        const SizedBox(height: SmSpace.sm),
        _Bars(rows: expenses, money: money, color: SmColors.accent),
      ],
      if (incomes.isNotEmpty) ...[
        const SizedBox(height: SmSpace.xl),
        Text(l10n.reportIncomeByCategory, style: SmType.caption),
        const SizedBox(height: SmSpace.sm),
        _Bars(rows: incomes, money: money, color: SmColors.success),
      ],
      if (r.daily.any((d) => d.expenseMinor > 0)) ...[
        const SizedBox(height: SmSpace.xl),
        Text(l10n.reportDaily, style: SmType.caption),
        const SizedBox(height: SmSpace.sm),
        _DailyChart(days: r.daily),
      ],
    ];
  }
}

class _Bars extends StatelessWidget {
  const _Bars({required this.rows, required this.money, required this.color});

  final List<CategoryTotal> rows;
  final String Function(int) money;
  final Color color;

  static const _barHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    final top = rows.map((r) => r.totalMinor).fold(1, (a, b) => a > b ? a : b);
    return Column(
      children: [
        for (final r in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: SmSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(r.name, style: SmType.body)),
                    Text(money(r.totalMinor), style: SmType.caption),
                  ],
                ),
                const SizedBox(height: SmSpace.xs),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: SmColors.glassFill,
                    borderRadius: SmRadius.pill,
                  ),
                  child: SizedBox(
                    height: _barHeight,
                    child: FractionallySizedBox(
                      alignment: AlignmentDirectional.centerStart,
                      widthFactor: (r.totalMinor / top).clamp(0.0, 1.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: SmRadius.pill,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// One column per day, as tall as that day's spending is against the peak.
class _DailyChart extends StatelessWidget {
  const _DailyChart({required this.days});

  final List<DayTotal> days;

  static const _chartHeight = 96.0;

  @override
  Widget build(BuildContext context) {
    final peak = days
        .map((d) => d.expenseMinor)
        .fold(1, (a, b) => a > b ? a : b);
    return SizedBox(
      height: _chartHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final d in days)
            Expanded(
              child: Semantics(
                label: '${formatJalaliDate(d.day)}: ${d.expenseMinor}',
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: FractionallySizedBox(
                    heightFactor: (d.expenseMinor / peak).clamp(0.02, 1.0),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: SmColors.accent,
                        borderRadius: SmRadius.sm,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Link extends StatelessWidget {
  const _Link({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: SmType.caption.copyWith(color: SmColors.accent),
        ),
      ),
    );
  }
}
