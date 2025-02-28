import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:mobile/features/onboarding/presentation/widgets/onboard_text_button.dart';
import 'package:mobile/features/onboarding/presentation/widgets/onboarding_button.dart';

class OnboardingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(onboardingProvider);
    final onboardingData = ref.watch(onboardingDataProvider);
    final pageController = PageController();

    return Scaffold(
        body: Stack(children: [
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: double.infinity,
          child: Image.asset(
            'assets/images/onboarding_background.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
      Column(children: [
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
                  Transform.translate(
                    offset: Offset(10, -50),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: 380,
                      child: Image.asset(
                        onboardingData[index].image,),
                      
                      ),
                    ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: 350,
                    child: Text(
                    onboardingData[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),
                  
                  SizedBox(height: 10),

                  SizedBox(
                    width: 350,
                    child: Text(
                    onboardingData[index].description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                  
                ],
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OnboardTextButton(
              text: 'Skip', 
              onPressed: () {
                ref.read(onboardingProvider.notifier).skipPage(pageController);
              }
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
              backgroundColor: Color.fromARGB(255, 9, 12, 155),
              foregroundColor: Colors.white,
            )
          ],
        ),
        SizedBox(height: 20),
      ]),
    ]));
  }
}
