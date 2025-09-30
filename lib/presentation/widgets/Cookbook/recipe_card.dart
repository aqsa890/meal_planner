// lib/views/widgets/recipe_card.dart
import 'package:flutter/material.dart';
import 'package:meal_planner/data/models/recipe_model.dart';
import 'package:meal_planner/presentation/widgets/Cookbook/calorie_badge.dart';
import 'package:meal_planner/presentation/widgets/Cookbook/dietary_tag_badge.dart';
import 'package:meal_planner/presentation/widgets/Cookbook/favourites_button.dart';
import 'package:meal_planner/presentation/widgets/Cookbook/macros_row.dart';
import 'package:meal_planner/presentation/widgets/Cookbook/time_indicator.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const RecipeCard({
    Key? key,
    required this.recipe,
    required this.onTap,
    required this.onFavoriteToggle,
  }) : super(key: key);

  Color _getGradientStartColor(int index) {
    final colors = [
      const Color(0xFF6A8E7F),
      const Color(0xFF8B7355),
      const Color(0xFF7B6B8E),
      const Color(0xFF6B8E8B),
    ];
    return colors[index % colors.length];
  }

  Color _getGradientEndColor(int index) {
    final colors = [
      const Color(0xFF4A6E5F),
      const Color(0xFF6B5335),
      const Color(0xFF5B4B6E),
      const Color(0xFF4B6E6B),
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardIndex = recipe.id.hashCode % 4;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background gradient with icon
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _getGradientStartColor(cardIndex),
                      _getGradientEndColor(cardIndex),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    // Icon section
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.restaurant_menu,
                            size: 70,
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),

                    // Info section
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 30,
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Recipe name
                            Text(
                              recipe.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Calories and time
                            Column(
                              children: [
                                Row(
                                  children: [
                                    CalorieBadge(calories: recipe.calories),
                                    const Spacer(),
                                    TimeIndicator(prepTime: recipe.prepTime),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // Macros row
                                MacrosRow(
                                  protein: recipe.protein,
                                  carbs: recipe.carbs,
                                  fat: recipe.fat,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Favorite button
              Positioned(
                top: 8,
                right: 8,
                child: FavoriteButton(
                  isFavorite: recipe.isFavorite,
                  onToggle: onFavoriteToggle,
                ),
              ),

              // Dietary tag badge
              if (recipe.dietaryTags.isNotEmpty)
                Positioned(
                  top: 8,
                  left: 8,
                  child: DietaryTagBadge(
                    tag: recipe.dietaryTags.first,
                    color: _getGradientEndColor(cardIndex),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
