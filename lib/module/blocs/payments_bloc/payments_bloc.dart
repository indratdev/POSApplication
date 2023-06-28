import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/orders_model.dart';
import '../../../data/model/users_model.dart';
import '../../../domain/hive_repository.dart';
import '../../../domain/order_repository.dart';
import '../../../domain/payments_repository.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final PaymentsRepository paymentsRepository = PaymentsRepository();
  final OrderRepository orderRepository = OrderRepository();
  final HiveRepository hiveRepository = HiveRepository();

  PaymentsBloc() : super(PaymentsInitial()) {
    on<CashPaymentEvent>((event, emit) async {
      emit(LoadingCashPayment());
      try {
        // Either<String, bool> check = paymentRepository.checkValidTransaction(
        //     event.totalTranscationAmount, event.totalPaymentAmount);

        // if (check.isLeft()) {
        //   emit(FailureCashpayment(messageError: check.toString()));
        // }

        // double result = paymentRepository.cashPaymentProcess(
        //     event.totalTranscationAmount, event.totalPaymentAmount);

        double result = paymentsRepository.cashPayment(
            event.totalTranscationAmount, event.totalPaymentAmount);

        //
        UsersModel userLogin = await hiveRepository.readUserLoginFromHive();

        // update status order
        OrdersModel orders = event.orders;
        orders.dateTimePaymentComplete = DateTime.now();
        orders.payAmountUser = event.totalPaymentAmount;
        orders.changeMoney = result;
        orders.userPaymentBy = userLogin.firstname;
        orders.userPaymentID = userLogin.userID;

        orderRepository.updateStatusOrder(
            StatusOrder.paymentCompleted, event.orders);

        emit(SuccessCashPayment(orders: event.orders, changeMoney: result));

        // emit(SuccessCashPayment());
      } catch (e) {
        log(e.toString());
        emit(FailureCashpayment(messageError: e.toString()));
      }
    });
  }
}
