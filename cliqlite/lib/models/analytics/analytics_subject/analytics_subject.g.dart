// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_subject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnalyticSubjectAdapter extends TypeAdapter<AnalyticSubject> {
  @override
  final int typeId = 11;

  @override
  AnalyticSubject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnalyticSubject(
      id: fields[0] as Id,
      subjectPercentile: fields[1] as double,
      subjectInfo: (fields[2] as List)?.cast<SubjectInfo>(),
    );
  }

  @override
  void write(BinaryWriter writer, AnalyticSubject obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subjectPercentile)
      ..writeByte(2)
      ..write(obj.subjectInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnalyticSubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
