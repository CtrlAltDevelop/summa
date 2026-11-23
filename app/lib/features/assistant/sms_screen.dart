import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../auth/auth_models.dart';
import '../categories/category_controller.dart';
import '../categories/category_models.dart';
import '../wallets/choices.dart';
import '../wallets/entry_models.dart';
import '../wallets/ledger_controller.dart';
import '../wallets/wallet_labels.dart';
import '../wallets/wallet_models.dart';
import '../wallets/wallets_controller.dart';
import 'assistant_controller.dart';
import 'chat_models.dart';

/// Paste a bank SMS; the app reads it and offers a card. Registering sends the
/// ordinary record request, so nothing is added without the person's tap.
class SmsScreen extends ConsumerStatefulWidget {
  const SmsScreen({super.key});

  @override
  ConsumerState<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends ConsumerState<SmsScreen> {
  final _text = TextEditingController();
  SmsCard? _card;
  String? _error;
  bool _busy = false;
  bool _done = false;

  // The person's choices on the card.
  String? _walletId;
  EntryKind? _kind;
  String? _categoryId;
  // One id per analysed message so a second tap cannot register twice.
  String _mutationId = _newMutationId();

  static String _newMutationId() {
    final random = Random.secure();
    return 'sms-${List.generate(12, (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0')).join()}';
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _analyze() async {
    final l10n = AppLocalizations.of(context);
    if (_text.text.trim().isEmpty) return;
    setState(() {
      _busy = true;
      _error = null;
      _done = false;
    });
    try {
      final card = await ref
          .read(assistantControllerProvider.notifier)
          .parseSms(_text.text);
      if (!mounted) return;
      setState(() {
        _card = card;
        _busy = false;
        _walletId = card.walletId.isEmpty ? null : card.walletId;
        _kind = card.kind.isEmpty ? null : EntryKind.fromWire(card.kind);
        _categoryId = card.categoryId.isEmpty ? null : card.categoryId;
        _mutationId = _newMutationId();
      });
    } on WalletException catch (e) {
      _fail(
        e.failure == WalletFailure.offline ? l10n.errOffline : l10n.errUnknown,
      );
    } on AuthException {
      _fail(l10n.errUnknown);
    }
  }

  void _fail(String message) {
    if (!mounted) return;
    setState(() {
      _busy = false;
      _error = message;
    });
  }

  Future<void> _register(SmsCard card, String walletId, EntryKind kind) async {
    final assistant = ref.read(assistantControllerProvider.notifier);
    setState(() => _busy = true);
    try {
      await ref
          .read(ledgerControllerProvider.notifier)
          .record(
            walletId: walletId,
            kind: kind,
            amountMinor: card.amountMinor,
            note: '',
            clientMutationId: _mutationId,
            categoryId: _categoryId ?? '',
            occurredAt: card.occurredAt,
          );
      if (card.last4.isNotEmpty && walletId != card.walletId) {
        await assistant.linkCard(card.last4, walletId);
      }
      if (mounted) {
        setState(() {
          _busy = false;
          _done = true;
        });
      }
    } on Exception {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final card = _card;
    return SmScreen(
      title: l10n.smsTitle,
      children: [
        SmTextField(controller: _text, label: l10n.smsPasteLabel, maxLines: 5),
        const SizedBox(height: SmSpace.md),
        SmButton(label: l10n.smsAnalyze, onPressed: _busy ? null : _analyze),
        if (_error != null) ...[
          const SizedBox(height: SmSpace.md),
          Text(_error!, style: SmType.caption.copyWith(color: SmColors.danger)),
        ],
        if (card != null) ...[
          const SizedBox(height: SmSpace.xl),
          if (card.ignored.isNotEmpty)
            Text(_ignoredText(l10n, card.ignored), style: SmType.body)
          else
            _result(context, card),
        ],
      ],
    );
  }

  String _ignoredText(AppLocalizations l10n, String reason) => switch (reason) {
    'otp' => l10n.smsIgnoredOtp,
    'failed' => l10n.smsIgnoredFailed,
    'ad' => l10n.smsIgnoredAd,
    _ => l10n.smsIgnoredNoAmount,
  };

  Widget _result(BuildContext context, SmsCard card) {
    final l10n = AppLocalizations.of(context);
    final wallets = (ref.watch(walletsControllerProvider).value?.active ?? [])
        .where((w) => w.currency == card.currency)
        .toList();
    final categories = (ref.watch(categoriesControllerProvider).value ?? [])
        .where((c) => card.suggestedCategoryIds.contains(c.id))
        .toList();
    final kind = _kind;
    final walletId = _walletId;
    final canRegister = kind != null && walletId != null && !_busy && !_done;
    return SmGlassCard(
      padding: const EdgeInsets.all(SmSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${formatMinor(card.amountMinor, card.currency)} '
            '${currencyLabel(l10n, card.currency)}',
            style: SmType.title,
          ),
          if (card.balanceMinor != null)
            Text(
              '${l10n.smsBalance}: ${formatMinor(card.balanceMinor!, card.currency)}',
              style: SmType.caption,
            ),
          if (card.confidence == 'low') ...[
            const SizedBox(height: SmSpace.sm),
            Text(
              l10n.smsLowConfidence,
              style: SmType.caption.copyWith(color: SmColors.warning),
            ),
          ],
          if (card.duplicateEntryId.isNotEmpty) ...[
            const SizedBox(height: SmSpace.sm),
            Text(
              l10n.smsDuplicate,
              style: SmType.caption.copyWith(color: SmColors.warning),
            ),
          ],
          const SizedBox(height: SmSpace.lg),
          Text(l10n.smsKindLabel, style: SmType.caption),
          const SizedBox(height: SmSpace.sm),
          Choices<EntryKind>(
            values: EntryKind.recordable,
            selected: kind ?? EntryKind.recordable.first,
            label: (k) =>
                k == EntryKind.expense ? l10n.entryExpense : l10n.entryIncome,
            onSelected: (k) => setState(() => _kind = k),
          ),
          const SizedBox(height: SmSpace.lg),
          Text(l10n.entryWalletLabel, style: SmType.caption),
          const SizedBox(height: SmSpace.sm),
          Choices<Wallet>(
            values: wallets,
            selected: wallets.firstWhere(
              (w) => w.id == walletId,
              orElse: () => wallets.first,
            ),
            label: (w) => w.name,
            onSelected: (w) => setState(() => _walletId = w.id),
          ),
          if (card.last4.isNotEmpty && card.walletId.isEmpty) ...[
            const SizedBox(height: SmSpace.sm),
            Text(l10n.smsCardNote(card.last4), style: SmType.caption),
          ],
          if (categories.isNotEmpty) ...[
            const SizedBox(height: SmSpace.lg),
            Text(l10n.smsWhatFor, style: SmType.caption),
            const SizedBox(height: SmSpace.sm),
            Choices<Category>(
              values: categories,
              selected: categories.firstWhere(
                (c) => c.id == _categoryId,
                orElse: () => categories.first,
              ),
              label: (c) => c.name,
              onSelected: (c) => setState(() => _categoryId = c.id),
            ),
          ],
          const SizedBox(height: SmSpace.xl),
          if (_done)
            Text(
              l10n.chatRegistered,
              style: SmType.body.copyWith(color: SmColors.success),
            )
          else
            SmButton(
              label: l10n.chatRegister,
              onPressed: canRegister
                  ? () => _register(card, walletId, kind)
                  : null,
            ),
        ],
      ),
    );
  }
}
