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
    final theme = Theme.of(context);
    final isUpdate = widget.initialMeal != null;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title & Subtitle
              Text(
                isUpdate ? "Update Meal" : "Add New Meal",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Fill in the details below to ${isUpdate ? "update" : "add"} your meal",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),

              /// Category
              _buildTextField(
                controller: categoryController,
                label: "Category",
                icon: Icons.category_outlined,
              ),

              /// Meal Name
              _buildTextField(
                controller: nameController,
                label: "Meal Name",
                icon: Icons.fastfood_outlined,
              ),

              /// Description
              _buildTextField(
                controller: descriptionController,
                label: "Description",
                icon: Icons.description_outlined,
                maxLines: 2,
              ),

              /// Ingredients
              _buildTextField(
                controller: ingredientsController,
                label: "Ingredients",
                icon: Icons.restaurant_menu_outlined,
                maxLines: 3,
              ),

              const SizedBox(height: 20),

              /// Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {
                      widget.onSubmit({
                        "category": categoryController.text.trim(),
                        "name": nameController.text.trim(),
                        "description": descriptionController.text.trim(),
                        "ingredients": ingredientsController.text.trim(),
                      });
                      Navigator.pop(context);
                    },
                    icon: Icon(isUpdate ? Icons.save : Icons.add),
                    label: Text(isUpdate ? "Update" : "Add"),
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
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
