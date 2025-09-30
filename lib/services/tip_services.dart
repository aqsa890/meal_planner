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
      // Exercise Tips
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
        id: '9',
        title: 'Take the Stairs',
        description:
            'Opt for stairs instead of elevators when possible. This simple habit adds extra physical activity to your daily routine.',
        category: 'Exercise',
        icon: '🪜',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '34',
        title: 'Find Activities You Enjoy',
        description:
            'Choose physical activities you genuinely like, whether it\'s dancing, hiking, or sports. You\'re more likely to stick with exercise you enjoy.',
        category: 'Exercise',
        icon: '💃',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '35',
        title: 'Mix Cardio and Strength Training',
        description:
            'Combine aerobic exercise (running, swimming) with strength training (weights, resistance bands) for comprehensive fitness benefits.',
        category: 'Exercise',
        icon: '🏋️',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '36',
        title: 'Set Realistic Fitness Goals',
        description:
            'Start with achievable targets and gradually increase intensity. Small, consistent improvements are more sustainable than drastic changes.',
        category: 'Exercise',
        icon: '🎯',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '37',
        title: 'Warm Up and Cool Down',
        description:
            'Always include 5-10 minutes of warm-up before exercise and cool-down stretches afterward to prevent injuries and aid recovery.',
        category: 'Exercise',
        icon: '🧘',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '38',
        title: 'Track Your Progress',
        description:
            'Use a fitness app or journal to record your workouts. Tracking progress provides motivation and helps you celebrate achievements.',
        category: 'Exercise',
        icon: '📊',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '39',
        title: 'Listen to Your Body',
        description:
            'Pay attention to pain signals and allow adequate rest between intense workouts. Rest days are essential for muscle recovery and growth.',
        category: 'Exercise',
        icon: '👂',
        createdAt: DateTime.now(),
      ),

      // Hydration Tips
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
        id: '16',
        title: 'Carry a Water Bottle',
        description:
            'Keep a reusable water bottle with you throughout the day. This makes it easier to sip water regularly and track your intake.',
        category: 'Hydration',
        icon: '💧',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '17',
        title: 'Infuse Your Water',
        description:
            'Add slices of lemon, cucumber, mint, or berries to your water. Natural flavors make hydration more enjoyable without added sugars.',
        category: 'Hydration',
        icon: '🍋',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '18',
        title: 'Hydrate Before Meals',
        description:
            'Drink a glass of water 30 minutes before each meal. This aids digestion and can prevent overeating by creating a sense of fullness.',
        category: 'Hydration',
        icon: '⏰',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '19',
        title: 'Monitor Urine Color',
        description:
            'Check your urine color throughout the day. Pale yellow indicates proper hydration, while dark yellow suggests you need more water.',
        category: 'Hydration',
        icon: '🎨',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '20',
        title: 'Eat Water-Rich Foods',
        description:
            'Include fruits and vegetables with high water content like watermelon, cucumber, oranges, and celery in your diet for extra hydration.',
        category: 'Hydration',
        icon: '🍉',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '21',
        title: 'Set Hydration Reminders',
        description:
            'Use phone alarms or apps to remind you to drink water regularly, especially if you tend to forget during busy days.',
        category: 'Hydration',
        icon: '⏲️',
        createdAt: DateTime.now(),
      ),

      // Mental Health Tips
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
        id: '40',
        title: 'Practice Gratitude Daily',
        description:
            'Write down three things you\'re grateful for each day. This simple practice can shift your perspective and reduce stress.',
        category: 'Mental Health',
        icon: '🙏',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '41',
        title: 'Limit News Consumption',
        description:
            'Set boundaries around news intake, especially before bed. Constant negative news can increase anxiety and stress levels.',
        category: 'Mental Health',
        icon: '📰',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '42',
        title: 'Connect with Others',
        description:
            'Make time for meaningful social connections. Regular interaction with friends and family supports emotional well-being.',
        category: 'Mental Health',
        icon: '👥',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '43',
        title: 'Spend Time in Nature',
        description:
            'Aim for at least 20 minutes outdoors daily. Nature exposure reduces stress, improves mood, and boosts creativity.',
        category: 'Mental Health',
        icon: '🌳',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '44',
        title: 'Learn to Say No',
        description:
            'Set healthy boundaries and prioritize your well-being. Overcommitting leads to burnout and increased stress.',
        category: 'Mental Health',
        icon: '🙅',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '45',
        title: 'Practice Mindfulness',
        description:
            'Spend a few minutes each day focusing on the present moment without judgment. Mindfulness reduces anxiety and improves emotional regulation.',
        category: 'Mental Health',
        icon: '🧠',
        createdAt: DateTime.now(),
      ),

      // Nutrition Tips
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
        id: '8',
        title: 'Limit Processed Foods',
        description:
            'Choose whole, unprocessed foods whenever possible. They contain more nutrients and less added sugar, sodium, and unhealthy fats.',
        category: 'Nutrition',
        icon: '🚫',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '22',
        title: 'Choose Whole Grains',
        description:
            'Opt for whole grains like brown rice, quinoa, and whole wheat bread instead of refined grains for more fiber and nutrients.',
        category: 'Nutrition',
        icon: '🌾',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '23',
        title: 'Don\'t Skip Breakfast',
        description:
            'Start your day with a balanced breakfast containing protein, healthy fats, and complex carbs to fuel your morning and prevent overeating later.',
        category: 'Nutrition',
        icon: '🍳',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '24',
        title: 'Read Nutrition Labels',
        description:
            'Check food labels for serving sizes, added sugars, sodium, and unhealthy fats. Choose products with simpler, recognizable ingredients.',
        category: 'Nutrition',
        icon: '🏷️',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '25',
        title: 'Cook at Home More Often',
        description:
            'Prepare meals at home to control ingredients, portion sizes, and cooking methods. Home-cooked meals are typically healthier than restaurant food.',
        category: 'Nutrition',
        icon: '👨‍🍳',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '26',
        title: 'Snack Smart',
        description:
            'Choose nutrient-dense snacks like nuts, yogurt, or fruit instead of processed snacks. Plan healthy snacks to avoid impulsive choices.',
        category: 'Nutrition',
        icon: '🥜',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '27',
        title: 'Practice the 80/20 Rule',
        description:
            'Aim for healthy choices 80% of the time while allowing some flexibility 20% of the time. This balanced approach is more sustainable long-term.',
        category: 'Nutrition',
        icon: '⚖️',
        createdAt: DateTime.now(),
      ),

      // Sleep Tips
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
        id: '28',
        title: 'Create a Bedtime Routine',
        description:
            'Establish a relaxing pre-sleep routine like reading, gentle stretching, or meditation to signal your body it\'s time to wind down.',
        category: 'Sleep',
        icon: '📚',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '29',
        title: 'Keep Your Room Dark and Cool',
        description:
            'Maintain a cool temperature (60-67°F) and use blackout curtains or an eye mask. Darkness promotes melatonin production for better sleep.',
        category: 'Sleep',
        icon: '🌡️',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '30',
        title: 'Limit Screen Time Before Bed',
        description:
            'Avoid phones, tablets, and computers at least one hour before bedtime. Blue light disrupts your natural sleep-wake cycle.',
        category: 'Sleep',
        icon: '📵',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '31',
        title: 'Avoid Heavy Meals Before Bed',
        description:
            'Finish eating 2-3 hours before sleeping. Large meals can cause discomfort and disrupt sleep, while light snacks are okay if needed.',
        category: 'Sleep',
        icon: '🍽️',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '32',
        title: 'Wake Up at the Same Time Daily',
        description:
            'Consistent wake-up times, even on weekends, help regulate your body\'s internal clock and improve overall sleep quality.',
        category: 'Sleep',
        icon: '⏰',
        createdAt: DateTime.now(),
      ),
      TipModel(
        id: '33',
        title: 'Use Your Bed Only for Sleep',
        description:
            'Avoid working, eating, or watching TV in bed. This strengthens the mental association between your bed and sleep.',
        category: 'Sleep',
        icon: '🛏️',
        createdAt: DateTime.now(),
      ),
    ];

    // Add all default tips to Hive box
    for (var tip in defaultTips) {
      await box.add(tip);
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

  /// Clear all tips from database (use for testing/development)
  /// Call this once to reset the tips database
  Future<void> clearAllTips() async {
    try {
      final box = await _getTipsBox();
      await box.clear();
      debugPrint('All tips cleared successfully');
    } catch (e) {
      debugPrint('Error clearing tips: $e');
    }
  }
}
