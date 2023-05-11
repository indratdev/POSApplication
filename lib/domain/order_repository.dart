import 'package:dartz/dartz.dart';
import 'package:posapplication/data/service/order_service/order_service.dart';

import '../data/model/orders_model.dart';

class OrderRepository {
  final OrderService orderService = OrderService();

  // create order
  Future<Either<String, String>> createOrder(List<OrdersModel> data) async {
    return await orderService.createNewOrder(data);
  }
}
