import 'package:flutter/widgets.dart';

class ShuttlersChatLocalizations {
  ShuttlersChatLocalizations(this.locale);
  factory ShuttlersChatLocalizations.of(BuildContext context) {
    return Localizations.of<ShuttlersChatLocalizations>(
          context,
          ShuttlersChatLocalizations,
        ) ??
        ShuttlersChatLocalizations(const Locale('en'));
  }

  final Locale locale;

  static const supportedLocales = [Locale('en'), Locale('fr')];

  static const _values = <String, Map<String, String>>{
    'en': {
      'title': 'Trip Chat',
      'hint_message': 'Message…',
      'dismiss': 'Dismiss',
      'user_typing': '{name} is typing…',
      'users_typing': '{names} are typing…',
      'error_prefix': 'Error: ',
    },
    'fr': {
      'title': 'Chat du trajet',
      'hint_message': 'Message…',
      'dismiss': 'Fermer',
      'user_typing': "{name} est en train d'écrire…",
      'users_typing': '{names} écrivent…',
      'error_prefix': 'Erreur : ',
    },
  };

  String t(String key, {Map<String, String> params = const {}}) {
    final lang = _values[locale.languageCode] ?? _values['en']!;
    var text = lang[key] ?? _values['en']![key] ?? key;
    params.forEach((k, v) => text = text.replaceAll('{$k}', v));
    return text;
  }
}

class ShuttlersChatLocalizationsDelegate
    extends LocalizationsDelegate<ShuttlersChatLocalizations> {
  const ShuttlersChatLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<ShuttlersChatLocalizations> load(Locale locale) async =>
      ShuttlersChatLocalizations(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<dynamic> old) => false;
}
