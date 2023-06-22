part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PayEvent extends PaymentEvent {
  OrdersModel orders;
  double totalOrdersPrice;
  double payAmountUser;

  PayEvent({
    required this.totalOrdersPrice,
    required this.payAmountUser,
    required this.orders,
  });
}
