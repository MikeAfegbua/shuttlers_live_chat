import 'package:flutter/widgets.dart';
import 'package:shuttlers_live_chat/src/core/theme/chat_theme.dart';

class ChatThemeProvider extends InheritedWidget {
  const ChatThemeProvider({
    required this.theme,
    required super.child,
    super.key,
  });

  final ChatTheme theme;

  static ChatTheme of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ChatThemeProvider>();
    assert(provider != null, 'No ChatThemeProvider found in context');
    return provider!.theme;
  }

  @override
  bool updateShouldNotify(ChatThemeProvider oldWidget) =>
      theme != oldWidget.theme;
}
