import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/l10n/l10n.dart';

void main() {
  group('ShuttlersChatLocalizations', () {
    test('should create with English locale', () {
      final l10n = ShuttlersChatLocalizations(const Locale('en'));

      expect(l10n.locale.languageCode, 'en');
    });

    test('should create with French locale', () {
      final l10n = ShuttlersChatLocalizations(const Locale('fr'));

      expect(l10n.locale.languageCode, 'fr');
    });

    test('should translate English strings', () {
      final l10n = ShuttlersChatLocalizations(const Locale('en'));

      expect(l10n.t('title'), 'Trip Chat');
      expect(l10n.t('hint_message'), 'Message...');
      expect(l10n.t('dismiss'), 'Dismiss');
    });

    test('should translate French strings', () {
      final l10n = ShuttlersChatLocalizations(const Locale('fr'));

      expect(l10n.t('title'), 'Chat du trajet');
      expect(l10n.t('hint_message'), 'Message...');
      expect(l10n.t('dismiss'), 'Fermer');
    });

    test('should support parameter substitution', () {
      final l10n = ShuttlersChatLocalizations(const Locale('en'));

      expect(
        l10n.t('user_typing', params: {'name': 'John'}),
        'John is typing...',
      );
    });

    test('should support multiple parameter substitution', () {
      final l10n = ShuttlersChatLocalizations(const Locale('en'));

      expect(
        l10n.t('users_typing', params: {'names': 'John and Jane'}),
        'John and Jane are typing...',
      );
    });

    test('should fallback to English for unsupported locale', () {
      final l10n = ShuttlersChatLocalizations(const Locale('es'));

      expect(l10n.t('title'), 'Trip Chat');
    });

    test('should return key if translation not found', () {
      final l10n = ShuttlersChatLocalizations(const Locale('en'));

      expect(l10n.t('nonexistent_key'), 'nonexistent_key');
    });

    test('should handle French parameter substitution', () {
      final l10n = ShuttlersChatLocalizations(const Locale('fr'));

      expect(
        l10n.t('user_typing', params: {'name': 'Jean'}),
        "Jean est en train d'ecrire...",
      );
    });

    test('should handle error prefix translation', () {
      final l10n = ShuttlersChatLocalizations(const Locale('en'));

      expect(l10n.t('error_prefix'), 'Error: ');
    });

    test('should handle French error prefix', () {
      final l10n = ShuttlersChatLocalizations(const Locale('fr'));

      expect(l10n.t('error_prefix'), 'Erreur : ');
    });

    test('should have supported locales', () {
      expect(
        ShuttlersChatLocalizations.supportedLocales,
        containsAll([const Locale('en'), const Locale('fr')]),
      );
    });
  });

  group('ShuttlersChatLocalizationsDelegate', () {
    const delegate = ShuttlersChatLocalizationsDelegate();

    test('should support English locale', () {
      expect(delegate.isSupported(const Locale('en')), isTrue);
    });

    test('should support French locale', () {
      expect(delegate.isSupported(const Locale('fr')), isTrue);
    });

    test('should not support unsupported locale', () {
      expect(delegate.isSupported(const Locale('es')), isFalse);
      expect(delegate.isSupported(const Locale('de')), isFalse);
    });

    test('should load localizations', () async {
      final l10n = await delegate.load(const Locale('en'));

      expect(l10n, isA<ShuttlersChatLocalizations>());
      expect(l10n.locale.languageCode, 'en');
    });

    test('should not reload', () {
      const oldDelegate = ShuttlersChatLocalizationsDelegate();

      expect(delegate.shouldReload(oldDelegate), isFalse);
    });
  });
}
