// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersModelAdapter extends TypeAdapter<UsersModel> {
  @override
  final int typeId = 1;

  @override
  UsersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsersModel(
      documentID: fields[0] as String?,
      companyID: fields[1] as String?,
      email: fields[2] as String?,
      firstname: fields[3] as String?,
      lastname: fields[4] as String?,
      photo: fields[5] as String?,
      role: fields[6] as String?,
      userID: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UsersModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.documentID)
      ..writeByte(1)
      ..write(obj.companyID)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.firstname)
      ..writeByte(4)
      ..write(obj.lastname)
      ..writeByte(5)
      ..write(obj.photo)
      ..writeByte(6)
      ..write(obj.role)
      ..writeByte(7)
      ..write(obj.userID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
