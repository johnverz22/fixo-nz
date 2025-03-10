import 'package:http/http.dart' as http;
import 'package:mobile/features/authentication/data/model/user_model.dart';
import 'dart:convert';


abstract class AuthRemoteDataSource {
  Future<UserModel> registerUser(Map<String, dynamic> userData);
  Future<UserModel> loginUser(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  AuthRemoteDataSourceImpl({required this.client});

  final String baseUrl = 'http://192.168.110.82:3000/users'; //can be replaced with your mock server(e.g. json live-server)

  @override
  Future<UserModel> registerUser(Map<String, dynamic> userData) async {
    final response = await client.post(
      Uri.parse(baseUrl), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
      );

    if (response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register user: ${response.statusCode}');
    }
  }

  @override
  Future<UserModel> loginUser(String email, String password) async {
    final response = await client.get(Uri.parse('$baseUrl?email=$email'));
    if (response.statusCode == 200) {
      final List<dynamic> users = json.decode(response.body);
      if (users.isNotEmpty && users[0]['password'] == password) {
        return UserModel.fromJson(users[0]);
      } else {
        throw Exception('Invalid credentials');
      }
    } else {
      throw Exception('Failed to login user: ${response.statusCode}');
    }
  }
} 