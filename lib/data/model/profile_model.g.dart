// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileModelAdapter extends TypeAdapter<ProfileModel> {
  @override
  final int typeId = 1;

  @override
  ProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileModel(
      companyID: fields[0] as String?,
      bussinessName: fields[1] as String?,
      bussinessType: fields[2] as String?,
      bussinessCurrency: fields[4] as String?,
      bussinessCountry: fields[3] as String?,
      bussinessAddress: fields[5] as String?,
      bussinessPhone: fields[6] as String?,
      bussinessPhoto: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.companyID)
      ..writeByte(1)
      ..write(obj.bussinessName)
      ..writeByte(2)
      ..write(obj.bussinessType)
      ..writeByte(3)
      ..write(obj.bussinessCountry)
      ..writeByte(4)
      ..write(obj.bussinessCurrency)
      ..writeByte(5)
      ..write(obj.bussinessAddress)
      ..writeByte(6)
      ..write(obj.bussinessPhone)
      ..writeByte(7)
      ..write(obj.bussinessPhoto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
