// part of 'payment_bloc.dart';

// abstract class PaymentState extends Equatable {
//   const PaymentState();

//   @override
//   List<Object> get props => [];
// }

// class PaymentInitial extends PaymentState {}

// class FailurePays extends PaymentState {
//   String messageError;

//   FailurePays({
//     required this.messageError,
//   });

//   @override
//   List<Object> get props => [messageError];
// }

// class LoadingPay extends PaymentState {}

// class FailurePay extends FailurePays {
//   FailurePay({required super.messageError});
// }

// class SuccessPay extends PaymentState {
//   OrdersModel orders;
//   double changeMoney;

//   SuccessPay({
//     required this.orders,
//     required this.changeMoney,
//   });

//   @override
//   List<Object> get props => [orders, changeMoney];
// }
