// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livestream_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LiveStreamAdapter extends TypeAdapter<LiveStream> {
  @override
  final int typeId = 13;

  @override
  LiveStream read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LiveStream(
      id: fields[0] as String,
      broadcast: fields[1] as String,
      broadcastUrl: fields[2] as String,
      tutor: fields[3] as Tutor,
      appointment: fields[4] as Appointment,
      subject: fields[5] as ChildGrade,
      grade: fields[6] as ChildGrade,
      createdAt: fields[7] as DateTime,
      v: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LiveStream obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.broadcast)
      ..writeByte(2)
      ..write(obj.broadcastUrl)
      ..writeByte(3)
      ..write(obj.tutor)
      ..writeByte(4)
      ..write(obj.appointment)
      ..writeByte(5)
      ..write(obj.subject)
      ..writeByte(6)
      ..write(obj.grade)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.v);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LiveStreamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
