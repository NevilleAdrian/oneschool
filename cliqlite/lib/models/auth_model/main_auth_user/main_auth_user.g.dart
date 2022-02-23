// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_auth_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MainChildUserAdapter extends TypeAdapter<MainChildUser> {
  @override
  final int typeId = 14;

  @override
  MainChildUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainChildUser(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      age: fields[3] as int,
      isSubscribed: fields[4] as bool,
      grade: fields[5] as String,
      role: fields[6] as String,
      photo: fields[7] as String,
      createdAt: fields[8] as DateTime,
      v: fields[9] as int,
      mainChildUserId: fields[10] as String,
      isActive: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MainChildUser obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.isSubscribed)
      ..writeByte(5)
      ..write(obj.grade)
      ..writeByte(6)
      ..write(obj.role)
      ..writeByte(7)
      ..write(obj.photo)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.v)
      ..writeByte(10)
      ..write(obj.mainChildUserId)
      ..writeByte(11)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainChildUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
