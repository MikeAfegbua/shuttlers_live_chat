import 'package:example/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:shuttlers_live_chat/shuttlers_live_chat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _form = GlobalKey<FormState>();

  final _authCtrl = TextEditingController();
  final _tripCtrl = TextEditingController(text: 'trip_005');
  final _userCtrl = TextEditingController(text: 'Michael');
  final _avatarCtrl = TextEditingController();

  final _baseCtrl = TextEditingController(
    text: 'https://realtime.chat.qa.onshuttlers.com',
  );
  final _wsCtrl = TextEditingController(
    text: 'wss://realtime.chat.qa.onshuttlers.com/ws',
  );

  bool _obscure = true;

  @override
  void dispose() {
    _authCtrl.dispose();
    _tripCtrl.dispose();
    _userCtrl.dispose();
    _avatarCtrl.dispose();
    _baseCtrl.dispose();
    _wsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const pad = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    final isDark = themeNotifier.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Trip Chat — Demo'),
        actions: [
          IconButton(
            tooltip: isDark ? 'Switch to Light' : 'Switch to Dark',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: themeNotifier.toggleTheme,
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Config', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),

              Padding(
                padding: pad,
                child: TextFormField(
                  controller: _authCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'AuthToken (JWT)',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  validator:
                      (v) =>
                          (v == null || v.trim().length <= 10)
                              ? 'Enter a valid JWT'
                              : null,
                ),
              ),
              Padding(
                padding: pad,
                child: TextFormField(
                  controller: _tripCtrl,
                  decoration: const InputDecoration(labelText: 'Trip ID'),
                  validator:
                      (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
              ),
              Padding(
                padding: pad,
                child: TextFormField(
                  controller: _userCtrl,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator:
                      (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
              ),
              Padding(
                padding: pad,
                child: TextFormField(
                  controller: _avatarCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Avatar URL (optional)',
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Padding(
                padding: pad,
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    label: const Text(
                      'Open Trip Chat',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      if (!(_form.currentState?.validate() ?? false)) return;

                      final config = ShuttlersChatConfig(
                        authToken: _authCtrl.text.trim(),
                        tripId: _tripCtrl.text.trim(),
                        username: _userCtrl.text.trim(),
                        avatarUrl:
                            _avatarCtrl.text.trim().isEmpty
                                ? null
                                : _avatarCtrl.text.trim(),
                        baseUrl: _baseCtrl.text.trim(),
                        wsUrl: _wsCtrl.text.trim(),
                      );

                      await openTripChat<void>(context, config);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
