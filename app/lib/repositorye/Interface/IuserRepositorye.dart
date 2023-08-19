import '../../model/user/index.dart';

abstract class IUserRepository {
  Future<List<User>> fetchUsers();

   Future<User> createUser(User user);

  Future<User> updateUser(User user);

    Future<dynamic> deleteById(int id);
}
