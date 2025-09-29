import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_planner/data/models/tip_model.dart';
// import '../models/tip_model.dart'; // Import your model

/// Service class for managing tips data and Hive operations
/// Handles all database operations for tips
class TipsService {
  // Hive box name for storing tips
  static const String _tipsBoxName = 'tipsBox';

  /// Get the Hive box for tips
  /// Opens the box if not already open
  Future<Box<TipModel>> _getTipsBox() async {
    if (!Hive.isBoxOpen(_tipsBoxName)) {
      return await Hive.openBox<TipModel>(_tipsBoxName);
    }
    return Hive.box<TipModel>(_tipsBoxName);
  }

  /// Initialize and populate tips if the database is empty
  /// Returns all tips from the database
  Future<List<TipModel>> initializeTips() async {
    try {
      final box = await _getTipsBox();

      // If box is empty, populate with default tips
      if (box.isEmpty) {
        await _populateDefaultTips(box);
      }

      // Return all tips as a list
      return box.values.toList();
    } catch (e) {
      debugPrint('Error initializing tips: $e');
      return [];
    }
  }

  /// Populate database with default healthy tips
  Future<void> _populateDefaultTips(Box<TipModel> box) async {
    final defaultTips = [
      TipModel(
        id: '1',
        title: 'Stay Hydrated',
        description:
            'Drink at least 8 glasses of water daily. Proper hydration improves digestion, skin health, and energy levels. Start your day with a glass of water.',
        category: 'Hydration',
        icon: '💧',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '2',
        title: 'Eat Colorful Vegetables',
        description:
            'Include a variety of colorful vegetables in your meals. Different colors provide different nutrients and antioxidants essential for health.',
        category: 'Nutrition',
        icon: '🥗',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '3',
        title: 'Practice Portion Control',
        description:
            'Use smaller plates to naturally reduce portion sizes. This helps prevent overeating while still feeling satisfied after meals.',
        category: 'Nutrition',
        icon: '🍽️',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '4',
        title: 'Get Quality Sleep',
        description:
            'Aim for 7-9 hours of sleep each night. Good sleep improves metabolism, mood, and overall health. Maintain a consistent sleep schedule.',
        category: 'Sleep',
        icon: '😴',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '5',
        title: 'Move Every Hour',
        description:
            'Take short breaks to stretch or walk every hour. This reduces the negative effects of prolonged sitting and improves circulation.',
        category: 'Exercise',
        icon: '🚶',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '6',
        title: 'Eat Mindfully',
        description:
            'Chew slowly and avoid distractions while eating. This helps with digestion and prevents overeating by giving your body time to signal fullness.',
        category: 'Nutrition',
        icon: '🧘',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '7',
        title: 'Add Protein to Every Meal',
        description:
            'Include lean protein sources like chicken, fish, beans, or tofu. Protein helps build muscle, keeps you full longer, and supports metabolism.',
        category: 'Nutrition',
        icon: '🍗',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '8',
        title: 'Limit Processed Foods',
        description:
            'Choose whole, unprocessed foods whenever possible. They contain more nutrients and less added sugar, sodium, and unhealthy fats.',
        category: 'Nutrition',
        icon: '🚫',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '9',
        title: 'Take the Stairs',
        description:
            'Opt for stairs instead of elevators when possible. This simple habit adds extra physical activity to your daily routine.',
        category: 'Exercise',
        icon: '🪜',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '10',
        title: 'Practice Deep Breathing',
        description:
            'Take 5 minutes daily for deep breathing exercises. This reduces stress, lowers blood pressure, and improves mental clarity.',
        category: 'Mental Health',
        icon: '🌬️',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '11',
        title: 'Plan Your Meals',
        description:
            'Prepare a weekly meal plan to ensure balanced nutrition. This saves time, reduces food waste, and helps maintain healthy eating habits.',
        category: 'Nutrition',
        icon: '📝',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '12',
        title: 'Limit Added Sugar',
        description:
            'Reduce consumption of sugary drinks and snacks. Excess sugar contributes to weight gain, diabetes, and other health issues.',
        category: 'Nutrition',
        icon: '🍬',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '13',
        title: 'Include Healthy Fats',
        description:
            'Add sources of healthy fats like avocados, nuts, olive oil, and fatty fish. These support heart health and hormone production.',
        category: 'Nutrition',
        icon: '🥑',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '14',
        title: 'Stretch Daily',
        description:
            'Spend 10 minutes stretching each day. This improves flexibility, reduces muscle tension, and prevents injuries.',
        category: 'Exercise',
        icon: '🤸',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '15',
        title: 'Monitor Your Posture',
        description:
            'Be mindful of your posture, especially when sitting. Good posture prevents back pain and improves breathing and circulation.',
        category: 'Exercise',
        icon: '🪑',
        createdAt: DateTime.now(),
      ),
    ];

    // Add all default tips to Hive box
    for (var tip in defaultTips) {
      await box.add(tip);
    }
  }

  /// Toggle favorite status of a tip
  /// Returns true if operation was successful
  Future<bool> toggleFavorite(String tipId) async {
    try {
      final box = await _getTipsBox();
      final tips = box.values.toList();
      final index = tips.indexWhere((tip) => tip.id == tipId);

      if (index != -1) {
        tips[index].isFavorite = !tips[index].isFavorite;
        await tips[index].save(); // Save changes to Hive
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
      return false;
    }
  }

  /// Get all tips from database
  Future<List<TipModel>> getAllTips() async {
    try {
      final box = await _getTipsBox();
      return box.values.toList();
    } catch (e) {
      debugPrint('Error getting all tips: $e');
      return [];
    }
  }

  /// Get all favorite tips
  Future<List<TipModel>> getFavoriteTips() async {
    try {
      final box = await _getTipsBox();
      return box.values.where((tip) => tip.isFavorite).toList();
    } catch (e) {
      debugPrint('Error getting favorite tips: $e');
      return [];
    }
  }

  /// Get all unique categories from tips
  Future<List<String>> getCategories() async {
    try {
      final box = await _getTipsBox();
      final categories = box.values.map((tip) => tip.category).toSet().toList();
      categories.sort(); // Sort alphabetically
      categories.insert(0, 'All'); // Add "All" option at the beginning
      return categories;
    } catch (e) {
      debugPrint('Error getting categories: $e');
      return ['All'];
    }
  }
}
