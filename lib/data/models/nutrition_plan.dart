import 'package:hive/hive.dart';

part 'nutrition_plan.g.dart';

@HiveType(typeId: 1)
class NutritionPlan extends HiveObject {
  @HiveField(0)
  String goal;

  @HiveField(1)
  String? disease;

  @HiveField(2)
  String water;

  @HiveField(3)
  String steps;

  @HiveField(4)
  String exercise;

  @HiveField(5)
  String waterTypes;

  NutritionPlan({
    required this.goal,
    this.disease,
    required this.water,
    required this.steps,
    required this.exercise,
    required this.waterTypes,
  });
}
