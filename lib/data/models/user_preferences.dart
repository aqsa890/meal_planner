import 'package:hive/hive.dart';

part 'user_preferences.g.dart';

@HiveType(typeId: 0)
class UserPreferences extends HiveObject {
  @HiveField(0)
  String? goal; // e.g. "Weight Gain", "Weight Loss", "Maintain"

  @HiveField(1)
  String? disease; // e.g. "Diabetes", "Hypertension"

  @HiveField(2)
  bool isOnboardingCompleted;

  UserPreferences({
    this.goal,
    this.disease,
    this.isOnboardingCompleted = false,
  });
}
