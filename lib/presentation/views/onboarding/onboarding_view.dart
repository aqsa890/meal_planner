import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planner/presentation/views/goal_selection/goalSelection_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:meal_planner/presentation/widgets/onboarding_page.dart'; // reusable widget
import 'package:meal_planner/services/onboarding_service.dart';

/// Main Onboarding Screen with PageView
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  // Page controller to manage swiping
  final PageController _pageController = PageController();
  int _currentPage = 0;

  Widget _buildOnboardingPage(int index) {
    switch (index) {
      case 0:
        return const OnboardingPage(
          title: "Plan Your Meals, Stay Healthy",
          subtitle: "Get personalized meal plans tailored to your goals.",
          icon: Icons.restaurant_menu,
        );
      case 1:
        return const OnboardingPage(
          title: "Meals That Care for You",
          subtitle: "Special recommendations for diabetes & hypertension.",
          icon: Icons.favorite,
        );
      case 2:
        return const OnboardingPage(
          title: "Your Personal Meal Notebook",
          subtitle: "Add meals, save notes, and follow healthy suggestions.",
          icon: Icons.note_alt,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // get current theme (light/dark)
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // ---------- PageView (3 screens) with enhanced animations ----------
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 1.0;
                          if (_pageController.position.haveDimensions) {
                            value = _pageController.page! - index;
                            value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                          }

                          return Transform.scale(
                            scale: Curves.easeOut.transform(value),
                            child: Opacity(
                              opacity: value,
                              child: _buildOnboardingPage(index),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // ---------- Smooth page indicator ----------
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: colorScheme.primary,
                    dotColor: colorScheme.onSurface.withOpacity(0.3),
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),

                // ---------- Smooth page indicator ----------
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: colorScheme.primary,
                    dotColor: colorScheme.onSurface.withOpacity(0.3),
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),

                const SizedBox(height: 20),

                // ---------- Button (Next / Get Started) ----------
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.secondary,
                      foregroundColor: colorScheme.onPrimary,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      if (_currentPage == 2) {
                        // Last page → Mark as completed and go to Goal Selection
                        await OnboardingService.setOnboardingCompleted();
                        Get.off(() => const GoalSelectionView());
                      } else {
                        // Next page
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      _currentPage == 2 ? "Get Started" : "Next",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ---------- Skip Button (top-right corner) ----------
            Positioned(
              top: 16,
              right: 24,
              child: TextButton(
                onPressed: () async {
                  // Mark onboarding as completed and skip to Goal Selection
                  await OnboardingService.setOnboardingCompleted();
                  Get.off(() => const GoalSelectionView());
                },
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.onSurface.withOpacity(0.7),
                ),
                child: Text(
                  "Skip",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
