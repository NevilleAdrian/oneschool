// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grades.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GradesAdapter extends TypeAdapter<Grades> {
  @override
  final int typeId = 3;

  @override
  Grades read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Grades(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      photo: fields[3] as String,
      createdAt: fields[4] as DateTime,
      v: fields[5] as int,
      gradeId: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Grades obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.photo)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.v)
      ..writeByte(6)
      ..write(obj.gradeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
