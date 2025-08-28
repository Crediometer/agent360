import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:agent360/features/utils/jwt_utils.dart';

class OfflineStorageService {
  static const String _userBox = 'user_data';
  static const String _customersBox = 'customers_data';
  static const String _transactionsBox = 'transactions_data';
  static const String _depositsBox = 'deposits_data';
  static const String _withdrawalsBox = 'withdrawals_data';
  static const String _offlineActionsBox = 'offline_actions';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    
    await Hive.openBox(_userBox);
    await Hive.openBox(_customersBox);
    await Hive.openBox(_transactionsBox);
    await Hive.openBox(_depositsBox);
    await Hive.openBox(_withdrawalsBox);
    await Hive.openBox(_offlineActionsBox);
  }

  // User data management
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    final box = Hive.box(_userBox);
    await box.put('current_user', jsonEncode(userData));
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final box = Hive.box(_userBox);
    final userData = box.get('current_user');
    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  static Future<void> clearUserData() async {
    final box = Hive.box(_userBox);
    await box.clear();
  }

  // Customer data management
  static Future<void> saveCustomers(List<Map<String, dynamic>> customers) async {
    final box = Hive.box(_customersBox);
    await box.put('customers_list', jsonEncode(customers));
    await box.put('last_sync', DateTime.now().toIso8601String());
  }

  static Future<List<Map<String, dynamic>>> getCustomers() async {
    final box = Hive.box(_customersBox);
    final customers = box.get('customers_list');
    if (customers != null) {
      final List<dynamic> decoded = jsonDecode(customers);
      return decoded.cast<Map<String, dynamic>>();
    }
    return [];
  }

  static Future<void> addCustomerOffline(Map<String, dynamic> customer) async {
    final box = Hive.box(_customersBox);
    final existingCustomers = await getCustomers();
    // Sanitize values to strings for safe storage/rendering
    final sanitized = <String, dynamic>{
      'id': 'offline_${DateTime.now().millisecondsSinceEpoch}',
      'customerName': (customer['customerName'] ?? '').toString(),
      'businessName': (customer['businessName'] ?? '').toString(),
      'location': (customer['location'] ?? '').toString(),
      'email': (customer['email'] ?? '').toString(),
      'phoneNumber': (customer['phoneNumber'] ?? '').toString(),
      'businessSize': (customer['businessSize'] ?? '').toString(),
      'locationContactPhone': customer['locationContactPhone']?.toString(),
      'locationContactEmail': customer['locationContactEmail']?.toString(),
      'isOffline': true,
      'createdAt': DateTime.now().toIso8601String(),
    };
    existingCustomers.add(sanitized);
    await saveCustomers(existingCustomers);
    
    // Add to offline actions queue
    await addOfflineAction('create_customer', {
      // API payload should only include server-expected fields
      'customerName': sanitized['customerName'],
      'businessName': sanitized['businessName'],
      'location': sanitized['location'],
      'email': sanitized['email'],
      'phoneNumber': sanitized['phoneNumber'],
      'businessSize': sanitized['businessSize'],
      'locationContactPhone': sanitized['locationContactPhone'],
      'locationContactEmail': sanitized['locationContactEmail'],
    });
  }

  // Offline actions queue
  static Future<void> addOfflineAction(String action, Map<String, dynamic> data) async {
    final box = Hive.box(_offlineActionsBox);
    final dynamic existing = box.get('pending_actions', defaultValue: []);
    final List<dynamic> actions = existing is List ? List<dynamic>.from(existing) : <dynamic>[];
    actions.add({
      'action': action,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
    });
    await box.put('pending_actions', actions);
  }

  static Future<List<Map<String, dynamic>>> getOfflineActions() async {
    final box = Hive.box(_offlineActionsBox);
    final dynamic existing = box.get('pending_actions', defaultValue: []);
    if (existing is List) {
      return existing.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e as Map)).toList();
    }
    return <Map<String, dynamic>>[];
  }

  static Future<void> clearOfflineActions() async {
    final box = Hive.box(_offlineActionsBox);
    await box.put('pending_actions', []);
  }

  // Check if user can login offline
  static Future<bool> canLoginOffline(String email, String agentCode) async {
    final userData = await getUserData();
    if (userData != null) {
      final storedEmail = userData['email'];
      final storedAgentCode = userData['agentCode'];
      return storedEmail == email && storedAgentCode == agentCode;
    }
    return false;
  }

  // Get last sync time
  static Future<DateTime?> getLastSyncTime(String dataType) async {
    final box = Hive.box(_customersBox);
    final lastSync = box.get('last_sync');
    if (lastSync != null) {
      return DateTime.parse(lastSync);
    }
    return null;
  }

  // Check if data is stale (older than 24 hours)
  static Future<bool> isDataStale(String dataType) async {
    final lastSync = await getLastSyncTime(dataType);
    if (lastSync == null) return true;
    
    final now = DateTime.now();
    final difference = now.difference(lastSync);
    return difference.inHours > 24;
  }

  // Clear all offline data
  static Future<void> clearAllData() async {
    await Hive.box(_userBox).clear();
    await Hive.box(_customersBox).clear();
    await Hive.box(_transactionsBox).clear();
    await Hive.box(_depositsBox).clear();
    await Hive.box(_withdrawalsBox).clear();
    await Hive.box(_offlineActionsBox).clear();
  }
}
