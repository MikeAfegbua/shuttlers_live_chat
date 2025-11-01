

# Shuttlers Live Chat

A Flutter package for real-time trip chat functionality.

## Features

- JOIN CHAT ROOM
- SEND AND RECEIVE REAL-TIME MESSAGES
- PRESENSE/TYPING INDICATORS
- OFFLINE MESSAGE QUEUING AND RETRIES
- CONNECTION STATUS INDICATOR

## Getting Started

- fvm dart run build_runner build --delete-conflicting-outputs  
- flutter test --coverage && genhtml coverage/lcov.info -o coverage/html 2>&1 | grep "lines"
- See the example app for usage details.

## Architecture

This package follows Clean Architecture principles with clear separation of concerns:

### State Management
- **Riverpod** for dependency injection and reactive state management
- **AsyncNotifier** pattern for handling asynchronous chat state
- Provider overrides for runtime configuration injection

### Data Layer
- **Repository Pattern**: `ChatRepository` orchestrates API and WebSocket communication
- **Models**: Immutable data classes using `freezed` for messages, envelopes, and responses
- **API Client**: RESTful HTTP client for fetching chat history
- **WebSocket Client**: Real-time bidirectional communication with auto-reconnect and exponential backoff

### Domain Layer
- **ChatController**: Message handling logic, delivery status, typing indicators, and presence tracking
- **ChatState**: Immutable state container with freezed unions for loading/error/data states
- **Offline Queue**: Persistent message queue with automatic retry logic on reconnection

### Presentation Layer
- **Material 3 Design**: Custom theme system with light/dark mode support
- **Localization**: Multi-language support (EN/FR) using custom L10n system
- **Reusable Widgets**: Message bubbles, connection indicators, presence badges, typing indicators
- **Responsive UI**: Adaptive layouts with proper keyboard handling

### Key Features
- **Optimistic Updates**: Messages appear instantly with delivery status feedback
- **Connection Resilience**: Auto-reconnect with exponential backoff, offline detection
- **Type Safety**: Leverages Dart's strong typing with freezed and json_serializable
- **Testability**: High test coverage (83%+) with unit tests for all core components
