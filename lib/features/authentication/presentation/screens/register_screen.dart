import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/authentication/presentation/widgets/input_field.dart';
import 'package:mobile/features/authentication/presentation/widgets/submit_button.dart';
import 'package:mobile/features/authentication/presentation/providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  late String role;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    role = args?['role'] ?? 'Unknown'; 
  }


  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InputField(controller: nameController, label: 'Full Name'),
              InputField(
                  controller: phoneController,
                  label: 'Phone',
                  keyboardType: TextInputType.phone),
              InputField(controller: emailController, label: 'Email'),
              InputField(
                  controller: passwordController,
                  label: 'Password',
                  obscureText: true),
              InputField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  obscureText: true),
              const SizedBox(height: 20),
              authState.isLoading
                  ? const CircularProgressIndicator()
                  : SubmitButton(
                      text: 'Register',
                      onPressed: () {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          ref.read(authProvider.notifier).register(
                                nameController.text,
                                phoneController.text,
                                emailController.text,
                                passwordController.text,
                                role,
                                context,
                              );
                        }
                      },
                    ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Already have an account? Login here',
                    style: TextStyle(color: Color.fromARGB(255, 9, 12, 155))),
              ),
            ],
          ),
        ));
  }
}
