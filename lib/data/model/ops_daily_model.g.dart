// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ops_daily_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OpsDailyModelAdapter extends TypeAdapter<OpsDailyModel> {
  @override
  final int typeId = 3;

  @override
  OpsDailyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OpsDailyModel(
      initDate: fields[0] as String?,
      userList: (fields[1] as List?)?.cast<UsersModel>(),
      categoryList: (fields[2] as List?)?.cast<CategoryModel>(),
      tableList: (fields[3] as List?)?.cast<TablesModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, OpsDailyModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.initDate)
      ..writeByte(1)
      ..write(obj.userList)
      ..writeByte(2)
      ..write(obj.categoryList)
      ..writeByte(3)
      ..write(obj.tableList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OpsDailyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
