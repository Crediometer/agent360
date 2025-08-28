import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:agent360/features/utils/token_storage.dart';
import 'package:agent360/services/offline_storage_service.dart';
import 'package:agent360/services/network_service.dart';

class SyncService {
  static final SyncService _instance = SyncService._internal();
  factory SyncService() => _instance;
  SyncService._internal();

  bool _isSyncing = false;

  bool get isSyncing => _isSyncing;

  Future<void> syncOfflineData() async {
    if (_isSyncing) return;

    final networkService = NetworkService();
    final isConnected = await networkService.checkInternetConnection();
    
    if (!isConnected) {
      return; // No internet, can't sync
    }

    _isSyncing = true;

    try {
      final token = await getToken();
      if (token == null || token.startsWith('offline_')) {
        // Can't sync with offline token
        return;
      }

      final offlineActions = await OfflineStorageService.getOfflineActions();
      
      for (final action in offlineActions) {
        await _processOfflineAction(action, token);
      }

      // Clear offline actions after successful sync
      await OfflineStorageService.clearOfflineActions();
      
    } catch (e) {
      print('Sync error: $e');
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _processOfflineAction(Map<String, dynamic> action, String token) async {
    try {
      switch (action['action']) {
        case 'create_customer':
          await _syncCreateCustomer(action['data'], token);
          break;
        // Add more action types here as needed
        default:
          print('Unknown offline action: ${action['action']}');
      }
    } catch (e) {
      print('Error processing offline action: $e');
    }
  }

  Future<void> _syncCreateCustomer(Map<String, dynamic> customerData, String token) async {
    try {
      final response = await http.post(
        Uri.parse("https://agent360.onrender.com/api/v1/customers"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(customerData),
      );

      if (response.statusCode == 201) {
        print('Customer synced successfully: ${customerData['customerName']}');
      } else {
        print('Failed to sync customer: ${response.body}');
      }
    } catch (e) {
      print('Error syncing customer: $e');
    }
  }

  // Manual sync trigger
  Future<void> manualSync() async {
    await syncOfflineData();
  }

  // Check if there are pending offline actions
  Future<bool> hasPendingActions() async {
    final actions = await OfflineStorageService.getOfflineActions();
    return actions.isNotEmpty;
  }

  // Get count of pending actions
  Future<int> getPendingActionsCount() async {
    final actions = await OfflineStorageService.getOfflineActions();
    return actions.length;
  }
}
