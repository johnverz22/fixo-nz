import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';


class HomeownerScreen extends ConsumerWidget {
  const HomeownerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.value;

    return Scaffold(
      appBar: AppBar(
        title: Text('Homeowner Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Center(
        child: user != null ? Text('Welcome, ${user.username}!') : CircularProgressIndicator(),
      ),
    );
  }
}