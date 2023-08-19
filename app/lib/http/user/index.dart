import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/user/index.dart';


class UserHttpClient {
  static const baseUrl = 'http://192.168.0.151:3000/api'; // Define sua URL base aqui

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/user/all'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Falha ao carregar usuários');
    }
  }

  Future<User> createUser(User user) async {

      var response = await http.post(
           Uri.parse('$baseUrl/user/create'),
           headers: {"Content-Type": "application/json"},
           body: json.encode(user.toJson()),
      );

 if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }


    Future<User> updateUser(User user) async {

      var response = await http.post(
           Uri.parse('$baseUrl/user/update'),
           headers: {"Content-Type": "application/json"},
           body: json.encode(user.toJson()),
      );

      if (response.statusCode == 201) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create user');
      }
  }

    Future<dynamic> deleteById(int id) async {

      var response = await http.delete(Uri.parse('$baseUrl/user/delete/${id}'));
      if (response.statusCode == 204) {
        return null;
      } else {
        throw Exception('Failed to create user');
      }
  }
  

}
