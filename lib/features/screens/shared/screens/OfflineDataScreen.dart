import 'package:flutter/material.dart';
import 'package:agent360/services/offline_storage_service.dart';
import 'package:agent360/services/sync_service.dart';

class OfflineDataScreen extends StatefulWidget {
  const OfflineDataScreen({super.key});

  @override
  State<OfflineDataScreen> createState() => _OfflineDataScreenState();
}

class _OfflineDataScreenState extends State<OfflineDataScreen> {
  List<Map<String, dynamic>> _customers = [];
  List<Map<String, dynamic>> _offlineActions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOfflineData();
  }

  Future<void> _loadOfflineData() async {
    setState(() => _isLoading = true);
    
    try {
      _customers = await OfflineStorageService.getCustomers();
      _offlineActions = await OfflineStorageService.getOfflineActions();
    } catch (e) {
      print('Error loading offline data: $e');
    }
    
    setState(() => _isLoading = false);
  }

  Future<void> _syncData() async {
    final syncService = SyncService();
    await syncService.manualSync();
    await _loadOfflineData();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sync completed!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Data'),
        backgroundColor: const Color(0xFFB62025),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _syncData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadOfflineData,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildOfflineActionsCard(),
                  const SizedBox(height: 16),
                  _buildCustomersCard(),
                ],
              ),
            ),
    );
  }

  Widget _buildOfflineActionsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.cloud_upload, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  'Pending Sync Actions (${_offlineActions.length})',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_offlineActions.isEmpty)
              const Text(
                'No pending actions',
                style: TextStyle(color: Colors.grey),
              )
            else
              ..._offlineActions.map((action) => ListTile(
                leading: const Icon(Icons.pending_actions),
                title: Text(action['action'] ?? 'Unknown Action'),
                subtitle: Text(
                  'Created: ${DateTime.parse(action['timestamp']).toString().substring(0, 19)}',
                ),
                trailing: const Icon(Icons.sync, color: Colors.orange),
              )),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomersCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.people, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Cached Customers (${_customers.length})',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_customers.isEmpty)
              const Text(
                'No customers cached',
                style: TextStyle(color: Colors.grey),
              )
            else
              ..._customers.map((customer) => ListTile(
                leading: CircleAvatar(
                  child: Text(
                    customer['customerName']?.substring(0, 1).toUpperCase() ?? '?',
                  ),
                ),
                title: Text(customer['customerName'] ?? 'Unknown'),
                subtitle: Text(customer['businessName'] ?? ''),
                trailing: customer['isOffline'] == true
                    ? const Chip(
                        label: Text('Offline'),
                        backgroundColor: Colors.orange,
                        labelStyle: TextStyle(color: Colors.white),
                      )
                    : const Chip(
                        label: Text('Synced'),
                        backgroundColor: Colors.green,
                        labelStyle: TextStyle(color: Colors.white),
                      ),
              )),
          ],
        ),
      ),
    );
  }
}
