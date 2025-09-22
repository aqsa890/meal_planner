import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Calorie Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Gender
              DropdownButtonFormField<String>(
                value: gender,
                decoration: const InputDecoration(labelText: "Gender"),
                items:
                    ["Male", "Female"]
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                onChanged: (value) => setState(() => gender = value!),
              ),

              // Weight
              TextFormField(
                decoration: const InputDecoration(labelText: "Weight (kg)"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter weight" : null,
                onSaved: (value) => weight = double.parse(value!),
              ),

              // Height
              TextFormField(
                decoration: const InputDecoration(labelText: "Height (cm)"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter height" : null,
                onSaved: (value) => height = double.parse(value!),
              ),

              // Age
              TextFormField(
                decoration: const InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter age" : null,
                onSaved: (value) => age = int.parse(value!),
              ),

              // Activity
              DropdownButtonFormField<String>(
                value: activity,
                decoration: const InputDecoration(labelText: "Activity Level"),
                items:
                    activities
                        .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                        .toList(),
                onChanged: (value) => setState(() => activity = value!),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _calculateCalories,
                child: const Text("Calculate"),
              ),

              const SizedBox(height: 20),

              if (resultCalories != null)
                Text(
                  "Your daily calories need: ${resultCalories!.toStringAsFixed(0)} kcal",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
