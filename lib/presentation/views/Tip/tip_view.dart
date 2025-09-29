import 'package:flutter/material.dart';
import 'package:meal_planner/core/themes/app_theme.dart';
import 'package:meal_planner/data/models/tip_model.dart';
import 'package:meal_planner/services/tip_services.dart';
// import '../models/tip_model.dart';
// import '../services/tips_service.dart';
// import '../theme/app_theme.dart'; // Your theme file

/// Main Tips Screen View
/// Displays health tips with filtering and search functionality
/// Uses StatefulWidget without any external state management
class TipsScreen extends StatefulWidget {
  const TipsScreen({Key? key}) : super(key: key);

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  // Service instance for database operations
  final TipsService _tipsService = TipsService();

  // Text controller for search bar
  final TextEditingController _searchController = TextEditingController();

  // State variables
  List<TipModel> _allTips = []; // All tips from database
  List<TipModel> _filteredTips = []; // Filtered tips to display
  List<String> _categories = ['All']; // Available categories
  String _selectedCategory = 'All'; // Currently selected category
  String _searchQuery = ''; // Current search query
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _loadTips(); // Load tips when screen initializes
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Load tips from database and initialize categories
  Future<void> _loadTips() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Initialize tips (will populate if empty)
      _allTips = await _tipsService.initializeTips();

      // Load categories
      _categories = await _tipsService.getCategories();

      // Apply filters to show all tips initially
      _applyFilters();
    } catch (e) {
      debugPrint('Error loading tips: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Apply category and search filters to tips list
  void _applyFilters() {
    setState(() {
      _filteredTips =
          _allTips.where((tip) {
            // Category filter
            final matchesCategory =
                _selectedCategory == 'All' || tip.category == _selectedCategory;

            // Search filter (case-insensitive)
            final matchesSearch =
                _searchQuery.isEmpty ||
                tip.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                tip.description.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                );

            return matchesCategory && matchesSearch;
          }).toList();
    });
  }

  /// Handle search query changes
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFilters();
  }

  /// Handle category selection
  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _applyFilters();
  }

  /// Toggle favorite status of a tip
  Future<void> _toggleFavorite(String tipId) async {
    final success = await _tipsService.toggleFavorite(tipId);

    if (success) {
      // Reload tips to reflect changes
      _allTips = await _tipsService.getAllTips();
      _applyFilters();
    }
  }

  /// Clear all filters and reset to default state
  void _clearFilters() {
    setState(() {
      _selectedCategory = 'All';
      _searchQuery = '';
      _searchController.clear();
    });
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tips'),
        elevation: 0,
        actions: [
          // Filter button
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  // Search bar
                  _buildSearchBar(isDark),

                  // Category chips
                  _buildCategoryChips(isDark),

                  // Tips list
                  Expanded(
                    child:
                        _filteredTips.isEmpty
                            ? _buildEmptyState()
                            : _buildTipsList(),
                  ),
                ],
              ),
    );
  }

  /// Build search bar widget
  Widget _buildSearchBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Search tips...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon:
              _searchController.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _onSearchChanged('');
                    },
                  )
                  : null,
          filled: true,
          fillColor: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  /// Build horizontal scrollable category chips
  Widget _buildCategoryChips(bool isDark) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  _onCategorySelected(category);
                }
              },
              selectedColor: AppTheme.primaryGreen,
              backgroundColor:
                  isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
              labelStyle: TextStyle(
                color:
                    isSelected
                        ? Colors.white
                        : (isDark ? Colors.white70 : Colors.black87),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build tips list with cards
  Widget _buildTipsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredTips.length,
      itemBuilder: (context, index) {
        final tip = _filteredTips[index];
        return _buildTipCard(tip);
      },
    );
  }

  /// Build individual tip card
  Widget _buildTipCard(TipModel tip) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showTipDetails(tip),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon and favorite button
              Row(
                children: [
                  // Icon
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _getCategoryColor(tip.category).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        tip.icon,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Title and category
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tip.title,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(
                              tip.category,
                            ).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            tip.category,
                            style: TextStyle(
                              fontSize: 12,
                              color: _getCategoryColor(tip.category),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Favorite button
                  IconButton(
                    icon: Icon(
                      tip.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: tip.isFavorite ? Colors.red : null,
                    ),
                    onPressed: () => _toggleFavorite(tip.id),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Description
              Text(
                tip.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build empty state when no tips found
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text('No tips found', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _clearFilters,
            icon: const Icon(Icons.refresh),
            label: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }

  /// Show tip details in bottom sheet
  void _showTipDetails(TipModel tip) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Icon and title
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _getCategoryColor(tip.category).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          tip.icon,
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tip.title,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(
                                tip.category,
                              ).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tip.category,
                              style: TextStyle(
                                fontSize: 14,
                                color: _getCategoryColor(tip.category),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Description
                Text(
                  tip.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        label: const Text('Close'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _toggleFavorite(tip.id);
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          tip.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        label: Text(tip.isFavorite ? 'Unfavorite' : 'Favorite'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: AppTheme.secondaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
    );
  }

  /// Show filter options in bottom sheet
  void _showFilterBottomSheet() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter by Category',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      _categories.map((category) {
                        final isSelected = category == _selectedCategory;
                        return FilterChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              _onCategorySelected(category);
                              Navigator.pop(context);
                            }
                          },
                          selectedColor: AppTheme.primaryGreen,
                          backgroundColor:
                              isDark
                                  ? AppTheme.surfaceDark
                                  : AppTheme.surfaceLight,
                          labelStyle: TextStyle(
                            color:
                                isSelected
                                    ? Colors.white
                                    : (isDark
                                        ? Colors.white70
                                        : Colors.black87),
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _clearFilters();
                      Navigator.pop(context);
                    },
                    child: const Text('Clear Filters'),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  /// Get color based on category
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Nutrition':
        return AppTheme.cookbookCard; // Orange
      case 'Exercise':
        return AppTheme.notesCard; // Light blue
      case 'Hydration':
        return AppTheme.caloriesCard; // Teal
      case 'Sleep':
        return AppTheme.mealsCard; // Purple
      case 'Mental Health':
        return AppTheme.recipesCard; // Red
      default:
        return AppTheme.secondaryGreen;
    }
  }
}
