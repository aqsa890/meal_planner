// lib/viewmodels/cookbook_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:meal_planner/data/models/recipe_model.dart';
import 'package:meal_planner/data/repositories/recipe_repository.dart';

class CookbookViewModel extends ChangeNotifier {
  final RecipeRepository _repository = RecipeRepository();

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String _selectedGoal = '';
  String _selectedDisease = '';

  // Initialize and load recipes
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.initializeRecipes();
      final prefs = await _repository.getUserPreferences();
      _selectedGoal = prefs['goal'] ?? 'maintain';
      _selectedDisease = prefs['disease'] ?? 'none';

      await loadRecipes();
    } catch (e) {
      _errorMessage = 'Failed to initialize recipes: $e';
      print('Initialize error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load filtered recipes based on user preferences
  Future<void> loadRecipes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _recipes = await _repository.getFilteredRecipes(
        _selectedGoal,
        _selectedDisease,
      );
      _errorMessage = '';
      print('Loaded ${_recipes.length} recipes');
    } catch (e) {
      _errorMessage = 'Failed to load recipes: $e';
      print('Load recipes error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Toggle favorite status
  Future<void> toggleFavorite(String recipeId) async {
    try {
      print('ViewModel: Toggling favorite for $recipeId');

      // Toggle in repository
      await _repository.toggleFavorite(recipeId);

      // Reload recipes to get updated state
      await loadRecipes();

      print('ViewModel: Favorite toggled successfully');
    } catch (e) {
      _errorMessage = 'Failed to update favorite: $e';
      print('Toggle favorite error: $e');
      notifyListeners();
    }
  }

  // Get recipe by ID
  Future<Recipe?> getRecipeById(String id) async {
    try {
      return await _repository.getRecipeById(id);
    } catch (e) {
      _errorMessage = 'Failed to get recipe: $e';
      notifyListeners();
      return null;
    }
  }

  // Update user preferences
  Future<void> updatePreferences(String goal, String disease) async {
    _selectedGoal = goal;
    _selectedDisease = disease;
    await _repository.saveUserPreferences(goal, disease);
    await loadRecipes();
  }
}
