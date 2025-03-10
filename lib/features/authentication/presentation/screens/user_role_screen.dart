import 'package:flutter/material.dart';
import 'package:mobile/features/authentication/presentation/widgets/role_button.dart';

class UserRoleScreen extends StatelessWidget {
  const UserRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select your role')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoleButton(
                icon: 'assets/images/homeowner_icon.png',
                title: "I'm a Homeowner",
                subtitle:
                    'Find qualified tradies for your home improvement projects',
               onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/register',
                    arguments: {'role': 'homeowner'},
                    );
                },
              ),
              RoleButton(
                icon: 'assets/images/tradie_icon.png',
                title: "I'm a Tradie",
                subtitle:
                    'Get instant job opportunities and grow your business.',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/register',
                    arguments: {'role': 'tradie'},
                    );
                },
              ),
            ],
          )),
    );
  }
}
