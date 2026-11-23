import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'budget_form_screen.dart';
import 'category_controller.dart';
import 'category_models.dart';

/// Add and delete categories and reach each expense category's monthly limit.
class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  final _name = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _add(CategoryKind kind) async {
    final l10n = AppLocalizations.of(context);
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(() => _error = l10n.categoryNameInvalid);
      return;
    }
    try {
      await ref.read(categoriesControllerProvider.notifier).create(name, kind);
      _name.clear();
      if (mounted) setState(() => _error = null);
    } on Exception {
      if (mounted) setState(() => _error = l10n.categoryNameInvalid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final categories = ref.watch(categoriesControllerProvider).value ?? [];
    return SmBackground(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SmSpace.screen),
          children: [
            Text(l10n.categoriesTitle, style: SmType.title),
            const SizedBox(height: SmSpace.lg),
            SmTextField(controller: _name, label: l10n.categoryNameLabel),
            if (_error != null) ...[
              const SizedBox(height: SmSpace.sm),
              Text(
                _error!,
                style: SmType.caption.copyWith(color: SmColors.danger),
              ),
            ],
            const SizedBox(height: SmSpace.md),
            SmButton(
              label: '${l10n.categoryAdd} · ${l10n.categoryExpenses}',
              onPressed: () => _add(CategoryKind.expense),
            ),
            const SizedBox(height: SmSpace.sm),
            SmButton(
              label: '${l10n.categoryAdd} · ${l10n.categoryIncomes}',
              onPressed: () => _add(CategoryKind.income),
            ),
            const SizedBox(height: SmSpace.xl),
            for (final kind in CategoryKind.values) ...[
              Text(
                kind == CategoryKind.expense
                    ? l10n.categoryExpenses
                    : l10n.categoryIncomes,
                style: SmType.caption,
              ),
              const SizedBox(height: SmSpace.sm),
              for (final c in categories.where((c) => c.kind == kind))
                Padding(
                  padding: const EdgeInsets.only(bottom: SmSpace.sm),
                  child: _CategoryTile(category: c),
                ),
              const SizedBox(height: SmSpace.lg),
            ],
          ],
        ),
      ),
    );
  }
}

class _CategoryTile extends ConsumerWidget {
  const _CategoryTile({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SmGlassCard(
      padding: const EdgeInsets.all(SmSpace.lg),
      child: Row(
        children: [
          Expanded(child: Text(category.name, style: SmType.body)),
          if (category.kind == CategoryKind.expense)
            _Action(
              label: l10n.budgetSet,
              color: SmColors.accent,
              onTap: () => Navigator.of(context).push(
                PageRouteBuilder<void>(
                  pageBuilder: (_, _, _) =>
                      BudgetFormScreen(category: category),
                ),
              ),
            ),
          if (!category.isOther) ...[
            const SizedBox(width: SmSpace.md),
            _Action(
              label: l10n.entryDelete,
              color: SmColors.danger,
              onTap: () => ref
                  .read(categoriesControllerProvider.notifier)
                  .delete(category.id),
            ),
          ],
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: Text(label, style: SmType.caption.copyWith(color: color)),
      ),
    );
  }
}
