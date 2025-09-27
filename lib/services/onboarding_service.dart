import 'package:hive/hive.dart';
import 'package:meal_planner/data/models/user_preferences.dart';

class OnboardingService {
  static late Box<UserPreferences> _box;
  static const String _boxName = 'userPreferencesBox';

  static Future<void> init() async {
    _box = await Hive.openBox<UserPreferences>(_boxName);
  }

  static bool get isOnboardingCompleted {
    if (_box.isEmpty) return false;
    return _box.getAt(0)?.isOnboardingCompleted ?? false;
  }

  static Future<void> saveUserPreferences({
    required String goal,
    required String disease,
  }) async {
    final prefs = UserPreferences(
      goal: goal,
      disease: disease,
      isOnboardingCompleted: true,
    );

    if (_box.isEmpty) {
      await _box.add(prefs);
    } else {
      await _box.putAt(0, prefs);
    }
  }

  static setOnboardingCompleted() {}
}
