// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_topics.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentTopicAdapter extends TypeAdapter<RecentTopic> {
  @override
  final int typeId = 16;

  @override
  RecentTopic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentTopic(
      id: fields[0] as String,
      child: fields[1] as String,
      grade: fields[2] as Grade,
      subject: fields[3] as Grade,
      topic: fields[4] as Topic,
      lastViewed: fields[5] as DateTime,
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime,
      v: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RecentTopic obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.child)
      ..writeByte(2)
      ..write(obj.grade)
      ..writeByte(3)
      ..write(obj.subject)
      ..writeByte(4)
      ..write(obj.topic)
      ..writeByte(5)
      ..write(obj.lastViewed)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.v);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentTopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
