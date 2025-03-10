import 'package:flutter/material.dart';
import 'package:mobile/features/authentication/presentation/screens/login_screen.dart';
import 'package:mobile/features/homescreen/presentation/screens/homeowner_screen.dart';
import 'package:mobile/features/homescreen/presentation/screens/tradie_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:mobile/features/authentication/presentation/screens/user_role_screen.dart';
import 'package:mobile/features/authentication/presentation/screens/register_screen.dart';


class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/onBoarding': (context) =>  OnboardingScreen(),
    '/user_role': (context) =>  UserRoleScreen(),
    '/login': (context) =>  LoginScreen(),
    '/register': (context) =>  RegisterScreen(),
    '/homeowner': (context) =>  HomeownerScreen(),
    '/tradie': (context) =>  TradieScreen(),
    
};

}