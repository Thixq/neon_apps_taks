import 'package:pay/pay.dart';

final class PaymentService {
  PaymentService(Pay payInstance) : _payInstance = payInstance;
  final Pay _payInstance;

  Future<Map<String, dynamic>> ApplePay({
    required List<PaymentItem> items,
  }) async {
    try {
      return _payInstance.showPaymentSelector(PayProvider.apple_pay, items);
    } catch (e) {
      //adding logging
      print(e);
      rethrow;
    }
  }
}
