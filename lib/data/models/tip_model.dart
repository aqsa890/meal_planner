import 'package:hive/hive.dart';

part 'tip_model.g.dart'; // Generated file for Hive TypeAdapter

/// Model representing a health tip
/// This model is used to store tips in Hive local database
@HiveType(typeId: 3) // Ensure this typeId is unique in your app
class TipModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String category; // e.g., "Nutrition", "Exercise", "Hydration", "Sleep"

  @HiveField(4)
  final String icon; // Icon identifier or emoji

  @HiveField(5)
  bool isFavorite;

  @HiveField(6)
  final DateTime createdAt;

  TipModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
    this.isFavorite = false,
    required this.createdAt,
  });

  /// Factory constructor to create TipModel from JSON
  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      icon: json['icon'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// Convert TipModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'icon': icon,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Create a copy of TipModel with updated fields
  TipModel copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? icon,
    bool? isFavorite,
    DateTime? createdAt,
  }) {
    return TipModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
