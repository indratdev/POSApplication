import '../data/service/export_services.dart';

class PaymentRepository {
  final PaymentService paymentService = PaymentService();

  double cashPayment(double totalOrdersPrice, double payAmountUser) {
    return paymentService.cashPayment(totalOrdersPrice, payAmountUser);
  }
}
