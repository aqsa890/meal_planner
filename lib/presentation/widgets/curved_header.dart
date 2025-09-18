import 'package:flutter/material.dart';
import 'package:meal_planner/core/themes/app_theme.dart';

class CurvedHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBack;

  const CurvedHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipPath(
      clipper: BottomCurveClipper(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        color: AppTheme.primaryGreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (showBack) const BackButton(color: Colors.white),
            // const SizedBox(height: 5),
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom clipper for curved bottom
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
