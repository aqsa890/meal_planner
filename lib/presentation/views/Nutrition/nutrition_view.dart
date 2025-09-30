import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:meal_planner/data/repositories/nutrition_repository.dart';
import 'package:meal_planner/data/models/nutrition_plan.dart';
import 'package:meal_planner/data/models/user_preferences.dart';
import 'package:meal_planner/presentation/views/goal_selection/goalSelection_view.dart';

class NutritionView extends StatefulWidget {
  const NutritionView({super.key});

  @override
  State<NutritionView> createState() => _NutritionViewState();
}

class _NutritionViewState extends State<NutritionView> {
  NutritionPlan? _plan;

  @override
  void initState() {
    super.initState();
    _loadPlan();
  }

  void _loadPlan() {
    final prefsBox = Hive.box<UserPreferences>('userPreferencesBox');
    final repo = NutritionRepository(prefsBox);

    setState(() {
      _plan = repo.getNutritionPlan();
    });
  }

  Future<void> _confirmResetPreferences() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Reset Preferences"),
          content: const Text(
            "Are you sure you want to reset your preferences? "
            "You will need to complete onboarding again.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Yes, Reset"),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final prefsBox = Hive.box<UserPreferences>('userPreferencesBox');
      await prefsBox.clear();
      Get.offAll(() => const GoalSelectionView());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_plan == null) {
      return const Scaffold(
        body: Center(child: Text("No nutrition plan available")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nutrition Plan"),
        // actions: [
        //   IconButton(icon: const Icon(Icons.refresh), onPressed: _loadPlan),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard("Goal", _plan!.goal, Icons.flag, Colors.deepPurple),
            if (_plan!.disease != null && _plan!.disease!.isNotEmpty)
              _buildCard(
                "Disease",
                _plan!.disease!,
                Icons.healing,
                Colors.redAccent,
              ),
            _buildCard(
              "Water Intake",
              _plan!.water,
              Icons.local_drink,
              Colors.blue,
            ),
            _buildCard(
              "Steps",
              _plan!.steps,
              Icons.directions_walk,
              Colors.green,
            ),
            _buildCard(
              "Exercises",
              _plan!.exercise,
              Icons.fitness_center,
              Colors.orange,
            ),
            _buildCard(
              "Water Types",
              _plan!.waterTypes,
              Icons.local_cafe,
              Colors.teal,
            ),

            const SizedBox(height: 24),

            Center(
              child: ElevatedButton.icon(
                onPressed: _confirmResetPreferences,
                icon: const Icon(Icons.restart_alt),
                label: const Text("Reset Preferences"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String value, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(
          value,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
