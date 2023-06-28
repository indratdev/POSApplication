part of 'payments_bloc.dart';

abstract class PaymentsEvent extends Equatable {
  const PaymentsEvent();

  @override
  List<Object> get props => [];
}

class CashPaymentEvent extends PaymentsEvent {
  OrdersModel orders;
  double totalTranscationAmount;
  double totalPaymentAmount;

  CashPaymentEvent({
    required this.orders,
    required this.totalTranscationAmount,
    required this.totalPaymentAmount,
  });
}
