// lib/views/widgets/time_indicator.dart
import 'package:flutter/material.dart';

class TimeIndicator extends StatelessWidget {
  final int prepTime;

  const TimeIndicator({Key? key, required this.prepTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.schedule, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          '$prepTime min',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
