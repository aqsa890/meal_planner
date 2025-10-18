// lib/models/recipe_model.dart
import 'package:hive/hive.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 3)
class Recipe {
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

  // From JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      calories: json['calories'] as int,
      protein: json['protein'] as int,
      fat: json['fat'] as int,
      carbs: json['carbs'] as int,
      prepTime: json['prepTime'] as int,
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
      servings: json['servings'] as int,
      dietaryTags: List<String>.from(json['dietaryTags']),
      goal: json['goal'] as String,
      suitableForDiseases: List<String>.from(json['suitableForDiseases']),
      isFavorite: false,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'calories': calories,
      'protein': protein,
      'fat': fat,
      'carbs': carbs,
      'prepTime': prepTime,
      'ingredients': ingredients,
      'steps': steps,
      'servings': servings,
      'dietaryTags': dietaryTags,
      'goal': goal,
      'suitableForDiseases': suitableForDiseases,
    };
  }
}
