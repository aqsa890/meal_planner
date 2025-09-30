// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 2;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      id: fields[0] as String,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
      calories: fields[3] as int,
      protein: fields[4] as int,
      fat: fields[5] as int,
      carbs: fields[6] as int,
      prepTime: fields[7] as int,
      ingredients: (fields[8] as List).cast<String>(),
      steps: (fields[9] as List).cast<String>(),
      servings: fields[10] as int,
      dietaryTags: (fields[11] as List).cast<String>(),
      goal: fields[12] as String,
      suitableForDiseases: (fields[13] as List).cast<String>(),
      isFavorite: fields[14] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.calories)
      ..writeByte(4)
      ..write(obj.protein)
      ..writeByte(5)
      ..write(obj.fat)
      ..writeByte(6)
      ..write(obj.carbs)
      ..writeByte(7)
      ..write(obj.prepTime)
      ..writeByte(8)
      ..write(obj.ingredients)
      ..writeByte(9)
      ..write(obj.steps)
      ..writeByte(10)
      ..write(obj.servings)
      ..writeByte(11)
      ..write(obj.dietaryTags)
      ..writeByte(12)
      ..write(obj.goal)
      ..writeByte(13)
      ..write(obj.suitableForDiseases)
      ..writeByte(14)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
