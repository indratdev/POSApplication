class PaymentService {
  double cashPayment(double totalOrdersPrice, double payAmountUser) {
    return payAmountUser - totalOrdersPrice;
  }
}
