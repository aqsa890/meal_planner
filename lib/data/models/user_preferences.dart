import 'package:hive/hive.dart';

part 'user_preferences.g.dart';

@HiveType(typeId: 0)
class UserPreferences extends HiveObject {
  @HiveField(0)
  String? goal;

  @HiveField(1)
  String? disease;

  @HiveField(2)
  bool isOnboardingCompleted;

  UserPreferences({
    this.goal,
    this.disease,
    this.isOnboardingCompleted = false,
  });
}
