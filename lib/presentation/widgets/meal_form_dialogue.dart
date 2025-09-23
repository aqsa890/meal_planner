import 'package:flutter/material.dart';

/// ---------------- Reusable Meal Form Dialog ----------------
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

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(isUpdate ? "Update Meal" : "Add Meal"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Category"),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Meal Name"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: 2,
            ),
            TextField(
              controller: ingredientsController,
              decoration: const InputDecoration(labelText: "Ingredients"),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSubmit({
              "category": categoryController.text,
              "name": nameController.text,
              "description": descriptionController.text,
              "ingredients": ingredientsController.text,
            });
            Navigator.pop(context);
          },
          child: Text(isUpdate ? "Update" : "Add"),
        ),
      ],
    );
  }
}
