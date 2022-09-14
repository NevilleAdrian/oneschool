// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopicAdapter extends TypeAdapter<Topic> {
  @override
  final int typeId = 8;

  @override
  Topic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Topic(
      video: fields[0] as VideoClass,
      id: fields[1] as String,
      name: fields[2] as String,
      description: fields[3] as String,
      grade: fields[4] as GradeClass,
      subject: fields[5] as GradeClass,
      icon: fields[6] as String,
      primaryColor: fields[7] as String,
      secondaryColor: fields[8] as String,
      isVerified: fields[9] as bool,
      createdAt: fields[10] as DateTime,
      updatedAt: fields[11] as DateTime,
      v: fields[12] as int,
      plan: fields[13] as String,
      type: fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Topic obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.video)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.grade)
      ..writeByte(5)
      ..write(obj.subject)
      ..writeByte(6)
      ..write(obj.icon)
      ..writeByte(7)
      ..write(obj.primaryColor)
      ..writeByte(8)
      ..write(obj.secondaryColor)
      ..writeByte(9)
      ..write(obj.isVerified)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.v)
      ..writeByte(13)
      ..write(obj.plan)
      ..writeByte(14)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
