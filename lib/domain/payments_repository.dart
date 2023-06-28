import 'package:dartz/dartz.dart';

import '../data/service/payment_service/payment_service.dart';

class PaymentsRepository {
  final PaymentService paymentService = PaymentService();

  double cashPayment(double totalOrdersPrice, double payAmountUser) {
    return paymentService.cashPayment(totalOrdersPrice, payAmountUser);
  }

  Map<String, dynamic> isLessPayment(
      double totalTranscationAmount, double totalPayment) {
    Map<String, dynamic> result = {};

    if (totalPayment < totalTranscationAmount) {
      result['status'] = false;
      result['description'] = "Pembayaran Kurang";
    } else {
      result['status'] = true;
      result['description'] = "";
    }

    return result;
  }

  Either<String, bool> checkValidTransaction(
      double totalTranscationAmount, double totalPayment) {
    late Either<String, bool> myEither;

    if (totalPayment < totalTranscationAmount) {
      myEither = Left("Pembayaran Kurang");
    } else {
      myEither = Right(true);
    }
    return myEither;
  }

  double cashPaymentProcess(
      double totalTranscationAmount, double totalPayment) {
    return totalPayment - totalTranscationAmount;
  }
}
