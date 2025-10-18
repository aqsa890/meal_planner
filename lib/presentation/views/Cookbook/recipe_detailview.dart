// lib/views/screens/recipe_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:meal_planner/data/models/recipe_model.dart';
import 'package:meal_planner/data/repositories/recipe_repository.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  final RecipeRepository _repository = RecipeRepository();
  late Recipe _recipe;
  bool _showIngredients = true;

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe;
  }

  Future<void> _toggleFavorite() async {
    try {
      print('DetailScreen: Toggling favorite for ${_recipe.id}');
      await _repository.toggleFavorite(_recipe.id);

      // Reload the recipe from repository
      final updatedRecipe = await _repository.getRecipeById(_recipe.id);
      if (updatedRecipe != null) {
        setState(() {
          _recipe = updatedRecipe;
        });
        print(
          'DetailScreen: Updated recipe favorite status to ${_recipe.isFavorite}',
        );
      }
    } catch (e) {
      print('DetailScreen: Error toggling favorite: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // App bar with image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.restaurant_menu,
                      size: 100,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _recipe.isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe name
                  Text(
                    _recipe.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Nutritional info
                  Row(
                    children: [
                      _NutritionInfoCard(
                        label: 'Kcal',
                        value: _recipe.calories.toString(),
                        color: const Color(0xFFB39DDB),
                      ),
                      const SizedBox(width: 12),
                      _NutritionInfoCard(
                        label: 'Protein',
                        value: '${_recipe.protein}g',
                        color: const Color(0xFFA5D6A7),
                      ),
                      const SizedBox(width: 12),
                      _NutritionInfoCard(
                        label: 'Fat',
                        value: '${_recipe.fat}g',
                        color: const Color(0xFF90CAF9),
                      ),
                      const SizedBox(width: 12),
                      _NutritionInfoCard(
                        label: 'Carbs',
                        value: '${_recipe.carbs}g',
                        color: const Color(0xFFFFCC80),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Time and servings info
                  Row(
                    children: [
                      _InfoChip(
                        icon: Icons.schedule,
                        label: '${_recipe.prepTime} Min',
                      ),
                      const SizedBox(width: 12),
                      _InfoChip(
                        icon: Icons.restaurant,
                        label:
                            '${_recipe.servings} Serving${_recipe.servings > 1 ? 's' : ''}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Dietary tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        _recipe.dietaryTags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 32),

                  // Toggle buttons
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _TabButton(
                            label: 'Ingredients',
                            isSelected: _showIngredients,
                            onTap:
                                () => setState(() => _showIngredients = true),
                          ),
                        ),
                        Expanded(
                          child: _TabButton(
                            label: 'Steps',
                            isSelected: !_showIngredients,
                            onTap:
                                () => setState(() => _showIngredients = false),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Ingredients or Steps
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child:
                        _showIngredients
                            ? _IngredientsSection(
                              ingredients: _recipe.ingredients,
                            )
                            : _StepsSection(steps: _recipe.steps),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutritionInfoCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _NutritionInfoCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color:
                isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}

class _IngredientsSection extends StatelessWidget {
  final List<String> ingredients;

  const _IngredientsSection({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('ingredients'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ingredients',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...ingredients.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    entry.value,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _StepsSection extends StatelessWidget {
  final List<String> steps;

  const _StepsSection({required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('steps'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Steps',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...steps.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${entry.key + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      entry.value,
                      style: const TextStyle(fontSize: 15, height: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
