import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_planner/core/themes/app_theme.dart';
import 'package:meal_planner/presentation/views/Home/home_view.dart';
import 'package:meal_planner/presentation/views/onboarding/onboarding_view.dart';
import 'package:meal_planner/services/onboarding_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await OnboardingService.init(); // initializes Hive box and loads data

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meal Planner",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      //  Decide home screen based on onboarding completion
      home:
          OnboardingService.isOnboardingCompleted
              ? const HomeView() // open home if already completed
              : const OnboardingView(), // otherwise start onboarding
      //  first time shows Onboarding
    );
  }
}
