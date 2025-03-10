import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/authentication/presentation/widgets/input_field.dart';
import 'package:mobile/features/authentication/presentation/widgets/submit_button.dart';
import 'package:mobile/features/authentication/presentation/providers/auth_provider.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(controller: emailController, label: 'Email'),
            SizedBox(height: 16), 
            InputField(controller: passwordController, label: 'Password', obscureText: true),
            SizedBox(height: 24),
            authState.isLoading 
            ? CircularProgressIndicator() 
            : SubmitButton(
              text: 'Login', 
              onPressed: () {
                ref.read(authProvider.notifier).login(emailController.text, passwordController.text, context);
              },
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            }, 
            child: Text(
              'Don\'t have an account? Register here',
              style: TextStyle(color: Color.fromARGB(255, 9, 12, 155))
              ),
        ), 
            
          ],
        ),
      ),
    );
  }
}