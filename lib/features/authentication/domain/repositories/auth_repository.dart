import 'package:mobile/features/authentication/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);  
  Future<User> register(Map<String, dynamic> userData);
}