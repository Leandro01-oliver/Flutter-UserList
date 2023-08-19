import 'package:app/repositorye/userRepositorye.dart';
import 'package:app/screens/home/cadastro/index.dart';
import 'package:app/service/userService.dart';
import 'package:flutter/material.dart';
import 'model/user/index.dart';
import 'screens/home/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<User> users = [];
  List<User> filteredUsers = [];

  int _limit = 10;
  int _offset = 0;

  @override
  void initState() {
    super.initState();
    users = [];
    filteredUsers = [];
    _loadUsers();
    searchController.addListener(_filterUsers);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadMoreUsers();
      }
    });
  }

  _loadUsers() async {
    final userRepository = UserRepository();
    final userService = UserService(userRepository: userRepository);
    List<User> allUsers = await userService.getAllUsers();

    users = allUsers.sublist(_offset, _offset + _limit);
    setState(() {
      filteredUsers = users;
    });
  }

  _loadMoreUsers() {
    _offset += _limit;

    final userRepository = UserRepository();
    final userService = UserService(userRepository: userRepository);

    userService.getAllUsers().then((allUsers) {
      if (_offset < allUsers.length) {
        int endIndex = (_offset + _limit) < allUsers.length ? _offset + _limit : allUsers.length;
        List<User> moreUsers = allUsers.sublist(_offset, endIndex);

        setState(() {
          users.addAll(moreUsers);
          _filterUsers();
        });
      }
    });
  }

  void _filterUsers() {
    final searchTerm = searchController.text;
    if (searchTerm.isNotEmpty) {
      setState(() {
        filteredUsers = users
            .where((user) =>
                user.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
                user.email.toLowerCase().contains(searchTerm.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filteredUsers = users;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title, textAlign: TextAlign.center)),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadastrarUser()),
                ).then((_) => _loadUsers());
              },
              icon: Icon(Icons.add),
              label: Text('Cadastrar Novo'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                _filterUsers();
              },
              decoration: InputDecoration(
                hintText: 'Pesquisar...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Home(
              filteredUsers: filteredUsers,
              onUserState: _loadUsers,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
