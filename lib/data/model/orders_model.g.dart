// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersModel _$OrdersModelFromJson(Map<String, dynamic> json) => OrdersModel(
      orderID: json['orderID'] as String? ?? "",
      totalOrdersPrice: (json['totalOrdersPrice'] as num?)?.toDouble() ?? 0.0,
      payAmountUser: (json['payAmountUser'] as num?)?.toDouble() ?? 0.0,
      changeMoney: (json['changeMoney'] as num?)?.toDouble() ?? 0.0,
      itemCountOrder: json['itemCountOrder'] as int? ?? 0,
      status: json['status'] as String? ?? "open",
      dataItem: (json['dataItem'] as List<dynamic>?)
          ?.map((e) => ItemsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dataTable: json['dataTable'] == null
          ? null
          : TablesModel.fromJson(json['dataTable'] as Map<String, dynamic>),
      dataCustomer: json['dataCustomer'] == null
          ? null
          : CustomersModel.fromJson(
              json['dataCustomer'] as Map<String, dynamic>),
      dateTimeOrder: json['dateTimeOrder'] == null
          ? null
          : DateTime.parse(json['dateTimeOrder'] as String),
      dateTimeWaiting: json['dateTimeWaiting'] == null
          ? null
          : DateTime.parse(json['dateTimeWaiting'] as String),
      dateTimeProccess: json['dateTimeProccess'] == null
          ? null
          : DateTime.parse(json['dateTimeProccess'] as String),
      dateTimeReady: json['dateTimeReady'] == null
          ? null
          : DateTime.parse(json['dateTimeReady'] as String),
      dateTimeOrderComplete: json['dateTimeOrderComplete'] == null
          ? null
          : DateTime.parse(json['dateTimeOrderComplete'] as String),
      dateTimeBillIsReady: json['dateTimeBillIsReady'] == null
          ? null
          : DateTime.parse(json['dateTimeBillIsReady'] as String),
      dateTimePaymentComplete: json['dateTimePaymentComplete'] == null
          ? null
          : DateTime.parse(json['dateTimePaymentComplete'] as String),
      dateTimeCancel: json['dateTimeCancel'] == null
          ? null
          : DateTime.parse(json['dateTimeCancel'] as String),
      addBy: json['addBy'] as String?,
      addByID: json['addByID'] as String?,
      userHandleBy: json['userHandleBy'] as String?,
      userHandleID: json['userHandleID'] as String?,
      userSenderBy: json['userSenderBy'] as String?,
      userSenderID: json['userSenderID'] as String?,
      userPaymentBy: json['userPaymentBy'] as String?,
      userPaymentID: json['userPaymentID'] as String?,
    );

Map<String, dynamic> _$OrdersModelToJson(OrdersModel instance) =>
    <String, dynamic>{
      'orderID': instance.orderID,
      'totalOrdersPrice': instance.totalOrdersPrice,
      'payAmountUser': instance.payAmountUser,
      'changeMoney': instance.changeMoney,
      'itemCountOrder': instance.itemCountOrder,
      'status': instance.status,
      'dateTimeOrder': instance.dateTimeOrder?.toIso8601String(),
      'dateTimeWaiting': instance.dateTimeWaiting?.toIso8601String(),
      'dateTimeProccess': instance.dateTimeProccess?.toIso8601String(),
      'dateTimeReady': instance.dateTimeReady?.toIso8601String(),
      'dateTimeOrderComplete':
          instance.dateTimeOrderComplete?.toIso8601String(),
      'dateTimeBillIsReady': instance.dateTimeBillIsReady?.toIso8601String(),
      'dateTimePaymentComplete':
          instance.dateTimePaymentComplete?.toIso8601String(),
      'dateTimeCancel': instance.dateTimeCancel?.toIso8601String(),
      'addBy': instance.addBy,
      'addByID': instance.addByID,
      'userHandleBy': instance.userHandleBy,
      'userHandleID': instance.userHandleID,
      'userSenderBy': instance.userSenderBy,
      'userSenderID': instance.userSenderID,
      'userPaymentBy': instance.userPaymentBy,
      'userPaymentID': instance.userPaymentID,
      'dataItem': instance.dataItem,
      'dataTable': instance.dataTable,
      'dataCustomer': instance.dataCustomer,
    };
