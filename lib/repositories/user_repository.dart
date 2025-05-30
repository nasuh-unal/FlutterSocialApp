import 'package:protekno/service/api_service';

import '../models/user_model.dart';

class UserRepository {
  final ApiService api;

  UserRepository(this.api);

  Future<List<User>> getUsers() => api.getUsers();
  Future<User> getUserById(int id) => api.getUserById(id);
}
