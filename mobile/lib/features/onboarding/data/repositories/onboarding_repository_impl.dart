import 'package:mobile/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mobile/features/onboarding/domain/entities/onboarding_entities.dart';


class OnboardingRepositoryImpl implements OnboardingRepository{
  @override
  List<OnboardingEntities> getOnboarding() {
    return [
      OnboardingEntities(
        image: 'assets/images/onboarding1.png', 
        title: 'Find Reliable Tradies for Your Home Projects, Instantly!', 
        description: 'Easily connect with skilled professionals for quick, high-quality fixes and renovations.'),

      OnboardingEntities(
        image: 'assets/images/onboarding4.png', 
        title: 'Why FIXO is the Smart Choice', 
        description: 'FIXO provides a transparent, secure, and efficient way to hire skilled tradies.'),

      OnboardingEntities(
        image: 'assets/images/onboarding3.png', 
        title: 'Post. Connect. Get It Done.', 
        description: 'Post a job, get matched with trusted professionals, and complete your project hassle-free.'),
    ];
  }

}