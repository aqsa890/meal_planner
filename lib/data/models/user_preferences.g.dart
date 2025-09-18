// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPreferencesAdapter extends TypeAdapter<UserPreferences> {
  @override
  final int typeId = 0;

  @override
  UserPreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPreferences(
      goal: fields[0] as String?,
      disease: fields[1] as String?,
      isOnboardingCompleted: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserPreferences obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.goal)
      ..writeByte(1)
      ..write(obj.disease)
      ..writeByte(2)
      ..write(obj.isOnboardingCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
