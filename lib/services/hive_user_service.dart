import 'package:hive/hive.dart';
import '../models/user_model.dart';

class HiveUserService {
  static const String _boxName = 'users';

  late Box<UserModel> _userBox;

  Future<void> init() async {
    _userBox = Hive.box<UserModel>(_boxName);
  }

  Future<void> addUser(UserModel user) async {
    await _userBox.add(user);
  }

  List<UserModel> getUsers() {
    return _userBox.values.toList();
  }

  Future<void> deleteUser(int index) async {
    await _userBox.deleteAt(index);
  }

  Future<void> clearAllUsers() async {
    await _userBox.clear();
  }

  UserModel? getUserAt(int index) {
    if (index < _userBox.length) {
      return _userBox.getAt(index);
    }
    return null;
  }
}
