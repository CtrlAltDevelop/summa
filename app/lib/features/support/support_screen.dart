import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format/persian.dart';
import '../../core/ui/tokens/tokens.dart';
import '../../core/ui/widgets/widgets.dart';
import '../../l10n/gen/app_localizations.dart';
import 'support_controller.dart';
import 'support_models.dart';

String _statusLabel(AppLocalizations l10n, String status) => switch (status) {
  'pending' => l10n.supportStatusPending,
  'resolved' => l10n.supportStatusResolved,
  'closed' => l10n.supportStatusClosed,
  _ => l10n.supportStatusOpen,
};

/// The person's own tickets, and the way to open a new one.
class SupportScreen extends ConsumerWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tickets = ref.watch(ticketsProvider).value ?? const <SupportTicket>[];
    return SmScreen(
      title: l10n.supportTitle,
      children: [
        SmButton(
          label: l10n.supportNew,
          onPressed: () => Navigator.of(context).push(
            PageRouteBuilder<void>(
              pageBuilder: (_, _, _) => const TicketFormScreen(),
            ),
          ),
        ),
        const SizedBox(height: SmSpace.lg),
        if (tickets.isEmpty)
          Text(l10n.supportEmpty, style: SmType.body)
        else
          for (final t in tickets)
            Padding(
              padding: const EdgeInsets.only(bottom: SmSpace.sm),
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  PageRouteBuilder<void>(
                    pageBuilder: (_, _, _) => ThreadScreen(ticket: t),
                  ),
                ),
                child: SmGlassCard(
                  padding: const EdgeInsets.all(SmSpace.lg),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t.subject, style: SmType.body),
                            Text(
                              [
                                _statusLabel(l10n, t.status),
                                if (t.lastMessageAt != null)
                                  formatJalaliDate(t.lastMessageAt!.toLocal()),
                              ].join(' · '),
                              style: SmType.caption,
                            ),
                          ],
                        ),
                      ),
                      if (t.unread > 0)
                        Text(
                          l10n.supportUnread,
                          style: SmType.caption.copyWith(
                            color: SmColors.accent,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
      ],
    );
  }
}

/// Open a ticket: a subject and what is wrong.
class TicketFormScreen extends ConsumerStatefulWidget {
  const TicketFormScreen({super.key});

  @override
  ConsumerState<TicketFormScreen> createState() => _TicketFormScreenState();
}

class _TicketFormScreenState extends ConsumerState<TicketFormScreen> {
  final _subject = TextEditingController();
  final _body = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _subject.dispose();
    _body.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    if (_subject.text.trim().isEmpty || _body.text.trim().isEmpty) {
      setState(() => _error = l10n.supportSubjectRequired);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await openTicket(
        ref,
        subject: _subject.text.trim(),
        body: _body.text.trim(),
      );
      if (mounted) navigator.pop();
    } on Exception {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = l10n.supportFailed;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SmScreen(
      title: l10n.supportNew,
      children: [
        SmTextField(
          controller: _subject,
          label: l10n.supportSubjectLabel,
          autofocus: true,
        ),
        const SizedBox(height: SmSpace.lg),
        SmTextField(
          controller: _body,
          label: l10n.supportBodyLabel,
          maxLines: 6,
        ),
        if (_error != null) ...[
          const SizedBox(height: SmSpace.md),
          Text(_error!, style: SmType.caption.copyWith(color: SmColors.danger)),
        ],
        const SizedBox(height: SmSpace.xl),
        SmButton(label: l10n.supportSend, onPressed: _busy ? null : _send),
      ],
    );
  }
}

/// One ticket's conversation, and a box to reply.
class ThreadScreen extends ConsumerStatefulWidget {
  const ThreadScreen({required this.ticket, super.key});

  final SupportTicket ticket;

  @override
  ConsumerState<ThreadScreen> createState() => _ThreadScreenState();
}

class _ThreadScreenState extends ConsumerState<ThreadScreen> {
  final _reply = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _reply.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final l10n = AppLocalizations.of(context);
    final text = _reply.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await sendMessage(ref, widget.ticket.id, text);
      _reply.clear();
    } on Exception {
      if (mounted) setState(() => _error = l10n.supportFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final thread =
        ref.watch(threadProvider(widget.ticket.id)).value ??
        const <SupportMessage>[];
    return SmBackground(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(SmSpace.screen),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(widget.ticket.subject, style: SmType.title),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: SmSpace.screen),
                children: [
                  for (final m in thread)
                    Padding(
                      padding: const EdgeInsets.only(bottom: SmSpace.md),
                      child: Align(
                        alignment: m.fromTeam
                            ? AlignmentDirectional.centerEnd
                            : AlignmentDirectional.centerStart,
                        child: SmGlassCard(
                          padding: const EdgeInsets.all(SmSpace.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                m.fromTeam
                                    ? l10n.supportFromTeam
                                    : l10n.supportFromYou,
                                style: SmType.caption.copyWith(
                                  color: SmColors.accent,
                                ),
                              ),
                              Text(m.body, style: SmType.body),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (_error != null)
              Text(
                _error!,
                style: SmType.caption.copyWith(color: SmColors.danger),
              ),
            Padding(
              padding: const EdgeInsets.all(SmSpace.screen),
              child: Row(
                children: [
                  Expanded(
                    child: SmTextField(
                      controller: _reply,
                      label: l10n.supportReplyHint,
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: SmSpace.md),
                  SmButton(
                    label: l10n.supportSend,
                    onPressed: _busy ? null : _send,
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
