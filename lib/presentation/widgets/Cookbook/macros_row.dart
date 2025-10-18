// lib/views/widgets/macros_row.dart
import 'package:flutter/material.dart';

class MacrosRow extends StatelessWidget {
  final int protein;
  final int carbs;
  final int fat;

  const MacrosRow({
    super.key,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  @override
  Widget build(BuildContext context) {
    // More compact layout
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CompactMacroChip(
          label: 'P',
          value: '${protein}g',
          color: const Color(0xFFA5D6A7),
        ),
        CompactMacroChip(
          label: 'C',
          value: '${carbs}g',
          color: const Color(0xFFFFCC80),
        ),
        CompactMacroChip(
          label: 'F',
          value: '${fat}g',
          color: const Color(0xFF90CAF9),
        ),
      ],
    );
  }
}

class MacroChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const MacroChip({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color.withOpacity(0.9),
            ),
          ),
          const SizedBox(width: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

class CompactMacroChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const CompactMacroChip({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Ultra compact design to fix overflow
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: color.withOpacity(0.9),
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
