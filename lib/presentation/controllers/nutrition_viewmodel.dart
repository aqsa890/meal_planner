import 'package:flutter/foundation.dart';
import 'package:meal_planner/data/repositories/nutrition_repository.dart';
import '../../data/models/nutrition_plan.dart';

class NutritionViewModel extends ChangeNotifier {
  final NutritionRepository _repository;

  NutritionViewModel(this._repository);

  NutritionPlan? _plan;
  NutritionPlan? get plan => _plan;

  void loadPlan() {
    // Get plan directly from repository (repository itself reads Hive)
    _plan = _repository.getNutritionPlan();
    notifyListeners();
  }

  // void resetPreferences() {
  //   _repository.resetPreferences(); // clears Hive user prefs
  //   _plan = null;
  //   notifyListeners();
  // }
}
