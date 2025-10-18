import 'package:flutter/material.dart';

/// ---------------- Professional Meal Form Dialog ----------------
class MealFormDialog extends StatefulWidget {
  final Map<String, String>? initialMeal;
  final void Function(Map<String, String>) onSubmit;

  const MealFormDialog({super.key, this.initialMeal, required this.onSubmit});

  @override
  State<MealFormDialog> createState() => _MealFormDialogState();
}

class _MealFormDialogState extends State<MealFormDialog> {
  late final TextEditingController categoryController;
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController ingredientsController;

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController(
      text: widget.initialMeal?["category"] ?? "",
    );
    nameController = TextEditingController(
      text: widget.initialMeal?["name"] ?? "",
    );
    descriptionController = TextEditingController(
      text: widget.initialMeal?["description"] ?? "",
    );
    ingredientsController = TextEditingController(
      text: widget.initialMeal?["ingredients"] ?? "",
    );
  }

  @override
  void dispose() {
    categoryController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    ingredientsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.initialMeal != null;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 30 : 24,
        vertical: isSmallScreen ? 10 : 30,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                isUpdate ? "Update Meal" : "Add Meal",
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: isSmallScreen ? 14 : 18),

              /// Meal Name
              _buildTextField(controller: nameController, label: "Meal Name"),

              /// Category
              _buildTextField(
                controller: categoryController,
                label: "Meal Category",
              ),

              /// Description
              _buildTextField(
                controller: descriptionController,
                label: "Meal Description",
              ),

              /// Ingredients
              _buildTextField(
                controller: ingredientsController,
                label: "Meal Ingredients",
              ),

              SizedBox(height: isSmallScreen ? 12 : 16),

              /// Buttons
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
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
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
                      // Validate that at least the meal name is not empty
                      final name = nameController.text.trim();
                      if (name.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a meal name'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      widget.onSubmit({
                        "category": categoryController.text.trim(),
                        "name": name,
                        "description": descriptionController.text.trim(),
                        "ingredients": ingredientsController.text.trim(),
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      isUpdate ? "Update" : "Save",
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
    );
  }

  /// ---------------- Reusable Custom TextField ----------------
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
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
        ),
      ),
    );
  }
}
