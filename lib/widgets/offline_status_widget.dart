import 'package:flutter/material.dart';
import 'package:agent360/services/network_service.dart';
import 'package:agent360/services/sync_service.dart';

class OfflineStatusWidget extends StatefulWidget {
  const OfflineStatusWidget({super.key});

  @override
  State<OfflineStatusWidget> createState() => _OfflineStatusWidgetState();
}

class _OfflineStatusWidgetState extends State<OfflineStatusWidget> {
  final NetworkService _networkService = NetworkService();
  final SyncService _syncService = SyncService();
  
  bool _isConnected = true;
  bool _hasPendingActions = false;
  int _pendingActionsCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeStatus();
    _listenToNetworkChanges();
  }

  Future<void> _initializeStatus() async {
    _isConnected = await _networkService.checkInternetConnection();
    _hasPendingActions = await _syncService.hasPendingActions();
    _pendingActionsCount = await _syncService.getPendingActionsCount();
    setState(() {});
  }

  void _listenToNetworkChanges() {
    _networkService.connectionStatus.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
      
      // Auto-sync when connection is restored
      if (isConnected) {
        _syncService.syncOfflineData();
      }
    });
  }

  Future<void> _manualSync() async {
    if (!_isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No internet connection. Cannot sync.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Syncing offline data...'),
        backgroundColor: Colors.blue,
      ),
    );

    await _syncService.manualSync();
    
    // Refresh status
    await _initializeStatus();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sync completed!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected && !_hasPendingActions) {
      return const SizedBox.shrink(); // Don't show anything when everything is fine
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _isConnected ? Colors.orange : Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            _isConnected ? Icons.cloud_upload : Icons.cloud_off,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _isConnected 
                ? 'Offline data pending sync ($_pendingActionsCount items)'
                : 'You are offline',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (_isConnected && _hasPendingActions)
            TextButton(
              onPressed: _manualSync,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              ),
              child: const Text('Sync Now'),
            ),
        ],
      ),
    );
  }
}
