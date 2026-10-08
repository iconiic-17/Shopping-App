import 'package:shopping_app/core/constants/app_assets.dart';

class OnboardingPage {
  const OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;
}

class OnboardingData {
  OnboardingData._();

  static const List<OnboardingPage> pages = [
    OnboardingPage(
      image: AppAssets.onboarding1,
      title: 'Discover something new',
      subtitle:
          'Special new arrivals just for you. Browse thousands of products from top brands.',
    ),
    OnboardingPage(
      image: AppAssets.onboarding2,
      title: 'Update trendy outfit',
      subtitle:
          'Favorite brands and hottest trends. Dress your way with styles that fit you.',
    ),
    OnboardingPage(
      image: AppAssets.onboarding3,
      title: 'Explore your true style',
      subtitle:
          'Relax and let us bring the style to you. Shop easily and get fast delivery.',
    ),
  ];
}
