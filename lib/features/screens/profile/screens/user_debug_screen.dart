import 'package:flutter/material.dart';
import 'package:agent360/models/user_model.dart';
import 'package:agent360/services/hive_user_service.dart';

class UserDebugScreen extends StatefulWidget {
  const UserDebugScreen({super.key});

  @override
  State<UserDebugScreen> createState() => _UserDebugScreenState();
}

class _UserDebugScreenState extends State<UserDebugScreen> {
  final HiveUserService _hiveUserService = HiveUserService();
  List<UserModel> _users = [];

  @override
  void initState() {
    super.initState();
    _hiveUserService.init().then((_) => _loadUsers());
  }

  void _loadUsers() {
    setState(() {
      _users = _hiveUserService.getUsers();
    });
  }

  void _addUser() async {
    await _hiveUserService.addUser(
      UserModel(name: 'User ${_users.length + 1}', email: 'user${_users.length + 1}@email.com'),
    );
    _loadUsers();
  }

  void _deleteUser(int index) async {
    await _hiveUserService.deleteUser(index);
    _loadUsers();
  }

  void _clearAll() async {
    await _hiveUserService.clearAllUsers();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hive User Debug')),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (_, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteUser(index),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _addUser,
            tooltip: 'Add User',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _clearAll,
            tooltip: 'Clear All',
            backgroundColor: Colors.red,
            child: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }
}
