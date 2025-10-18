// lib/views/screens/cookbook_screen.dart
import 'package:flutter/material.dart';
import 'package:meal_planner/data/models/recipe_model.dart';
import 'package:meal_planner/presentation/controllers/cookbook_viewmodel.dart';
import 'package:meal_planner/presentation/views/Cookbook/recipe_detailview.dart';
import 'package:meal_planner/presentation/views/goal_selection/goalSelection_view.dart';
import 'package:meal_planner/presentation/widgets/Cookbook/cookbook_header.dart';
import 'package:meal_planner/presentation/widgets/Cookbook/empty_state.dart';
import 'package:meal_planner/presentation/widgets/Cookbook/professional_recipe_card.dart';
import 'package:meal_planner/presentation/widgets/Cookbook/reset_dialogue.dart';

class CookbookScreen extends StatefulWidget {
  const CookbookScreen({super.key});

  @override
  State<CookbookScreen> createState() => _CookbookScreenState();
}

class _CookbookScreenState extends State<CookbookScreen> {
  final CookbookViewModel _viewModel = CookbookViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.initialize();
    _viewModel.addListener(_onViewModelUpdate);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelUpdate);
    _viewModel.dispose();
    super.dispose();
  }

  void _onViewModelUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _showResetDialog() async {
    final result = await ResetPreferencesDialog.show(context);
    if (result == true) {
      _resetPreferences();
    }
  }

  void _resetPreferences() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => GoalSelectionView()),
      (route) => false,
    );
  }

  void _navigateToRecipeDetail(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(recipe: recipe),
      ),
    ).then((_) {
      _viewModel.loadRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          CookbookHeader(onResetPressed: _showResetDialog),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_viewModel.errorMessage.isNotEmpty) {
      return EmptyState(
        icon: Icons.error_outline,
        title: 'Oops!',
        subtitle: _viewModel.errorMessage,
        action: ElevatedButton(
          onPressed: () => _viewModel.loadRecipes(),
          child: const Text('Retry'),
        ),
      );
    }

    if (_viewModel.recipes.isEmpty) {
      return const EmptyState(
        icon: Icons.restaurant_menu,
        title: 'No recipes available',
        subtitle: 'Try resetting your preferences',
      );
    }

    return RefreshIndicator(
      onRefresh: _viewModel.loadRecipes,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65, // Adjusted for NewRecipeCard
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _viewModel.recipes.length,
        itemBuilder: (context, index) {
          final recipe = _viewModel.recipes[index];
          return ProfessionalRecipeCard(
            recipe: recipe,
            onTap: () => _navigateToRecipeDetail(recipe),
            onFavoriteToggle: () => _viewModel.toggleFavorite(recipe.id),
          );
        },
      ),
    );
  }
}
