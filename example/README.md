# Shuttlers Live Chat - Example App

Demo application for testing the `shuttlers_live_chat` package.

## Running the Example

```bash
flutter run
```

## Testing Typing Indicators and Presence

To properly test typing indicators and presence count:

### Option 1: Multiple Devices/Emulators
1. Run the app on multiple devices or emulators
2. Use the same `tripId` but different `username` for each instance
3. Type in one instance and watch the typing indicator appear in others
4. Observe the presence count increase/decrease as you connect/disconnect

### Option 2: Web + Mobile
```bash
flutter run -d chrome
flutter run -d <your-device>
```

### What to Test

1. **Connection State**: WiFi icon should turn green when connected
2. **Presence Count**: Badge shows number of connected users
3. **Typing Indicators**: 
   - Start typing in one instance
   - See "Someone is typing..." in other instances
   - Stops after 2 seconds of inactivity
4. **Messages**: Send and receive messages in real-time
5. **Reconnection**: Disable/enable network to test auto-reconnect

## Configuration

- **Auth Token**: Get a valid JWT token from your backend
- **Trip ID**: Use any trip identifier (default: `trip_001`)
- **Username**: Enter a unique name for each instance
- **Endpoints**: Default points to QA environment
