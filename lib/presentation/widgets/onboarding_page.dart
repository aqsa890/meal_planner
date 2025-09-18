import 'package:flutter/material.dart';

/// A reusable widget for onboarding screens
class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // access theme
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon (colored by theme)
          Icon(icon, size: 120, color: colorScheme.primary),

          const SizedBox(height: 40),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),

          const SizedBox(height: 16),

          // Subtitle
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
