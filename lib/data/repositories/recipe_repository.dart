// lib/repositories/recipe_repository.dart
import 'package:hive/hive.dart';
import '../models/recipe_model.dart';

class RecipeRepository {
  static const String recipesBox = 'recipes';
  static const String userPreferencesBox = 'userPreferences';

  // Initialize recipes data
  Future<void> initializeRecipes() async {
    final box = await Hive.openBox<Recipe>(recipesBox);

    if (box.isEmpty) {
      final recipes = _getDefaultRecipes();
      for (var recipe in recipes) {
        await box.put(recipe.id, recipe);
      }
    }
  }

  // Get all recipes
  Future<List<Recipe>> getAllRecipes() async {
    final box = await Hive.openBox<Recipe>(recipesBox);
    return box.values.toList();
  }

  // Get filtered recipes based on user goal and disease
  Future<List<Recipe>> getFilteredRecipes(String goal, String disease) async {
    final box = await Hive.openBox<Recipe>(recipesBox);
    final allRecipes = box.values.toList();

    return allRecipes.where((recipe) {
      bool matchesGoal = recipe.goal == goal;
      bool matchesDisease = recipe.suitableForDiseases.contains(disease);
      return matchesGoal && matchesDisease;
    }).toList();
  }

  // Toggle favorite
  Future<void> toggleFavorite(String recipeId) async {
    final box = await Hive.openBox<Recipe>(recipesBox);
    final recipe = box.get(recipeId);

    if (recipe != null) {
      recipe.isFavorite = !recipe.isFavorite;
      await recipe.save();
    }
  }

  // Get favorite recipes
  Future<List<Recipe>> getFavoriteRecipes() async {
    final box = await Hive.openBox<Recipe>(recipesBox);
    return box.values.where((recipe) => recipe.isFavorite).toList();
  }

  // Get recipe by ID
  Future<Recipe?> getRecipeById(String id) async {
    final box = await Hive.openBox<Recipe>(recipesBox);
    return box.get(id);
  }

  // Save user preferences
  Future<void> saveUserPreferences(String goal, String disease) async {
    final box = await Hive.openBox(userPreferencesBox);
    await box.put('goal', goal);
    await box.put('disease', disease);
  }

  // Get user preferences
  Future<Map<String, String>> getUserPreferences() async {
    final box = await Hive.openBox(userPreferencesBox);
    return {
      'goal': box.get('goal', defaultValue: 'maintain'),
      'disease': box.get('disease', defaultValue: 'none'),
    };
  }

  // Default recipes data
  List<Recipe> _getDefaultRecipes() {
    return [
      // Weight Loss + Diabetes
      Recipe(
        id: 'wl_d_1',
        name: 'Grilled Chicken Salad',
        imageUrl: 'assets/images/grilled_chicken_salad.jpg',
        calories: 320,
        protein: 35,
        fat: 12,
        carbs: 25,
        prepTime: 20,
        servings: 1,
        dietaryTags: ['Lactose free', 'Gluten free', 'High Protein'],
        goal: 'weight-loss',
        suitableForDiseases: ['diabetes', 'hypertension', 'none'],
        ingredients: [
          'Chicken breast - 150g',
          'Mixed greens - 2 cups',
          'Cherry tomatoes - 10 pieces',
          'Cucumber - 1 medium',
          'Olive oil - 1 tbsp',
          'Lemon juice - 2 tbsp',
          'Salt and pepper - to taste',
        ],
        steps: [
          'Season chicken breast with salt, pepper, and herbs.',
          'Grill chicken for 6-7 minutes on each side until cooked through.',
          'Let chicken rest for 5 minutes, then slice.',
          'Wash and chop all vegetables.',
          'Combine greens, tomatoes, and cucumber in a bowl.',
          'Top with sliced chicken.',
          'Drizzle with olive oil and lemon juice.',
          'Season with salt and pepper to taste.',
        ],
      ),
      Recipe(
        id: 'wl_d_2',
        name: 'Vegetable Stir-Fry',
        imageUrl: 'assets/images/vegetable_stirfry.jpg',
        calories: 280,
        protein: 12,
        fat: 10,
        carbs: 38,
        prepTime: 15,
        servings: 1,
        dietaryTags: ['Vegan', 'Dairy free', 'Low fat'],
        goal: 'weight-loss',
        suitableForDiseases: ['diabetes', 'hypertension', 'none'],
        ingredients: [
          'Broccoli - 1 cup',
          'Bell peppers - 1 cup',
          'Carrots - 1 medium',
          'Snap peas - 1/2 cup',
          'Garlic - 2 cloves',
          'Ginger - 1 tsp',
          'Soy sauce - 2 tbsp',
          'Sesame oil - 1 tsp',
        ],
        steps: [
          'Wash and cut all vegetables into bite-sized pieces.',
          'Mince garlic and ginger.',
          'Heat sesame oil in a wok or large pan.',
          'Add garlic and ginger, stir for 30 seconds.',
          'Add harder vegetables (carrots, broccoli) first.',
          'Stir-fry for 3-4 minutes.',
          'Add softer vegetables (peppers, snap peas).',
          'Add soy sauce and stir-fry for 2 more minutes.',
          'Serve hot.',
        ],
      ),

      // Weight Loss + Hypertension
      Recipe(
        id: 'wl_h_1',
        name: 'Baked Salmon with Asparagus',
        imageUrl: 'assets/images/baked_salmon.jpg',
        calories: 340,
        protein: 38,
        fat: 18,
        carbs: 12,
        prepTime: 25,
        servings: 1,
        dietaryTags: ['Gluten free', 'Dairy free', 'Omega-3 rich'],
        goal: 'weight-loss',
        suitableForDiseases: ['hypertension', 'none'],
        ingredients: [
          'Salmon fillet - 150g',
          'Asparagus - 10 spears',
          'Olive oil - 1 tbsp',
          'Lemon - 1/2',
          'Garlic - 2 cloves',
          'Herbs (dill/parsley) - 1 tbsp',
          'Black pepper - to taste',
        ],
        steps: [
          'Preheat oven to 400°F (200°C).',
          'Place salmon on a baking sheet lined with parchment paper.',
          'Arrange asparagus around the salmon.',
          'Drizzle olive oil over salmon and asparagus.',
          'Squeeze lemon juice over everything.',
          'Sprinkle minced garlic, herbs, and pepper.',
          'Bake for 15-18 minutes until salmon is cooked through.',
          'Serve immediately.',
        ],
      ),
      Recipe(
        id: 'wl_h_2',
        name: 'Quinoa Buddha Bowl',
        imageUrl: 'assets/images/buddha_bowl.jpg',
        calories: 360,
        protein: 15,
        fat: 14,
        carbs: 45,
        prepTime: 20,
        servings: 1,
        dietaryTags: ['Vegan', 'Gluten free', 'High fiber'],
        goal: 'weight-loss',
        suitableForDiseases: ['hypertension', 'diabetes', 'none'],
        ingredients: [
          'Quinoa - 1/2 cup cooked',
          'Chickpeas - 1/2 cup',
          'Spinach - 1 cup',
          'Cherry tomatoes - 6 pieces',
          'Avocado - 1/4',
          'Tahini - 1 tbsp',
          'Lemon juice - 1 tbsp',
        ],
        steps: [
          'Cook quinoa according to package instructions.',
          'Roast chickpeas with spices at 400°F for 20 minutes.',
          'Wash and prepare all vegetables.',
          'Arrange quinoa as base in a bowl.',
          'Top with spinach, tomatoes, and chickpeas.',
          'Add sliced avocado.',
          'Mix tahini with lemon juice and drizzle over bowl.',
          'Season to taste.',
        ],
      ),

      // Weight Gain + Diabetes
      Recipe(
        id: 'wg_d_1',
        name: 'Protein Packed Omelette',
        imageUrl: 'assets/images/omelette.jpg',
        calories: 450,
        protein: 38,
        fat: 28,
        carbs: 15,
        prepTime: 15,
        servings: 1,
        dietaryTags: ['High protein', 'Gluten free', 'Low carb'],
        goal: 'weight-gain',
        suitableForDiseases: ['diabetes', 'none'],
        ingredients: [
          'Whole eggs - 3',
          'Egg whites - 2',
          'Cheddar cheese - 30g',
          'Spinach - 1/2 cup',
          'Mushrooms - 1/2 cup',
          'Tomatoes - 1/2 cup',
          'Butter - 1 tbsp',
          'Salt and pepper - to taste',
        ],
        steps: [
          'Beat eggs and egg whites in a bowl.',
          'Season with salt and pepper.',
          'Chop vegetables into small pieces.',
          'Heat butter in a pan over medium heat.',
          'Pour egg mixture into the pan.',
          'Add vegetables on one half.',
          'Sprinkle cheese over vegetables.',
          'Fold omelette in half and cook until set.',
          'Serve hot.',
        ],
      ),
      Recipe(
        id: 'wg_d_2',
        name: 'Chicken and Sweet Potato',
        imageUrl: 'assets/images/chicken_sweet_potato.jpg',
        calories: 520,
        protein: 45,
        fat: 15,
        carbs: 50,
        prepTime: 35,
        servings: 1,
        dietaryTags: ['High protein', 'Dairy free', 'Complex carbs'],
        goal: 'weight-gain',
        suitableForDiseases: ['diabetes', 'hypertension', 'none'],
        ingredients: [
          'Chicken breast - 200g',
          'Sweet potato - 1 large',
          'Broccoli - 1 cup',
          'Olive oil - 1 tbsp',
          'Garlic powder - 1 tsp',
          'Paprika - 1 tsp',
          'Salt and pepper - to taste',
        ],
        steps: [
          'Preheat oven to 425°F (220°C).',
          'Cube sweet potato and toss with olive oil.',
          'Place sweet potato on baking sheet.',
          'Season chicken with spices.',
          'Add chicken to baking sheet.',
          'Bake for 25 minutes.',
          'Steam broccoli for 5 minutes.',
          'Serve chicken with sweet potato and broccoli.',
        ],
      ),

      // Maintain Weight + None
      Recipe(
        id: 'm_n_1',
        name: 'Avocado Toast',
        imageUrl: 'assets/images/avocado_toast.jpg',
        calories: 380,
        protein: 15,
        fat: 20,
        carbs: 35,
        prepTime: 10,
        servings: 1,
        dietaryTags: ['Quick & Easy', 'Vegetarian'],
        goal: 'maintain',
        suitableForDiseases: ['none'],
        ingredients: [
          'Whole wheat bread - 2 slices',
          'Avocado - 1 whole',
          'Eggs - 2',
          'Cherry tomatoes - 4 pieces',
          'Mixed greens - handful',
          'Salt and pepper - to taste',
          'Red pepper flakes - pinch',
        ],
        steps: [
          'Toast bread slices until golden brown.',
          'Mash avocado with salt and pepper.',
          'Fry or poach eggs to your preference.',
          'Spread mashed avocado on toast.',
          'Top with eggs.',
          'Add sliced tomatoes and greens.',
          'Sprinkle with red pepper flakes.',
          'Serve immediately.',
        ],
      ),
      Recipe(
        id: 'm_n_2',
        name: 'Mediterranean Pasta',
        imageUrl: 'assets/images/mediterranean_pasta.jpg',
        calories: 420,
        protein: 18,
        fat: 16,
        carbs: 52,
        prepTime: 20,
        servings: 1,
        dietaryTags: ['Vegetarian', 'Mediterranean'],
        goal: 'maintain',
        suitableForDiseases: ['none'],
        ingredients: [
          'Whole wheat pasta - 80g',
          'Cherry tomatoes - 1 cup',
          'Olives - 1/4 cup',
          'Feta cheese - 30g',
          'Olive oil - 2 tbsp',
          'Garlic - 2 cloves',
          'Basil - fresh, handful',
          'Pine nuts - 1 tbsp',
        ],
        steps: [
          'Cook pasta according to package directions.',
          'Heat olive oil in a pan.',
          'Add minced garlic and sauté for 1 minute.',
          'Add halved cherry tomatoes.',
          'Cook for 3-4 minutes until tomatoes soften.',
          'Drain pasta and add to pan.',
          'Toss with olives and torn basil.',
          'Top with crumbled feta and pine nuts.',
          'Serve warm.',
        ],
      ),
    ];
  }
}
