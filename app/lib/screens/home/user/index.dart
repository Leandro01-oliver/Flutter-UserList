import 'package:app/model/user/index.dart';
import 'package:app/screens/home/editar/index.dart';
import 'package:flutter/material.dart';

import '../../../repositorye/userRepositorye.dart';
import '../../../service/userService.dart';

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onUserState; // Adicionado aqui

  const UserCard({
    required this.user,
    required this.onUserState, // Adicionado aqui
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditarUser(user: user)),
                    ).then((_) {
                      onUserState();
                    });
                  },
                  icon: Icon(Icons.edit),
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () async {
                    final userRepository = UserRepository();
                    final userService = UserService(userRepository: userRepository);
                    try {
                        await userService.deleteById(this.user.id);
                        this.onUserState();
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('ID: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('${user.id}'),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('Name: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text('${user.name}')),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('Email: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text('${user.email}')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  
}
