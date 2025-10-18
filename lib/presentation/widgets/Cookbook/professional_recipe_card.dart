// lib/presentation/widgets/Cookbook/professional_recipe_card.dart
import 'package:flutter/material.dart';
import 'package:meal_planner/data/models/recipe_model.dart';

class ProfessionalRecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const ProfessionalRecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  // Professional green gradient color schemes
  LinearGradient _getCardGradient(int index) {
    final List<LinearGradient> gradients = [
      // Deep Forest Green
      const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF2D5016), Color(0xFF3A6B1E)],
      ),
      // Emerald Green
      const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 38, 167, 104),
          Color.fromARGB(255, 19, 70, 32),
        ],
      ),
      // Sage Green
      const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF6B8E23), Color(0xFF8FBC8F)],
      ),
      // Mint Green
      const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 12, 82, 68),
          Color.fromARGB(255, 28, 158, 18),
        ],
      ),
    ];
    return gradients[index % gradients.length];
  }

  @override
  Widget build(BuildContext context) {
    final cardIndex = recipe.id.hashCode % 4;
    final cardGradient = _getCardGradient(cardIndex);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 3,
      margin: EdgeInsets.zero,
      shadowColor: Colors.black.withOpacity(0.15),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final totalHeight = constraints.maxHeight;
            final headerHeight = totalHeight * 0.33;
            final contentHeight = totalHeight * 0.67 - 8;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Professional gradient header
                Container(
                  height: headerHeight,
                  decoration: BoxDecoration(gradient: cardGradient),
                  child: Stack(
                    children: [
                      // Decorative pattern overlay
                      Positioned.fill(
                        child: CustomPaint(painter: _CirclePatternPainter()),
                      ),

                      // Professional food icon
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.restaurant_menu_rounded,
                            size: headerHeight * 0.35,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // Professional favorite button
                      Positioned(
                        top: 8,
                        right: 8,
                        child: InkWell(
                          onTap: onFavoriteToggle,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                recipe.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    recipe.isFavorite
                                        ? const Color(0xFF2D5016)
                                        : Colors.grey[400],
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Professional diet tag
                      if (recipe.dietaryTags.isNotEmpty)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              recipe.dietaryTags.first.toUpperCase(),
                              style: const TextStyle(
                                color: Color(0xFF2D5016),
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Professional content section
                Container(
                  height: contentHeight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recipe name
                      Text(
                        recipe.name,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[800],
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Stats row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Calories
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2.5),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF34C759,
                                  ).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.local_fire_department,
                                  size: 11,
                                  color: Color(0xFF2D5016),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${recipe.calories}',
                                style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2D5016),
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Text(
                                'cal',
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF6B8E23),
                                ),
                              ),
                            ],
                          ),

                          // Time
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2.5),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    26,
                                    209,
                                    35,
                                  ).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.schedule,
                                  size: 11,
                                  color: Color(0xFF0F9D58),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${recipe.prepTime}',
                                style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 12, 76, 45),
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Text(
                                'min',
                                style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF6B8E23),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Macros badges
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _ProfessionalMacroBadge(
                            label: 'P',
                            value: recipe.protein,
                            color: const Color(0xFF2D5016),
                          ),
                          const SizedBox(width: 4),
                          _ProfessionalMacroBadge(
                            label: 'C',
                            value: recipe.carbs,
                            color: const Color(0xFF6B8E23),
                          ),
                          const SizedBox(width: 4),
                          _ProfessionalMacroBadge(
                            label: 'F',
                            value: recipe.fat,
                            color: const Color(0xFF34C759),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Custom painter for decorative pattern
class _CirclePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.1)
          ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.3), 20, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.7), 15, paint);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.2), 25, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Professional macro badge widget
class _ProfessionalMacroBadge extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _ProfessionalMacroBadge({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.4), width: 1),
      ),
      child: Text(
        '$label ${value}g',
        style: TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
