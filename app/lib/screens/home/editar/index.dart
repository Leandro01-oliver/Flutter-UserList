import 'package:app/model/user/index.dart';
import 'package:app/repositorye/userRepositorye.dart';
import 'package:app/service/userService.dart';
import 'package:flutter/material.dart';

class EditarUser extends StatefulWidget {
  final User user;

  EditarUser({required this.user});

  @override
  State<EditarUser> createState() => _EditarUserState();
}

class _EditarUserState extends State<EditarUser> {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final UserRepository userRepository = UserRepository();
  late UserService userService;

  @override
  void initState() {
    super.initState();
    controllerName.text = widget.user.name;
    controllerEmail.text = widget.user.email;
  }

  void _updateUser() {
    final id = widget.user.id;
    final nome = controllerName.text.trim();
    final email = controllerEmail.text.trim();

    final userRepository = UserRepository();
    final userService = UserService(userRepository: userRepository);

    User user = User(id: id, email: email, name: nome);

    if (nome != "" && email != "") {
      userService.updateUser(user).then((_) {
          Navigator.pop(context, true);
      }).catchError((error) {
        Navigator.pop(context, false); 
      });
    } else {
      Navigator.pop(context, false); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de edição de usuário'),
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
        onPressed: _updateUser,
        child: Center(child: Text('Salvar')),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
    );
  }
}
