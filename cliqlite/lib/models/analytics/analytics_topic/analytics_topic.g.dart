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
      highestPerformingSubject: fields[0] as HighestPerformingSubject,
      videosWatched: fields[1] as dynamic,
      quizCompleted: fields[2] as dynamic,
      graph: (fields[3] as List)?.cast<Graph>(),
    );
  }

  @override
  void write(BinaryWriter writer, AnalyticTopic obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.highestPerformingSubject)
      ..writeByte(1)
      ..write(obj.videosWatched)
      ..writeByte(2)
      ..write(obj.quizCompleted)
      ..writeByte(3)
      ..write(obj.graph);
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

class GraphAdapter extends TypeAdapter<Graph> {
  @override
  final int typeId = 17;

  @override
  Graph read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Graph(
      id: fields[0] as Id,
      score: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Graph obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GraphAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IdAdapter extends TypeAdapter<Id> {
  @override
  final int typeId = 18;

  @override
  Id read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Id(
      day: fields[0] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Id obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.day);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HighestPerformingSubjectAdapter
    extends TypeAdapter<HighestPerformingSubject> {
  @override
  final int typeId = 19;

  @override
  HighestPerformingSubject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HighestPerformingSubject(
      name: fields[0] as String,
      no: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, HighestPerformingSubject obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.no);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HighestPerformingSubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
