import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:mobile/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:mobile/core/providers/http_client_provider.dart';
import 'package:mobile/features/authentication/domain/entities/user.dart';
import 'package:mobile/features/authentication/domain/usecases/login_usecase.dart';
import 'package:mobile/features/authentication/domain/usecases/register_usecase.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return LoginUseCase(repository);
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return RegisterUseCase(repository);
});

final authRemoteDatasourceProvider = Provider((ref) {
  return AuthRemoteDataSourceImpl(client: ref.read(httpClientProvider));
});

final authRepositoryProvider = Provider((ref) {
  return AuthRepositoryImpl(remoteDataSource: ref.read(authRemoteDatasourceProvider));
});

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  final registerUseCase = ref.read(registerUseCaseProvider);
  return AuthNotifier (loginUseCase, registerUseCase);
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthNotifier(this.loginUseCase, this.registerUseCase) : super(const AsyncValue.data(null));

  Future<void> login(String email, String password, BuildContext context) async {
    state = const AsyncValue.loading();
    try {
      final user = await loginUseCase(email, password);
      state = AsyncValue.data(user);
      Navigator.pushReplacementNamed(context, user.role == 'tradie' ? '/tradie' : '/homeowner');
    }
    catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> register(String username, String phone, String email, String password, String role, BuildContext context) async {
    state = const AsyncValue.loading();
    try {

      debugPrint("🟡 Sending registration request...");

      final user = await registerUseCase({
        'username': username, 
        'phone': phone, 
        'email': email, 
        'password': password, 
        'role': role});

      debugPrint("✅ Registration successful: $user");
      state = AsyncValue.data(user);

        if(context.mounted){
          Navigator.pushNamed(context, '/login');
        } 
    }
    catch (e, stackTrace) {
      debugPrint("❌ Registration failed: $e");
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void logout() {
    state = const AsyncValue.data(null);
  }

  
}