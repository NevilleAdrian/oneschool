// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_active.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizActiveAdapter extends TypeAdapter<QuizActive> {
  @override
  final int typeId = 15;

  @override
  QuizActive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizActive(
      active: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, QuizActive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.active);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizActiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
