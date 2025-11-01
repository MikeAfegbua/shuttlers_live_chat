import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/l10n/l10n.dart';
import 'package:shuttlers_live_chat/src/state/providers.dart';
import 'package:shuttlers_live_chat/src/ui/utils/date_formatters.dart';
import 'package:shuttlers_live_chat/src/ui/utils/uuid_generator.dart';
import 'package:shuttlers_live_chat/src/ui/widgets/chat_message_bubble.dart';
import 'package:shuttlers_live_chat/src/ui/widgets/connection_indicator.dart';
import 'package:shuttlers_live_chat/src/ui/widgets/date_header.dart';
import 'package:shuttlers_live_chat/src/ui/widgets/presence_badge.dart';
import 'package:shuttlers_live_chat/src/ui/widgets/typing_indicator_bubble.dart';

class TripChatPage extends StatelessWidget {
  const TripChatPage({required this.config, super.key});
  final ShuttlersChatConfig config;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [chatConfigProvider.overrideWithValue(config)],
      child: const _TripChatView(),
    );
  }
}

class _TripChatView extends ConsumerStatefulWidget {
  const _TripChatView();

  @override
  ConsumerState<_TripChatView> createState() => _TripChatViewState();
}

class _TripChatViewState extends ConsumerState<_TripChatView> {
  final TextEditingController _ctrl = TextEditingController();
  Timer? _typingTimer;
  bool _isTyping = false;

  void _handleTextChanged() {
    final repo = ref.read(chatRepositoryProvider);

    if (!_isTyping) {
      _isTyping = true;
      repo.typingStart();
    }

    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () {
      if (_isTyping) {
        _isTyping = false;
        repo.typingStop();
      }
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(chatControllerProvider);

    final locale = Localizations.maybeLocaleOf(context) ?? const Locale('en');

    return Localizations(
      locale: locale,
      delegates: const [
        ShuttlersChatLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      child: Builder(
        builder: (ctx) {
          final l10n = ShuttlersChatLocalizations.of(ctx);
          final connected = async.valueOrNull?.connected ?? false;
          final presence = async.valueOrNull?.presenceCount ?? 0;
          final typing = async.valueOrNull?.typingUsers ?? const <String>{};

          String? typingText;
          if (typing.isNotEmpty) {
            if (typing.length == 1) {
              typingText = l10n.t(
                'user_typing',
                params: {'name': typing.first},
              );
            } else if (typing.length == 2) {
              typingText = l10n.t(
                'users_typing',
                params: {'names': typing.join(' and ')},
              );
            } else {
              final list = typing.toList();
              final othersCount = typing.length - 2;
              final othersLabel = othersCount == 1 ? 'other' : 'others';
              final names =
                  '${list.take(2).join(', ')} and $othersCount $othersLabel';
              typingText = l10n.t('users_typing', params: {'names': names});
            }
          }

          return GestureDetector(
            onTap: () => FocusScope.of(ctx).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                title: Text(l10n.t('title')),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      children: [
                        ConnectionIndicator(isConnected: connected),
                        const SizedBox(width: 12),
                        PresenceBadge(count: presence),
                      ],
                    ),
                  ),
                ],
              ),
              body: async.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (e, _) =>
                        Center(child: Text('${l10n.t('error_prefix')}$e')),
                data:
                    (data) => Column(
                      children: [
                        if (data.error != null)
                          MaterialBanner(
                            content: Text(
                              '${l10n.t('error_prefix')}${data.error!}',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // no-op dismiss (kept simple)
                                },
                                child: Text(l10n.t('dismiss')),
                              ),
                            ],
                          ),
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                data.messages.length +
                                (typingText != null ? 1 : 0),
                            itemBuilder: (_, i) {
                              final totalItems =
                                  data.messages.length +
                                  (typingText != null ? 1 : 0);

                              if (i == totalItems - 1 && typingText != null) {
                                return TypingIndicatorBubble(
                                  typingText: typingText,
                                );
                              }

                              final m = data.messages[i];
                              final me = ref.read(chatConfigProvider).username;
                              final isMe = m.username == me;
                              final deliveryStatus =
                                  data.deliveryByClientId[m.clientId];
                              final showDateHeader = shouldShowDateHeader(
                                i,
                                data.messages,
                              );

                              return Column(
                                key: ValueKey(
                                  '${m.clientId}_${deliveryStatus ?? "none"}',
                                ),
                                children: [
                                  if (showDateHeader)
                                    DateHeader(
                                      text: m.createdAt.formatDateHeader(),
                                    ),
                                  ChatMessageBubble(
                                    message: m,
                                    isMe: isMe,
                                    deliveryStatus: deliveryStatus,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SafeArea(
                          top: false,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    12,
                                    8,
                                    8,
                                    12,
                                  ),
                                  child: TextField(
                                    controller: _ctrl,
                                    decoration: InputDecoration(
                                      hintText: l10n.t('hint_message'),
                                      border: const OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                    onChanged: (_) => _handleTextChanged(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 12,
                                  bottom: 12,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color:
                                        _ctrl.text.trim().isEmpty
                                            ? Theme.of(ctx)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.38)
                                            : Theme.of(ctx).colorScheme.primary,
                                  ),
                                  onPressed: () async {
                                    final txt = _ctrl.text.trim();
                                    if (txt.isEmpty) return;

                                    _typingTimer?.cancel();
                                    if (_isTyping) {
                                      _isTyping = false;
                                      ref
                                          .read(chatRepositoryProvider)
                                          .typingStop();
                                    }

                                    final clientId = UuidGenerator.generate();
                                    await ref
                                        .read(chatControllerProvider.notifier)
                                        .send(clientId, txt);
                                    _ctrl.clear();
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
