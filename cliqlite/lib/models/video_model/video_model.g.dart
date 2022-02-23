// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoAdapter extends TypeAdapter<Video> {
  @override
  final int typeId = 9;

  @override
  Video read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Video(
      id: fields[0] as String,
      title: fields[1] as String,
      originalFilename: fields[2] as String,
      duration: fields[3] as String,
      bytes: fields[4] as int,
      publicId: fields[5] as String,
      resourceType: fields[6] as String,
      secureUrl: fields[7] as String,
      topic: fields[8] as dynamic,
      createdAt: fields[9] as DateTime,
      slug: fields[10] as String,
      tags: (fields[11] as List)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Video obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.originalFilename)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.bytes)
      ..writeByte(5)
      ..write(obj.publicId)
      ..writeByte(6)
      ..write(obj.resourceType)
      ..writeByte(7)
      ..write(obj.secureUrl)
      ..writeByte(8)
      ..write(obj.topic)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.slug)
      ..writeByte(11)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
