import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_planner/core/themes/app_theme.dart';
import 'package:meal_planner/data/models/nutrition_plan.dart';
import 'package:meal_planner/data/models/recipe_model.dart';
import 'package:meal_planner/data/models/tip_model.dart';
import 'package:meal_planner/data/models/user_preferences.dart';
import 'package:meal_planner/presentation/views/Home/home_view.dart';
import 'package:meal_planner/presentation/views/onboarding/onboarding_view.dart';
import 'package:meal_planner/services/onboarding_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // Register Adapters with their updated typeIds
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(UserPreferencesAdapter()); // typeId: 0
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(NutritionPlanAdapter()); // typeId: 1
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(TipModelAdapter()); // typeId: 2
  }
  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(RecipeAdapter()); // typeId: 3
  }

  // Open boxes (must match your code everywhere)
  try {
    print("Opening Hive boxes...");
    await Hive.openBox<UserPreferences>('userPreferencesBox');
    await Hive.openBox<NutritionPlan>('nutritionPlansBox');
    await Hive.openBox<TipModel>('tipsBox');
    await Hive.openBox<Recipe>('recipesBox');
    print("All Hive boxes opened successfully");

    // Since the box is already opened, we can just call init now
    await OnboardingService.init();
    print("OnboardingService initialized");
    print("Onboarding completed: ${OnboardingService.isOnboardingCompleted}");
  } catch (e) {
    print("Error during initialization: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isOnboardingCompleted = OnboardingService.isOnboardingCompleted;
    print("Building MyApp - Onboarding completed: $isOnboardingCompleted");

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meal Planner",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      //  Decide home screen based on onboarding completion
      home:
          isOnboardingCompleted
              ? const HomeView() // open home if already completed
              : const OnboardingView(), // otherwise start onboarding
      //  first time shows Onboarding
    );
  }
}
