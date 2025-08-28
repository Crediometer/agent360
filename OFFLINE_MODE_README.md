# Offline Mode Implementation

This document explains how the offline mode works in the Agent360 Flutter app.

## Features

### 1. **Offline Login**
- Users can login using cached credentials when offline
- The app automatically detects network connectivity
- If no internet connection, it attempts offline login
- Users can manually toggle "Offline Mode" in the login screen

### 2. **Offline Data Storage**
- Customer data is cached locally using Hive database
- Offline actions are queued for later synchronization
- Data persists between app sessions

### 3. **Automatic Sync**
- When internet connection is restored, data automatically syncs
- Users can manually trigger sync from the offline data screen
- Visual indicators show sync status

## How It Works

### Login Flow
1. **Online Login**: Normal API call to authenticate
2. **Offline Login**: Uses cached user credentials
3. **Fallback**: If online fails, automatically tries offline

### Data Management
1. **Online**: Data is sent to server immediately
2. **Offline**: Data is stored locally and queued for sync
3. **Sync**: Queued data is uploaded when connection is restored

### Network Detection
- Uses `connectivity_plus` package to detect network changes
- Automatically switches between online/offline modes
- Shows visual indicators for connection status

## Files Added/Modified

### New Services
- `lib/services/offline_storage_service.dart` - Local data storage
- `lib/services/network_service.dart` - Network connectivity detection
- `lib/services/sync_service.dart` - Data synchronization

### New Widgets
- `lib/widgets/offline_status_widget.dart` - Shows offline/sync status
- `lib/features/screens/shared/screens/OfflineDataScreen.dart` - Offline data viewer

### Modified Files
- `lib/features/screens/Auth/screens/Login.dart` - Added offline login support
- `lib/features/screens/customer/screens/AddCustomerStep1Screen.dart` - Added offline customer creation
- `lib/main.dart` - Initialize offline services

## Usage

### For Users
1. **Offline Login**: Toggle "Offline Mode" in login screen
2. **View Offline Data**: Access offline data screen from profile
3. **Manual Sync**: Use sync button when online

### For Developers
1. **Add Offline Support**: Use `OfflineStorageService` for data caching
2. **Check Network**: Use `NetworkService().isConnected`
3. **Queue Actions**: Use `OfflineStorageService.addOfflineAction()`

## Dependencies Added
- `connectivity_plus: ^5.0.2` - Network connectivity detection
- `hive_flutter: ^1.1.0` - Local database (already present)

## Testing Offline Mode

1. **Enable Airplane Mode** on device
2. **Login with cached credentials**
3. **Create customers** - they'll be saved offline
4. **Disable Airplane Mode** - data will auto-sync
5. **Check offline data screen** to see pending actions

## Benefits

- **No Data Loss**: All actions are preserved offline
- **Seamless Experience**: Automatic fallback to offline mode
- **Visual Feedback**: Clear indicators for connection status
- **Manual Control**: Users can force offline mode if needed
