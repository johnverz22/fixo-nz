import 'package:mobile/features/authentication/domain/entities/user.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> register(Map<String, dynamic> userData) async {
    final userModel = await remoteDataSource.registerUser(userData);
    return User(
      id: userModel.id,
      username: userModel.username,
      email: userModel.email,
      phoneNumber: userModel.phoneNumber,
      role: userModel.role,
      token: userModel.token
    );
  }

  @override
  Future<User> login(String email, String password) async {
    final userModel = await remoteDataSource.loginUser(email, password);
    return User(
      id: userModel.id,
      username: userModel.username,
      email: userModel.email,
      phoneNumber: userModel.phoneNumber,
      role: userModel.role,
      token: userModel.token
    );
  }
}
