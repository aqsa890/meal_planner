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
        final screenWidth = MediaQuery.of(context).size.width;
        final isSmallScreen = screenWidth < 400;

        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 30 : 24,
                vertical: isSmallScreen ? 10 : 30,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          "Calorie Calculator",
                          style: TextStyle(
                            fontSize: isSmallScreen ? 20 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 14 : 18),

                        // Gender
                        _buildDropdownField(
                          label: "Gender",
                          value: gender,
                          items: ["Male", "Female"],
                          onChanged:
                              (value) => setStateDialog(() => gender = value!),
                        ),

                        // Weight
                        _buildTextField(
                          label: "Weight (kg)",
                          keyboardType: TextInputType.number,
                          validator:
                              (value) => value!.isEmpty ? "Enter weight" : null,
                          onSaved:
                              (value) => weight = double.parse(value ?? "0"),
                        ),

                        // Height
                        _buildTextField(
                          label: "Height (cm)",
                          keyboardType: TextInputType.number,
                          validator:
                              (value) => value!.isEmpty ? "Enter height" : null,
                          onSaved:
                              (value) => height = double.parse(value ?? "0"),
                        ),

                        // Age
                        _buildTextField(
                          label: "Age",
                          keyboardType: TextInputType.number,
                          validator:
                              (value) => value!.isEmpty ? "Enter age" : null,
                          onSaved: (value) => age = int.parse(value ?? "0"),
                        ),

                        // Activity Level
                        _buildDropdownField(
                          label: "Activity Level",
                          value: activity,
                          items: activities,
                          onChanged:
                              (value) =>
                                  setStateDialog(() => activity = value!),
                        ),

                        SizedBox(height: isSmallScreen ? 12 : 16),

                        // Result
                        if (resultCalories != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF66BB6A).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF66BB6A),
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  "Your Daily Calorie Need",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${resultCalories!.toStringAsFixed(0)} kcal",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF66BB6A),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFFE57373),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 16 : 24,
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Dashboard(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                "Close",
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 15 : 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: isSmallScreen ? 8 : 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF66BB6A),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 24 : 36,
                                  vertical: isSmallScreen ? 14 : 18,
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                _calculateCalories();
                                setStateDialog(() {});
                              },
                              child: Text(
                                "Calculate",
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 15 : 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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

  // Helper method to build text fields with consistent styling
  Widget _buildTextField({
    required String label,
    required TextInputType keyboardType,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF757575), width: 1.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF757575), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF616161), width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
    );
  }

  // Helper method to build dropdown fields with consistent styling
  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF757575), width: 1.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF757575), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF616161), width: 1.5),
          ),
        ),
        items:
            items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                )
                .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
