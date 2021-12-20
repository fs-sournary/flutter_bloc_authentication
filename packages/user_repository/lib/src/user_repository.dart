import 'package:uuid/uuid.dart';

import 'model/user.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return await Future.delayed(
        const Duration(milliseconds: 300), () => _user = User(id: Uuid().v4()));
  }
}
