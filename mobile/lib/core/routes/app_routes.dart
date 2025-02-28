import 'package:flutter/material.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';


class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/onBoarding': (context) =>  OnboardingScreen(),
    '/user_role': (context) =>  OnboardingScreen(),
    
};

}