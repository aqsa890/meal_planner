import 'package:hive/hive.dart';
import 'package:meal_planner/data/models/nutrition_plan.dart';
import 'package:meal_planner/data/models/user_preferences.dart';

class NutritionRepository {
  final Box<UserPreferences> prefsBox;

  NutritionRepository(this.prefsBox);

  NutritionPlan? getNutritionPlan() {
    if (prefsBox.isEmpty) return null;
    final prefs = prefsBox.getAt(0);
    if (prefs == null) return null;

    return _mapToPlan(prefs.goal, prefs.disease);
  }

  NutritionPlan _mapToPlan(String? goal, String? disease) {
    if (goal == "Weight Loss" && disease == "Diabetes") {
      return NutritionPlan(
        goal: goal!,
        disease: disease,
        water: "3.5L / day",
        steps: "10,000 steps",
        exercise: "Light cardio + yoga",
        waterTypes: "Detox water with lemon & cucumber",
      );
    } else if (goal == "Weight Gain" && disease == "Hypertension") {
      return NutritionPlan(
        goal: goal!,
        disease: disease,
        water: "3L / day (low sodium)",
        steps: "7,000 steps",
        exercise: "Strength training + low-intensity cardio",
        waterTypes: "Plain water, avoid energy drinks",
      );
    } else if (goal == "Weight Gain") {
      return NutritionPlan(
        goal: goal!,
        disease: disease,
        water: "4L / day",
        steps: "6,000 steps",
        exercise: "Strength training 4x week",
        waterTypes: "Protein water, normal water",
      );
    } else if (goal == "Maintain") {
      return NutritionPlan(
        goal: goal!,
        disease: disease,
        water: "2.5L / day",
        steps: "8,000 steps",
        exercise: "Balanced mix of cardio & strength",
        waterTypes: "Plain water",
      );
    }

    // fallback
    return NutritionPlan(
      goal: goal ?? "General",
      disease: disease,
      water: "2.5L / day",
      steps: "7,000 steps",
      exercise: "General activity",
      waterTypes: "Plain water",
    );
  }
}
