// lib/data/models/recipe_model.dart
import 'package:hive/hive.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 2)
class Recipe extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final int calories;

  @HiveField(4)
  final int protein;

  @HiveField(5)
  final int fat;

  @HiveField(6)
  final int carbs;

  @HiveField(7)
  final int prepTime;

  @HiveField(8)
  final List<String> ingredients;

  @HiveField(9)
  final List<String> steps;

  @HiveField(10)
  final int servings;

  @HiveField(11)
  final List<String> dietaryTags;

  @HiveField(12)
  final String goal;

  @HiveField(13)
  final List<String> suitableForDiseases;

  @HiveField(14)
  bool isFavorite;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.prepTime,
    required this.ingredients,
    required this.steps,
    required this.servings,
    required this.dietaryTags,
    required this.goal,
    required this.suitableForDiseases,
    this.isFavorite = false,
  });

  Recipe copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? calories,
    int? protein,
    int? fat,
    int? carbs,
    int? prepTime,
    List<String>? ingredients,
    List<String>? steps,
    int? servings,
    List<String>? dietaryTags,
    String? goal,
    List<String>? suitableForDiseases,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
      carbs: carbs ?? this.carbs,
      prepTime: prepTime ?? this.prepTime,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      servings: servings ?? this.servings,
      dietaryTags: dietaryTags ?? this.dietaryTags,
      goal: goal ?? this.goal,
      suitableForDiseases: suitableForDiseases ?? this.suitableForDiseases,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
