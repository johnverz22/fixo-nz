import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:mobile/features/onboarding/domain/entities/onboarding_entities.dart';

class OnboardingNotifier extends StateNotifier<int> {
  OnboardingNotifier() : super(0);
  void updatePage(int index) {
    state = index;
  }

  void nextPage(
    PageController pageController,
  ) {
    if (state < onboardingRepository.getOnboarding().length - 1) {
      pageController.animateToPage(
        state + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipPage(PageController pageController) {
    pageController.animateToPage(
        onboardingRepository.getOnboarding().length - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut);
  }
}

final onboardingRepository = OnboardingRepositoryImpl();
final onboardingProvider = StateNotifierProvider<OnboardingNotifier, int>(
  (ref) => OnboardingNotifier(),
);
final onboardingDataProvider = Provider<List<OnboardingEntities>>(
  (ref) => onboardingRepository.getOnboarding(),
);
