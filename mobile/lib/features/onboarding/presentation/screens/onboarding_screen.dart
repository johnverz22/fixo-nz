import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:mobile/features/onboarding/presentation/widgets/onboarding_button.dart';

class OnboardingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(onboardingProvider);
    final onboardingData = ref.watch(onboardingDataProvider);
    final pageController = PageController();

    return Scaffold(
      body: Column(children: [
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) =>
                ref.read(onboardingProvider.notifier).updatePage(index),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(onboardingData[index].image),
                  SizedBox(height: 20),
                  Text(
                    onboardingData[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    onboardingData[index].description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OnboardingButton(
              text: 'Skip',
              onPressed: () {
                ref.read(onboardingProvider.notifier).skipPage(pageController);
              },
              isPrimary: false,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.blue,
            ),
            Row(
              children: List.generate(
                onboardingData.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: pageIndex == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
            OnboardingButton(
              text: pageIndex == onboardingData.length - 1
                  ? 'Get Started'
                  : 'Next',
              onPressed: () {
                if (pageIndex == onboardingData.length - 1) {
                  Navigator.pushReplacementNamed(context, '/user_role');
                } else {
                  ref
                      .read(onboardingProvider.notifier)
                      .nextPage(pageController);
                }
              },
              isPrimary: true,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            )
          ],
        ),
        SizedBox(height: 20),
      ]),
    );
  }
}
