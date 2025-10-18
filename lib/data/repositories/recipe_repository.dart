// lib/repositories/recipe_repository.dart
import 'package:hive/hive.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../models/recipe_model.dart';

class RecipeRepository {
  static const String recipesBox = 'recipes';
  static const String userPreferencesBox = 'userPreferences';

  // Get recipes box
  Future<Box<Recipe>> _getRecipesBox() async {
    if (!Hive.isBoxOpen(recipesBox)) {
      return await Hive.openBox<Recipe>(recipesBox);
    }
    return Hive.box<Recipe>(recipesBox);
  }

  // Get preferences box
  Future<Box> _getPreferencesBox() async {
    if (!Hive.isBoxOpen(userPreferencesBox)) {
      return await Hive.openBox(userPreferencesBox);
    }
    return Hive.box(userPreferencesBox);
  }

  // Load recipes from JSON file
  Future<List<Recipe>> _loadRecipesFromJson() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/recipes.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> recipesJson = jsonData['recipes'];

      return recipesJson.map((json) => Recipe.fromJson(json)).toList();
    } catch (e) {
      print('Error loading recipes from JSON: $e');
      return [];
    }
  }

  // Initialize recipes from JSON
  Future<void> initializeRecipes() async {
    final box = await _getRecipesBox();

    // Only load from JSON if box is empty
    if (box.isEmpty) {
      print('Loading recipes from JSON...');
      final recipes = await _loadRecipesFromJson();

      for (var recipe in recipes) {
        await box.put(recipe.id, recipe);
      }

      print('Loaded ${recipes.length} recipes into Hive');
    } else {
      print('Recipes already exist in Hive: ${box.length} recipes');
    }
  }

  // Reload recipes from JSON (useful for updates)
  Future<void> reloadRecipesFromJson() async {
    final box = await _getRecipesBox();

    print('Reloading recipes from JSON...');
    final recipes = await _loadRecipesFromJson();

    // Clear existing recipes
    await box.clear();

    // Add new recipes
    for (var recipe in recipes) {
      await box.put(recipe.id, recipe);
    }

    print('Reloaded ${recipes.length} recipes');
  }

  // Get all recipes
  Future<List<Recipe>> getAllRecipes() async {
    final box = await _getRecipesBox();
    return box.values.toList();
  }

  // Get filtered recipes based on user goal and disease
  Future<List<Recipe>> getFilteredRecipes(String goal, String disease) async {
    final box = await _getRecipesBox();
    final allRecipes = box.values.toList();

    return allRecipes.where((recipe) {
      bool matchesGoal = recipe.goal == goal;
      bool matchesDisease = recipe.suitableForDiseases.contains(disease);
      return matchesGoal && matchesDisease;
    }).toList();
  }

  // Toggle favorite
  Future<void> toggleFavorite(String recipeId) async {
    try {
      final box = await _getRecipesBox();
      final recipe = box.get(recipeId);

      if (recipe != null) {
        recipe.isFavorite = !recipe.isFavorite;
        await box.put(recipeId, recipe);
      }
    } catch (e) {
      print('Error toggling favorite: $e');
      rethrow;
    }
  }

  // Get favorite recipes
  Future<List<Recipe>> getFavoriteRecipes() async {
    final box = await _getRecipesBox();
    return box.values.where((recipe) => recipe.isFavorite == true).toList();
  }

  // Get recipe by ID
  Future<Recipe?> getRecipeById(String id) async {
    final box = await _getRecipesBox();
    return box.get(id);
  }

  // Save user preferences
  Future<void> saveUserPreferences(String goal, String disease) async {
    final box = await _getPreferencesBox();
    await box.put('goal', goal);
    await box.put('disease', disease);
  }

  // Get user preferences
  Future<Map<String, String>> getUserPreferences() async {
    final box = await _getPreferencesBox();
    return {
      'goal': box.get('goal', defaultValue: 'maintain'),
      'disease': box.get('disease', defaultValue: 'none'),
    };
  }

  // Clear user preferences
  Future<void> clearUserPreferences() async {
    final box = await _getPreferencesBox();
    await box.clear();
  }

  // Clear all data
  Future<void> clearAllData() async {
    final recipesBox = await _getRecipesBox();
    final prefsBox = await _getPreferencesBox();
    await recipesBox.clear();
    await prefsBox.clear();
  }

  // Export recipes to JSON string (for backup)
  Future<String> exportRecipesToJson() async {
    final box = await _getRecipesBox();
    final recipes = box.values.toList();

    final Map<String, dynamic> data = {
      'recipes': recipes.map((r) => r.toJson()).toList(),
    };

    return json.encode(data);
  }
}
