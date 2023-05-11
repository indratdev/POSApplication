// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersModel _$OrdersModelFromJson(Map<String, dynamic> json) => OrdersModel(
      orderID: json['orderID'] as String? ?? "",
      totalOrdersPrice: (json['totalOrdersPrice'] as num?)?.toDouble() ?? 0,
      itemCountOrder: json['itemCountOrder'] as int? ?? 0,
      status: json['status'] as String? ?? "open",
      dataItem: json['dataItem'] == null
          ? null
          : ItemsModel.fromJson(json['dataItem'] as Map<String, dynamic>),
      dataTable: json['dataTable'] == null
          ? null
          : TablesModel.fromJson(json['dataTable'] as Map<String, dynamic>),
      dataCustomer: json['dataCustomer'] == null
          ? null
          : CustomersModel.fromJson(
              json['dataCustomer'] as Map<String, dynamic>),
      dateTimeProccess: json['dateTimeProccess'] == null
          ? null
          : DateTime.parse(json['dateTimeProccess'] as String),
      dateTimeFinish: json['dateTimeFinish'] == null
          ? null
          : DateTime.parse(json['dateTimeFinish'] as String),
      dateTimeOrder: json['dateTimeOrder'] == null
          ? null
          : DateTime.parse(json['dateTimeOrder'] as String),
      dateTimeWaiting: json['dateTimeWaiting'] == null
          ? null
          : DateTime.parse(json['dateTimeWaiting'] as String),
      staffHandleBy: json['staffHandleBy'] as String?,
      staffUserID: json['staffUserID'] as String?,
    );

Map<String, dynamic> _$OrdersModelToJson(OrdersModel instance) =>
    <String, dynamic>{
      'orderID': instance.orderID,
      'totalOrdersPrice': instance.totalOrdersPrice,
      'itemCountOrder': instance.itemCountOrder,
      'status': instance.status,
      'dateTimeOrder': instance.dateTimeOrder?.toIso8601String(),
      'dateTimeWaiting': instance.dateTimeWaiting?.toIso8601String(),
      'dateTimeProccess': instance.dateTimeProccess?.toIso8601String(),
      'dateTimeFinish': instance.dateTimeFinish?.toIso8601String(),
      'staffHandleBy': instance.staffHandleBy,
      'staffUserID': instance.staffUserID,
      'dataItem': instance.dataItem,
      'dataTable': instance.dataTable,
      'dataCustomer': instance.dataCustomer,
    };
