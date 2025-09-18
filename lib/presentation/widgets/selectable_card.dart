import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionCard({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.shade300,
          width: 2,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color:
              isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
