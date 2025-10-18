import 'package:flutter/material.dart';
import 'package:meal_planner/presentation/widgets/meal_card.dart';
import 'package:meal_planner/presentation/widgets/meal_form_dialogue.dart';

/// ---------------- Note-a-Meal Screen ----------------
class NoteAMealScreen extends StatefulWidget {
  const NoteAMealScreen({super.key});

  @override
  State<NoteAMealScreen> createState() => _NoteAMealScreenState();
}

class _NoteAMealScreenState extends State<NoteAMealScreen> {
  final List<Map<String, String>> _meals = [];

  /// Open Add/Edit Meal Dialog
  void _openMealDialog({int? index}) {
    showDialog(
      context: context,
      builder: (_) {
        return MealFormDialog(
          initialMeal: index != null ? _meals[index] : null,
          onSubmit: (meal) {
            setState(() {
              if (index == null) {
                _meals.add(meal);
              } else {
                _meals[index] = meal;
              }
            });
          },
        );
      },
    );
  }

  /// Delete a meal
  void _deleteMeal(int index) {
    setState(() => _meals.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Note-a-Meal"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Wanna note a meal for yourself?",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            /// Meal List
            Expanded(
              child:
                  _meals.isEmpty
                      ? Center(
                        child: Text(
                          "No meals added yet.",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      )
                      : ListView.builder(
                        itemCount: _meals.length,
                        itemBuilder: (context, index) {
                          final meal = _meals[index];
                          return MealCard(
                            meal: meal,
                            onEdit: () => _openMealDialog(index: index),
                            onDelete: () => _deleteMeal(index),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),

      /// Floating Add Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openMealDialog(),
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
