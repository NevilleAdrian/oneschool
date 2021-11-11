// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_topic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnalyticTopicAdapter extends TypeAdapter<AnalyticTopic> {
  @override
  final int typeId = 12;

  @override
  AnalyticTopic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnalyticTopic(
      id: fields[0] as Id,
      topicPercentile: fields[1] as double,
      topicInfo: (fields[2] as List)?.cast<TopicInfo>(),
    );
  }

  @override
  void write(BinaryWriter writer, AnalyticTopic obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.topicPercentile)
      ..writeByte(2)
      ..write(obj.topicInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnalyticTopicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
