// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_plan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NutritionPlanAdapter extends TypeAdapter<NutritionPlan> {
  @override
  final int typeId = 1;

  @override
  NutritionPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NutritionPlan(
      goal: fields[0] as String,
      disease: fields[1] as String?,
      water: fields[2] as String,
      steps: fields[3] as String,
      exercise: fields[4] as String,
      waterTypes: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NutritionPlan obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.goal)
      ..writeByte(1)
      ..write(obj.disease)
      ..writeByte(2)
      ..write(obj.water)
      ..writeByte(3)
      ..write(obj.steps)
      ..writeByte(4)
      ..write(obj.exercise)
      ..writeByte(5)
      ..write(obj.waterTypes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutritionPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
