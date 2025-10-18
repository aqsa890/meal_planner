// lib/presentation/widgets/Cookbook/ultra_compact_card.dart
import 'package:flutter/material.dart';
import 'package:meal_planner/data/models/recipe_model.dart';

class UltraCompactRecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const UltraCompactRecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  // Get a color based on recipe hash
  Color _getCardColor(BuildContext context) {
    final colors = [
      Theme.of(context).colorScheme.primary,
      const Color(0xFF7C9F37), // secondaryGreen
      const Color(0xFF4DB6AC), // teal
      const Color(0xFFFFB74D), // orange
    ];

    return colors[recipe.id.hashCode % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = _getCardColor(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Color header with fixed small height
            Container(
              height: 64,
              color: cardColor,
              child: Stack(
                children: [
                  // Background icon
                  Center(
                    child: Icon(
                      Icons.restaurant,
                      size: 30,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),

                  // Favorite button - compact version
                  Positioned(
                    top: 4,
                    right: 4,
                    child: InkWell(
                      onTap: onFavoriteToggle,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            recipe.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                recipe.isFavorite
                                    ? Colors.red
                                    : Colors.grey[600],
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Diet tag - compact tag
                  if (recipe.dietaryTags.isNotEmpty)
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          recipe.dietaryTags.first,
                          style: TextStyle(
                            color: cardColor,
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Content area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe name
                    Text(
                      recipe.name,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 2),

                    // Stats row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Calories
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              size: 10,
                              color: Colors.orange[700],
                            ),
                            const SizedBox(width: 1),
                            Text(
                              '${recipe.calories}',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[700],
                              ),
                            ),
                          ],
                        ),

                        // Time
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 10,
                              color: Colors.grey[700],
                            ),
                            const SizedBox(width: 1),
                            Text(
                              '${recipe.prepTime}\'',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 2),

                    // Macros row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _MacroBadge(label: 'P', value: recipe.protein),
                        const SizedBox(width: 2),
                        _MacroBadge(label: 'C', value: recipe.carbs),
                        const SizedBox(width: 2),
                        _MacroBadge(label: 'F', value: recipe.fat),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MacroBadge extends StatelessWidget {
  final String label;
  final int value;

  const _MacroBadge({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (label) {
      case 'P':
        color = const Color(0xFFA5D6A7); // Green
        break;
      case 'C':
        color = const Color(0xFFFFCC80); // Orange
        break;
      case 'F':
        color = const Color(0xFF90CAF9); // Blue
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        '$label:${value}g',
        style: TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}
