import '../http/user/index.dart';
import '../model/user/index.dart';
import 'Interface/IuserRepositorye.dart';

class UserRepository implements IUserRepository {
  final UserHttpClient userHttpClient = UserHttpClient();

  @override
  Future<List<User>> fetchUsers() async {
    return await userHttpClient.fetchUsers();
  }

  Future<User> createUser(User user) async{
     return await userHttpClient.createUser(user);
  }

    Future<User> updateUser(User user) async{
    return await userHttpClient.updateUser(user);
  }


    Future<dynamic> deleteById(int id) async{
    return await userHttpClient.deleteById(id);
  }

  
  
}
