part of 'payments_bloc.dart';

abstract class PaymentsState extends Equatable {
  const PaymentsState();

  @override
  List<Object> get props => [];
}

class PaymentsInitial extends PaymentsState {}

class FailurePayments extends PaymentsState {
  String messageError;

  FailurePayments({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

class LoadingCashPayment extends PaymentsState {}

class FailureCashpayment extends FailurePayments {
  FailureCashpayment({required super.messageError});
}

class SuccessCashPayment extends PaymentsState {
  OrdersModel orders;
  double changeMoney;

  SuccessCashPayment({
    required this.orders,
    required this.changeMoney,
  });

  @override
  List<Object> get props => [orders, changeMoney];
}
