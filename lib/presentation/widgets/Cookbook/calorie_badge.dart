// lib/views/widgets/calorie_badge.dart
import 'package:flutter/material.dart';

class CalorieBadge extends StatelessWidget {
  final int calories;

  const CalorieBadge({super.key, required this.calories});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department,
            size: 12,
            color: Colors.orange[700],
          ),
          const SizedBox(width: 2),
          Text(
            '$calories',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.orange[700],
            ),
          ),
        ],
      ),
    );
  }
}
