import 'package:example/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shuttlers_live_chat/shuttlers_live_chat.dart';

void main() => runApp(const ChatDemoApp());

class ChatDemoApp extends StatefulWidget {
  const ChatDemoApp({super.key});

  @override
  State<ChatDemoApp> createState() => _ChatDemoAppState();
}

class _ChatDemoAppState extends State<ChatDemoApp> {
  ThemeMode _mode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _mode = (_mode == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final light = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0DAC5C),
      ),
      extensions: [ShuttlersChatTheme.shuttlersBrand(ThemeData.light())],
    );

    final dark = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0DAC5C),
        brightness: Brightness.dark,
      ),
      extensions: [ShuttlersChatTheme.shuttlersBrand(ThemeData.dark())],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shuttlers Chat Demo',
      theme: light,
      darkTheme: dark,
      themeMode: _mode,
      localizationsDelegates: const [
        ShuttlersChatLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: ShuttlersChatLocalizations.supportedLocales,
      home: ChatPage(
        themeMode: _mode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}
