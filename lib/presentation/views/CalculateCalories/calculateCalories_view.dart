import 'package:flutter/material.dart';
import 'package:meal_planner/presentation/views/Dashboard/dashboard_view.dart';

class CalculateCaloriesScreen extends StatefulWidget {
  const CalculateCaloriesScreen({super.key});

  @override
  State<CalculateCaloriesScreen> createState() =>
      _CalculateCaloriesScreenState();
}

class _CalculateCaloriesScreenState extends State<CalculateCaloriesScreen> {
  final _formKey = GlobalKey<FormState>();

  String gender = "Male";
  double weight = 0; // kg
  double height = 0; // cm
  int age = 0;
  String activity = "Sedentary";
  double? resultCalories;

  final List<String> activities = [
    "Sedentary",
    "Light",
    "Moderate",
    "Active",
    "Very Active",
  ];

  double _getActivityFactor(String activity) {
    switch (activity) {
      case "Sedentary":
        return 1.2;
      case "Light":
        return 1.375;
      case "Moderate":
        return 1.55;
      case "Active":
        return 1.725;
      case "Very Active":
        return 1.9;
      default:
        return 1.2;
    }
  }

  void _calculateCalories() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      double bmr;
      if (gender == "Male") {
        bmr = 10 * weight + 6.25 * height - 5 * age + 5;
      } else {
        bmr = 10 * weight + 6.25 * height - 5 * age - 161;
      }

      double tdee = bmr * _getActivityFactor(activity);

      setState(() {
        resultCalories = tdee;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCalculatorDialog();
    });
  }

  void _showCalculatorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final theme = Theme.of(context);
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Calorie Calculator",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Gender
                      DropdownButtonFormField<String>(
                        value: gender,
                        decoration: const InputDecoration(
                          labelText: "Gender",
                          prefixIcon: Icon(Icons.person),
                        ),
                        items: ["Male", "Female"]
                            .map((g) =>
                            DropdownMenuItem(value: g, child: Text(g)))
                            .toList(),
                        onChanged: (value) =>
                            setStateDialog(() => gender = value!),
                      ),

                      const SizedBox(height: 12),

                      // Weight
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Weight (kg)",
                          prefixIcon: Icon(Icons.monitor_weight),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                        value!.isEmpty ? "Enter weight" : null,
                        onSaved: (value) =>
                        weight = double.parse(value ?? "0"),
                      ),

                      const SizedBox(height: 12),

                      // Height
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Height (cm)",
                          prefixIcon: Icon(Icons.height),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                        value!.isEmpty ? "Enter height" : null,
                        onSaved: (value) =>
                        height = double.parse(value ?? "0"),
                      ),

                      const SizedBox(height: 12),

                      // Age
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Age",
                          prefixIcon: Icon(Icons.cake),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                        value!.isEmpty ? "Enter age" : null,
                        onSaved: (value) => age = int.parse(value ?? "0"),
                      ),

                      const SizedBox(height: 12),

                      // Activity
                      DropdownButtonFormField<String>(
                        value: activity,
                        decoration: const InputDecoration(
                          labelText: "Activity Level",
                          prefixIcon: Icon(Icons.fitness_center),
                        ),
                        items: activities
                            .map((a) => DropdownMenuItem(
                            value: a, child: Text(a)))
                            .toList(),
                        onChanged: (value) =>
                            setStateDialog(() => activity = value!),
                      ),

                      const SizedBox(height: 20),

                      // Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          _calculateCalories();
                          setStateDialog(() {});
                        },
                        child: const Text(
                          "Calculate",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Result
                      if (resultCalories != null)
                        Text(
                          "Your daily need: ${resultCalories!.toStringAsFixed(0)} kcal",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Dashboard()),
                          (route) => false, // removes all previous routes
                    );
                  },
                  child: const Text("Close"),
                ),
              ],

            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(); // empty background since dialog shows immediately
  }
}
