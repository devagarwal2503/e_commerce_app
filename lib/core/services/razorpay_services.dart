import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  // Singleton instance
  static final RazorpayService _instance = RazorpayService._internal();
  factory RazorpayService() => _instance;
  RazorpayService._internal();

  late Razorpay _razorpay;
  VoidCallback? _onSuccess;
  VoidCallback? _onError;

  void init({required VoidCallback onSuccess, required VoidCallback onError}) {
    _razorpay = Razorpay();
    _onSuccess = onSuccess;
    _onError = onError;

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout({
    required int amount,
    required String contact,
    required String email,
    String description = "Purchase from E-Commerce App",
  }) {
    final int finalAmount = amount * 100;

    var options = {
      'key': 'rzp_test_SPPgUvxFCvhib4',
      'amount': finalAmount,
      'name': 'Dev Agarwal',
      'description': description,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': contact, 'email': email},

      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Razorpay Error: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("Payment Successful: ${response.paymentId}");
    if (_onSuccess != null) _onSuccess!();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("Payment Error: ${response.code} - ${response.message}");
    if (_onError != null) _onError!();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("External Wallet: ${response.walletName}");
  }

  void dispose() {
    _razorpay.clear(); // Important to avoid memory leaks
  }
}
