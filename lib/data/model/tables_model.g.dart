// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tables_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TablesModelAdapter extends TypeAdapter<TablesModel> {
  @override
  final int typeId = 5;

  @override
  TablesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TablesModel(
      companyID: fields[0] as String,
      tableID: fields[1] as String,
      tableNo: fields[2] as String,
      tableName: fields[5] as String,
      size: fields[3] as int,
      shape: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TablesModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.companyID)
      ..writeByte(1)
      ..write(obj.tableID)
      ..writeByte(2)
      ..write(obj.tableNo)
      ..writeByte(3)
      ..write(obj.size)
      ..writeByte(4)
      ..write(obj.shape)
      ..writeByte(5)
      ..write(obj.tableName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TablesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
