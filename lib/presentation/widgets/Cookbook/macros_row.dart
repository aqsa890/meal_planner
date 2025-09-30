// lib/views/widgets/macros_row.dart
import 'package:flutter/material.dart';

class MacrosRow extends StatelessWidget {
  final int protein;
  final int carbs;
  final int fat;

  const MacrosRow({
    Key? key,
    required this.protein,
    required this.carbs,
    required this.fat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MacroChip(
          label: 'P',
          value: '${protein}g',
          color: const Color(0xFFA5D6A7),
        ),
        MacroChip(
          label: 'C',
          value: '${carbs}g',
          color: const Color(0xFFFFCC80),
        ),
        MacroChip(label: 'F', value: '${fat}g', color: const Color(0xFF90CAF9)),
      ],
    );
  }
}

class MacroChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const MacroChip({
    Key? key,
    required this.label,
    required this.value,
    required this.color,
  }) : super(key: key);

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
