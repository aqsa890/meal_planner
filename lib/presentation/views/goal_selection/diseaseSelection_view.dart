import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planner/presentation/views/Home/home_view.dart';
import 'package:meal_planner/presentation/widgets/selectable_card.dart';
import 'package:meal_planner/services/onboarding_service.dart';
import 'package:meal_planner/presentation/widgets/curved_header.dart';

class DiseaseSelectionView extends StatefulWidget {
  final String selectedGoal;

  const DiseaseSelectionView({super.key, required this.selectedGoal});

  @override
  State<DiseaseSelectionView> createState() => _DiseaseSelectionViewState();
}

class _DiseaseSelectionViewState extends State<DiseaseSelectionView> {
  String? _selectedDisease;

  final List<Map<String, dynamic>> _diseases = [
    {
      'id': 'diabetes',
      'title': 'Diabetes',
      'subtitle': 'Meals for blood sugar control',
      'icon': Icons.healing,
    },
    {
      'id': 'hypertension',
      'title': 'Hypertension',
      'subtitle': 'Heart-healthy meal plans',
      'icon': Icons.favorite,
    },
    {
      'id': 'none',
      'title': 'None',
      'subtitle': 'No specific condition',
      'icon': Icons.check_circle,
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
              title: "Step 2 of 2",
              subtitle: "Do you have any condition?",
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "This will help us suggest meals suitable for you.",
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _diseases.length,
                        itemBuilder: (context, index) {
                          final disease = _diseases[index];
                          return SelectionCard(
                            id: disease['id'],
                            title: disease['title'],
                            subtitle: disease['subtitle'],
                            icon: disease['icon'],
                            isSelected: _selectedDisease == disease['id'],
                            onTap: () {
                              setState(() {
                                _selectedDisease = disease['id'];
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
                            _selectedDisease != null
                                ? () async {
                                  await OnboardingService.saveUserPreferences(
                                    goal: widget.selectedGoal,
                                    disease: _selectedDisease!,
                                  );
                                  Get.offAll(() => const HomeView());
                                }
                                : null,
                        child: const Text("Finish"),
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
