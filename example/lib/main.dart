import 'package:example/chat_page.dart';
import 'package:example/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shuttlers_live_chat/shuttlers_live_chat.dart';

void main() => runApp(const ChatDemoApp());

class ChatDemoApp extends StatelessWidget {
  const ChatDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeNotifier,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shuttlers Chat Demo',
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: themeNotifier.themeMode,
          localizationsDelegates: const [
            ShuttlersChatLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: ShuttlersChatLocalizations.supportedLocales,
          home: const ChatPage(),
        );
      },
    );
  }
}
