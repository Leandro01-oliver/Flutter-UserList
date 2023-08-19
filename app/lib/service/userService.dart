import '../../model/user/index.dart';
import '../repositorye/userRepositorye.dart';

class UserService {

  final UserRepository userRepository;

  UserService({required this.userRepository});

  Future<List<User>> getAllUsers() async {
    return await userRepository.fetchUsers();
  }

  Future<User> createUser(User user) async{
     return await userRepository.createUser(user);
  }

  Future<User> updateUser(User user) async{
    return await userRepository.updateUser(user);
  }

  Future<dynamic> deleteById(int id) async{
    return await userRepository.deleteById(id);
  }
  
}
