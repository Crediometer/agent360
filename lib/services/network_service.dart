import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionStatusController = StreamController<bool>.broadcast();

  Stream<bool> get connectionStatus => _connectionStatusController.stream;
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  Future<void> initialize() async {
    // Check initial connection status
    await _checkConnectionStatus();
    
    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (kIsWeb) {
        // For web, update status directly
        bool wasConnected = _isConnected;
        _isConnected = result != ConnectivityResult.none;
        if (wasConnected != _isConnected) {
          _connectionStatusController.add(_isConnected);
        }
      } else {
        // For mobile, check with DNS lookup
        _checkConnectionStatus();
      }
    });
  }

  Future<void> _checkConnectionStatus() async {
    bool wasConnected = _isConnected;
    
    if (kIsWeb) {
      // For web, use connectivity_plus result directly
      final connectivityResult = await _connectivity.checkConnectivity();
      _isConnected = connectivityResult != ConnectivityResult.none;
    } else {
      // For mobile platforms, use DNS lookup
      try {
        final result = await InternetAddress.lookup('google.com');
        _isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        _isConnected = false;
      }
    }

    // Only emit if status changed
    if (wasConnected != _isConnected) {
      _connectionStatusController.add(_isConnected);
    }
  }

  Future<bool> checkInternetConnection() async {
    if (kIsWeb) {
      // For web, use connectivity_plus result directly
      final connectivityResult = await _connectivity.checkConnectivity();
      _isConnected = connectivityResult != ConnectivityResult.none;
      return _isConnected;
    } else {
      // For mobile platforms, use DNS lookup
      await _checkConnectionStatus();
      return _isConnected;
    }
  }

  void dispose() {
    _connectionStatusController.close();
  }
}
