import 'package:mobile/features/authentication/domain/entities/user.dart';
import '../repositories/auth_repository.dart';


class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<User> call(Map<String, dynamic> userData) {
    userData.remove('id');
    return repository.register(userData);
  }
}
