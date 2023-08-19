import 'package:app/model/user/index.dart';
import 'package:app/repositorye/userRepositorye.dart';
import 'package:app/service/userService.dart';
import 'package:flutter/material.dart';

class CadastrarUser extends StatefulWidget {
  @override
  State<CadastrarUser> createState() => _CadastrarUserState();
}

class _CadastrarUserState extends State<CadastrarUser> {
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController();

  void _createUser() {
    final nome = controllerName.text.trim();
    final email = controllerEmail.text.trim();

    final userRepository = UserRepository();
    final userService = UserService(userRepository: userRepository);

    User user = User(id: 0, email: email, name: nome);

    if (nome.isNotEmpty && email.isNotEmpty) {
      userService.createUser(user).then((value) {
        Navigator.pop(context, true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de cadastro de usuário'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTextField(controller: controllerName, hint: 'Name'),
            SizedBox(height: 16.0),
            _buildTextField(controller: controllerEmail, hint: 'Email'),
            SizedBox(height: 16),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hint,
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: _createUser,
        child: Center(child: Text('Cadastrar')),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
    );
  }
}
