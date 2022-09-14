// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersAdapter extends TypeAdapter<Users> {
  @override
  final int typeId = 4;

  @override
  Users read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Users(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      dob: fields[3] as String,
      parent: fields[4] as String,
      isSubscribed: fields[5] as bool,
      grade: fields[6] as String,
      role: fields[7] as String,
      photo: fields[8] as String,
      createdAt: fields[9] as DateTime,
      test: fields[11] as bool,
      age: fields[12] as int,
      isActive: fields[10] as bool,
      planType: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Users obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.dob)
      ..writeByte(4)
      ..write(obj.parent)
      ..writeByte(5)
      ..write(obj.isSubscribed)
      ..writeByte(6)
      ..write(obj.grade)
      ..writeByte(7)
      ..write(obj.role)
      ..writeByte(8)
      ..write(obj.photo)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.isActive)
      ..writeByte(11)
      ..write(obj.test)
      ..writeByte(12)
      ..write(obj.age)
      ..writeByte(13)
      ..write(obj.planType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
