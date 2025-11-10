import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers_live_chat/src/chat_config.dart';
import 'package:shuttlers_live_chat/src/data/services/chat_repository.dart';
import 'package:shuttlers_live_chat/src/state/chat_controller.dart';
import 'package:shuttlers_live_chat/src/state/chat_state.dart';
import 'package:shuttlers_live_chat/src/state/providers.dart';

void main() {
  group('Providers', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    group('chatConfigProvider', () {
      test('should throw UnimplementedError by default', () {
        expect(
          () => container.read(chatConfigProvider),
          throwsA(
            isA<UnimplementedError>().having(
              (e) => e.message,
              'message',
              'Override chatConfigProvider at the page boundary.',
            ),
          ),
        );
      });

      test('should work when overridden', () {
        final config = ShuttlersChatConfig(
          authToken: 'test-token-123456789',
          tripId: 'test-trip',
          username: 'Test User',
        );

        final overriddenContainer = ProviderContainer(
          overrides: [
            chatConfigProvider.overrideWithValue(config),
          ],
        );

        addTearDown(overriddenContainer.dispose);

        final result = overriddenContainer.read(chatConfigProvider);
        expect(result, equals(config));
        expect(result.authToken, 'test-token-123456789');
        expect(result.tripId, 'test-trip');
        expect(result.username, 'Test User');
      });

      test('should work with different config values', () {
        final config1 = ShuttlersChatConfig(
          authToken: 'token-111111111',
          tripId: 'trip-1',
          username: 'User 1',
        );

        final config2 = ShuttlersChatConfig(
          authToken: 'token-222222222',
          tripId: 'trip-2',
          username: 'User 2',
        );

        final container1 = ProviderContainer(
          overrides: [chatConfigProvider.overrideWithValue(config1)],
        );
        final container2 = ProviderContainer(
          overrides: [chatConfigProvider.overrideWithValue(config2)],
        );

        addTearDown(container1.dispose);
        addTearDown(container2.dispose);

        expect(container1.read(chatConfigProvider).tripId, 'trip-1');
        expect(container2.read(chatConfigProvider).tripId, 'trip-2');
      });
    });

    group('chatRepositoryProvider', () {
      test('should throw when chatConfigProvider is not overridden', () {
        expect(
          () => container.read(chatRepositoryProvider),
          throwsA(isA<UnimplementedError>()),
        );
      });

      test('should create ChatRepository when config is provided', () {
        final config = ShuttlersChatConfig(
          authToken: 'test-token-123456789',
          tripId: 'test-trip',
          username: 'Test User',
        );

        final overriddenContainer = ProviderContainer(
          overrides: [
            chatConfigProvider.overrideWithValue(config),
          ],
        );

        addTearDown(overriddenContainer.dispose);

        final repository = overriddenContainer.read(chatRepositoryProvider);
        expect(repository, isA<ChatRepository>());
        expect(repository.config, equals(config));
      });

      test('should return same instance on multiple reads', () {
        final config = ShuttlersChatConfig(
          authToken: 'test-token-123456789',
          tripId: 'test-trip',
          username: 'Test User',
        );

        final overriddenContainer = ProviderContainer(
          overrides: [
            chatConfigProvider.overrideWithValue(config),
          ],
        );

        addTearDown(overriddenContainer.dispose);

        final repository1 = overriddenContainer.read(chatRepositoryProvider);
        final repository2 = overriddenContainer.read(chatRepositoryProvider);
        expect(identical(repository1, repository2), true);
      });

      test('should create different repositories for different configs', () {
        final config1 = ShuttlersChatConfig(
          authToken: 'token-111111111',
          tripId: 'trip-1',
          username: 'User 1',
        );

        final config2 = ShuttlersChatConfig(
          authToken: 'token-222222222',
          tripId: 'trip-2',
          username: 'User 2',
        );

        final container1 = ProviderContainer(
          overrides: [chatConfigProvider.overrideWithValue(config1)],
        );
        final container2 = ProviderContainer(
          overrides: [chatConfigProvider.overrideWithValue(config2)],
        );

        addTearDown(container1.dispose);
        addTearDown(container2.dispose);

        final repo1 = container1.read(chatRepositoryProvider);
        final repo2 = container2.read(chatRepositoryProvider);

        expect(repo1.config.tripId, 'trip-1');
        expect(repo2.config.tripId, 'trip-2');
        expect(identical(repo1, repo2), false);
      });
    });

    group('chatControllerProvider', () {
      test('should be AutoDisposeAsyncNotifierProvider', () {
        expect(
          chatControllerProvider,
          isA<AutoDisposeAsyncNotifierProvider<ChatController, ChatState>>(),
        );
      });

      test('should throw when dependencies are not available', () {
        expect(
          () => container.read(chatControllerProvider),
          throwsA(isA<AsyncError<ChatState>>()),
        );
      });

      test(
        'should create ChatController when all dependencies are provided',
        () async {
          final config = ShuttlersChatConfig(
            authToken: 'test-token-123456789',
            tripId: 'test-trip',
            username: 'Test User',
          );

          final overriddenContainer = ProviderContainer(
            overrides: [
              chatConfigProvider.overrideWithValue(config),
            ],
          );

          addTearDown(overriddenContainer.dispose);

          
          final notifier = overriddenContainer.read(
            chatControllerProvider.notifier,
          );
          expect(notifier, isA<ChatController>());
        },
      );

      test('should be auto-disposed when container is disposed', () {
        final config = ShuttlersChatConfig(
          authToken: 'test-token-123456789',
          tripId: 'test-trip',
          username: 'Test User',
        );

        final overriddenContainer = ProviderContainer(
          overrides: [
            chatConfigProvider.overrideWithValue(config),
          ],
        );

        
        final notifier = overriddenContainer.read(
          chatControllerProvider.notifier,
        );
        expect(notifier, isA<ChatController>());

        
        expect(overriddenContainer.dispose, returnsNormally);
      });
    });

    group('provider dependencies', () {
      test('should have correct dependency chain', () {
        final config = ShuttlersChatConfig(
          authToken: 'test-token-123456789',
          tripId: 'test-trip',
          username: 'Test User',
        );

        final overriddenContainer = ProviderContainer(
          overrides: [
            chatConfigProvider.overrideWithValue(config),
          ],
        );

        addTearDown(overriddenContainer.dispose);

        
        final repository = overriddenContainer.read(chatRepositoryProvider);
        expect(repository.config, equals(config));

        
        final notifier = overriddenContainer.read(
          chatControllerProvider.notifier,
        );
        expect(notifier, isA<ChatController>());
      });

      test('should properly dispose repository when provider is disposed', () {
        final config = ShuttlersChatConfig(
          authToken: 'test-token-123456789',
          tripId: 'test-trip',
          username: 'Test User',
        );

        final overriddenContainer = ProviderContainer(
          overrides: [
            chatConfigProvider.overrideWithValue(config),
          ],
        );

        
        final repository = overriddenContainer.read(chatRepositoryProvider);
        expect(repository, isA<ChatRepository>());

        
        expect(overriddenContainer.dispose, returnsNormally);
      });
    });

    group('provider overrides', () {
      test('should allow multiple overrides', () {
        final config = ShuttlersChatConfig(
          authToken: 'test-token-123456789',
          tripId: 'test-trip',
          username: 'Test User',
        );

        final mockRepo = ChatRepository(config: config);

        final overriddenContainer = ProviderContainer(
          overrides: [
            chatConfigProvider.overrideWithValue(config),
            chatRepositoryProvider.overrideWithValue(mockRepo),
          ],
        );

        addTearDown(overriddenContainer.dispose);

        final resultConfig = overriddenContainer.read(chatConfigProvider);
        final resultRepo = overriddenContainer.read(chatRepositoryProvider);

        expect(resultConfig, equals(config));
        expect(resultRepo, equals(mockRepo));
      });

      test('should maintain independence between containers', () {
        final config1 = ShuttlersChatConfig(
          authToken: 'token-111111111',
          tripId: 'trip-1',
          username: 'User 1',
        );

        final config2 = ShuttlersChatConfig(
          authToken: 'token-222222222',
          tripId: 'trip-2',
          username: 'User 2',
        );

        final container1 = ProviderContainer(
          overrides: [chatConfigProvider.overrideWithValue(config1)],
        );
        final container2 = ProviderContainer(
          overrides: [chatConfigProvider.overrideWithValue(config2)],
        );

        addTearDown(container1.dispose);
        addTearDown(container2.dispose);

        
        expect(container1.read(chatConfigProvider).tripId, 'trip-1');
        expect(container2.read(chatConfigProvider).tripId, 'trip-2');

        final repo1 = container1.read(chatRepositoryProvider);
        final repo2 = container2.read(chatRepositoryProvider);

        expect(repo1.config.tripId, 'trip-1');
        expect(repo2.config.tripId, 'trip-2');
      });
    });
  });
}
