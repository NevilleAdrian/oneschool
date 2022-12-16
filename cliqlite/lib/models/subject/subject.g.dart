// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectAdapter extends TypeAdapter<Subject> {
  @override
  final int typeId = 6;

  @override
  Subject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subject(
      photo: fields[0] as String,
      id: fields[1] as dynamic,
      name: fields[2] as String,
      description: fields[3] as String,
      grade: fields[4] as Grades,
      createdAt: fields[5] as DateTime,
      slug: fields[6] as String,
      v: fields[7] as dynamic,
      subjectId: fields[8] as String,
      icon: fields[9] as String,
      primaryColor: fields[10] as String,
      secondaryColor: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Subject obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.photo)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.grade)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.slug)
      ..writeByte(7)
      ..write(obj.v)
      ..writeByte(8)
      ..write(obj.subjectId)
      ..writeByte(9)
      ..write(obj.icon)
      ..writeByte(10)
      ..write(obj.primaryColor)
      ..writeByte(11)
      ..write(obj.secondaryColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
