// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecommendedVideoAdapter extends TypeAdapter<RecommendedVideo> {
  @override
  final int typeId = 17;

  @override
  RecommendedVideo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecommendedVideo(
      subject: fields[0] as String,
      video: fields[1] as Video,
    );
  }

  @override
  void write(BinaryWriter writer, RecommendedVideo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.subject)
      ..writeByte(1)
      ..write(obj.video);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecommendedVideoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
