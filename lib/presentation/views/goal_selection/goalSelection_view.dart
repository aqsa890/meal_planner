import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planner/presentation/views/goal_selection/diseaseSelection_view.dart';
import 'package:meal_planner/presentation/widgets/selectable_card.dart';
import 'package:meal_planner/presentation/widgets/curved_header.dart';

class GoalSelectionView extends StatefulWidget {
  const GoalSelectionView({super.key});

  @override
  State<GoalSelectionView> createState() => _GoalSelectionViewState();
}

class _GoalSelectionViewState extends State<GoalSelectionView> {
  String? _selectedGoal;

  final List<Map<String, dynamic>> _goals = [
    {
      'id': 'weight_loss',
      'title': 'Weight Loss',
      'subtitle': 'Lose weight in a healthy way',
      'icon': Icons.trending_down,
    },
    {
      'id': 'weight_gain',
      'title': 'Weight Gain',
      'subtitle': 'Gain weight with proper nutrition',
      'icon': Icons.trending_up,
    },
    {
      'id': 'maintain',
      'title': 'Maintain Weight',
      'subtitle': 'Keep your current weight',
      'icon': Icons.balance,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: theme.colorScheme.primary),
      body: SafeArea(
        child: Column(
          children: [
            const CurvedHeader(
              title: "Step 1 of 2",
              subtitle: "What's your health goal?",
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "This will help us personalize your meal recommendations.",
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _goals.length,
                        itemBuilder: (context, index) {
                          final goal = _goals[index];
                          return SelectionCard(
                            id: goal['id'],
                            title: goal['title'],
                            subtitle: goal['subtitle'],
                            icon: goal['icon'],
                            isSelected: _selectedGoal == goal['id'],
                            onTap: () {
                              setState(() {
                                _selectedGoal = goal['id'];
                              });
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            _selectedGoal != null
                                ? () {
                                  Get.to(
                                    () => DiseaseSelectionView(
                                      selectedGoal: _selectedGoal!,
                                    ),
                                  );
                                }
                                : null,
                        child: const Text("Continue"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
