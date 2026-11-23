import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import '../auth/auth_models.dart';
import '../wallets/choices.dart';
import '../wallets/entry_models.dart';
import '../wallets/ledger_controller.dart';
import '../wallets/wallet_models.dart';
import '../wallets/wallets_controller.dart';
import 'assistant_controller.dart';
import 'chat_models.dart';

/// The private chat. The assistant suggests; "register" on a card sends the
/// ordinary record request from this phone.
class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _input = TextEditingController();
  String? _error;
  bool _sending = false;

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final l10n = AppLocalizations.of(context);
    final text = _input.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      await ref.read(assistantControllerProvider.notifier).send(text);
      _input.clear();
      if (mounted) setState(() => _sending = false);
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
      _sending = false;
      _error = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final messages = ref.watch(assistantControllerProvider).value ?? const [];
    return SmBackground(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(SmSpace.screen),
              child: Row(
                children: [
                  Expanded(child: Text(l10n.chatTitle, style: SmType.title)),
                  GestureDetector(
                    onTap: () =>
                        ref.read(assistantControllerProvider.notifier).clear(),
                    child: Text(
                      l10n.chatClear,
                      style: SmType.caption.copyWith(color: SmColors.danger),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: messages.isEmpty
                  ? Center(child: Text(l10n.chatEmpty, style: SmType.body))
                  : ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SmSpace.screen,
                      ),
                      children: [for (final m in messages) _Bubble(message: m)],
                    ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.all(SmSpace.sm),
                child: Text(
                  _error!,
                  style: SmType.caption.copyWith(color: SmColors.danger),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(SmSpace.screen),
              child: Row(
                children: [
                  Expanded(
                    child: SmTextField(
                      controller: _input,
                      label: l10n.chatHint,
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: SmSpace.md),
                  SmButton(
                    label: l10n.chatSend,
                    onPressed: _sending ? null : _send,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SmSpace.md),
      child: Align(
        alignment: message.fromUser
            ? AlignmentDirectional.centerStart
            : AlignmentDirectional.centerEnd,
        child: SmGlassCard(
          padding: const EdgeInsets.all(SmSpace.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message.text, style: SmType.body),
              if (message.card != null)
                _CardActions(messageId: message.id, card: message.card!),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardActions extends ConsumerStatefulWidget {
  const _CardActions({required this.messageId, required this.card});

  final String messageId;
  final ChatCard card;

  @override
  ConsumerState<_CardActions> createState() => _CardActionsState();
}

class _CardActionsState extends ConsumerState<_CardActions> {
  String? _walletId;
  bool _busy = false;

  Future<void> _register(String walletId) async {
    final card = widget.card;
    final ledger = ref.read(ledgerControllerProvider.notifier);
    // Same id every time for this card: a second tap cannot register twice.
    final mutation = 'reg-${widget.messageId}';
    setState(() => _busy = true);
    try {
      if (card.isTransfer) {
        await ledger.transfer(
          fromWalletId: walletId,
          toWalletId: card.toWalletId,
          amountMinor: card.amountMinor,
          rate: '',
          feeMinor: 0,
          note: card.note,
          clientMutationId: mutation,
        );
      } else {
        await ledger.record(
          walletId: walletId,
          kind: EntryKind.fromWire(card.kind),
          amountMinor: card.amountMinor,
          note: card.note,
          clientMutationId: mutation,
          categoryId: card.categoryId,
          occurredAt: card.occurredAt,
        );
      }
      ref.read(registeredCardsProvider.notifier).add(widget.messageId);
    } on Exception {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final done = ref.watch(registeredCardsProvider).contains(widget.messageId);
    final wallets = (ref.watch(walletsControllerProvider).value?.active ?? [])
        .where((w) => w.currency == widget.card.currency)
        .toList();
    final walletId = widget.card.walletId.isNotEmpty
        ? widget.card.walletId
        : _walletId;
    return Padding(
      padding: const EdgeInsets.only(top: SmSpace.md),
      child: done
          ? Text(
              l10n.chatRegistered,
              style: SmType.caption.copyWith(color: SmColors.success),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.card.walletId.isEmpty) ...[
                  Text(l10n.chatChooseWallet, style: SmType.caption),
                  const SizedBox(height: SmSpace.sm),
                  Choices<Wallet>(
                    values: wallets,
                    selected: wallets.firstWhere(
                      (w) => w.id == _walletId,
                      orElse: () => wallets.first,
                    ),
                    label: (w) => w.name,
                    onSelected: (w) => setState(() => _walletId = w.id),
                  ),
                  const SizedBox(height: SmSpace.sm),
                ],
                SmButton(
                  label: l10n.chatRegister,
                  onPressed: _busy || (walletId == null && wallets.isEmpty)
                      ? null
                      : () => _register(walletId ?? wallets.first.id),
                ),
              ],
            ),
    );
  }
}
