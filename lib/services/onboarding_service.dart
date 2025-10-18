import 'package:hive/hive.dart';
import 'package:meal_planner/data/models/user_preferences.dart';

class OnboardingService {
  static late Box<UserPreferences> _box;
  static const String _boxName = 'userPreferencesBox';

  static Future<void> init() async {
    try {
      // Check if box is already open
      if (Hive.isBoxOpen(_boxName)) {
        print("UserPreferences box is already open");
        _box = Hive.box<UserPreferences>(_boxName);
      } else {
        print("Opening UserPreferences box");
        _box = await Hive.openBox<UserPreferences>(_boxName);
      }
      print("Box is empty: ${_box.isEmpty}");
      if (_box.isNotEmpty) {
        print(
          "First item onboarding completed: ${_box.getAt(0)?.isOnboardingCompleted}",
        );
      }
    } catch (e) {
      print("Error initializing OnboardingService: $e");
    }
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

  static Future<void> setOnboardingCompleted() async {
    final prefs = UserPreferences(isOnboardingCompleted: true);

    if (_box.isEmpty) {
      await _box.add(prefs);
    } else {
      await _box.putAt(0, prefs);
    }
  }
}
