// lib/views/widgets/time_indicator.dart
import 'package:flutter/material.dart';

class TimeIndicator extends StatelessWidget {
  final int prepTime;

  const TimeIndicator({super.key, required this.prepTime});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.schedule, size: 12, color: Colors.grey[600]),
        const SizedBox(width: 2),
        Text(
          '$prepTime\'',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
