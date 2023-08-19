import 'package:app/screens/home/user/index.dart';
import 'package:flutter/cupertino.dart';

import '../../model/user/index.dart';
class Home extends StatelessWidget {
  final List<User> filteredUsers;
  final VoidCallback onUserState;
  final ScrollController scrollController; // Novo parâmetro aqui

  const Home({
    required this.filteredUsers,
    required this.onUserState,
    required this.scrollController,  // E aqui
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,  // Adicione o ScrollController aqui
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              return UserCard(
                user: filteredUsers[index],
                onUserState: onUserState,
              );
            },
          ),
        ),
      ],
    );
  }
}
