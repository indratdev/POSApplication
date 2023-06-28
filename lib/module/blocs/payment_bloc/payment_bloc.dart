// import 'dart:developer';

// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:posapplication/domain/hive_repository.dart';
// import 'package:posapplication/domain/order_repository.dart';
// import 'package:posapplication/domain/payments_repository.dart';

// import '../../../data/model/orders_model.dart';
// import '../../../data/model/users_model.dart';

// part 'payment_event.dart';
// part 'payment_state.dart';

// class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
//   final PaymentRepository paymentRepository = PaymentRepository();
//   final OrderRepository orderRepository = OrderRepository();
//   final HiveRepository hiveRepository = HiveRepository();

//   PaymentBloc() : super(PaymentInitial()) {
//     on<PayEvent>((event, emit) async {
//       emit(LoadingPay());
//       try {
//         double result = paymentRepository.cashPayment(
//             event.totalOrdersPrice, event.payAmountUser);

//         //
//         UsersModel userLogin = await hiveRepository.readUserLoginFromHive();

//         // update status order
//         OrdersModel orders = event.orders;
//         orders.dateTimePaymentComplete = DateTime.now();
//         orders.payAmountUser = event.payAmountUser;
//         orders.changeMoney = result;
//         orders.userPaymentBy = userLogin.firstname;
//         orders.userPaymentID = userLogin.userID;

//         orderRepository.updateStatusOrder(
//             StatusOrder.paymentCompleted, event.orders);

//         emit(SuccessPay(orders: event.orders, changeMoney: result));
//       } catch (e) {
//         log(e.toString());
//         emit(FailurePay(messageError: e.toString()));
//       }
//     });
//   }
// }
