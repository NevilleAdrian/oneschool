// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedbacksAdapter extends TypeAdapter<Feedbacks> {
  @override
  final int typeId = 17;

  @override
  Feedbacks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Feedbacks(
      id: fields[0] as String,
      message: fields[1] as String,
      owner: fields[2] as Owner,
      role: fields[3] as String,
      verified: fields[4] as bool,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
      v: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Feedbacks obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.owner)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.verified)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.v);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedbacksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
