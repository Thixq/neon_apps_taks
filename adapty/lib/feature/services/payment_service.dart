import 'package:flutter/widgets.dart';
import 'package:pay/pay.dart';

final class PaymentService {
  PaymentService(Pay payInstance) : _payInstance = payInstance;
  final Pay _payInstance;

  Future<Map<String, dynamic>> applePay({
    required List<PaymentItem> items,
  }) async {
    try {
      final result = await _payInstance.showPaymentSelector(
        PayProvider.apple_pay,
        items,
      );
      return result;
    } catch (e) {
      //adding logging
      debugPrint('$e');
      return {};
    }
  }
}
