import 'package:flutter/material.dart';

import 'package:shopping_app/core/routes/app_routes.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_font_weight.dart';
import 'package:shopping_app/core/utils/app_prefs.dart';
import 'package:shopping_app/features/onboarding/data/onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool get _isLastPage => _currentPage == OnboardingData.pages.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    await AppPrefs.completeOnboarding();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.hello,
      (route) => false,
    );
  }

  void _next() {
    if (_isLastPage) {
      _finishOnboarding();
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: OnboardingData.pages.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              final page = OnboardingData.pages[index];
              return Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(page.image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: AppFontWeight.extraBold,
                              color: AppColors.textPrimary,
                              height: 1.2,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            page.subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 48),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 24,
            child: AnimatedOpacity(
              opacity: _isLastPage ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: TextButton(
                onPressed: _finishOnboarding,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: .9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: AppFontWeight.semiBold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 32,
            left: 32,
            right: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dots
                Row(
                  children: List.generate(OnboardingData.pages.length, (index) {
                    final isActive = index == _currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 6),
                      height: 8,
                      width: isActive ? 24 : 8,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.primary
                            : AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  }),
                ),

                // Next/Start Button
                GestureDetector(
                  onTap: _next,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: 60,
                    width: _isLastPage ? 160 : 60,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: .3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: _isLastPage
                          ? const Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: AppFontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          : const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
