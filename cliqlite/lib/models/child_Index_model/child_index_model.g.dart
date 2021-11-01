// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_index_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChildIndexAdapter extends TypeAdapter<ChildIndex> {
  @override
  final int typeId = 10;

  @override
  ChildIndex read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChildIndex(
      index: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChildIndex obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChildIndexAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
