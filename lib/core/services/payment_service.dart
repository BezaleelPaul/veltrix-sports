import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// Payment State
class PaymentState {
  final bool isLoading;
  final String? error;
  final String? successMessage;
  final String? transactionId;

  PaymentState({
    this.isLoading = false,
    this.error,
    this.successMessage,
    this.transactionId,
  });

  PaymentState copyWith({
    bool? isLoading,
    String? error,
    String? successMessage,
    String? transactionId,
  }) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      successMessage: successMessage,
      transactionId: transactionId ?? this.transactionId,
    );
  }
}

// Payment Service
class PaymentService {
  late Razorpay _razorpay;
  Function(PaymentState)? onPaymentStateChanged;

  PaymentService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    onPaymentStateChanged?.call(PaymentState(
      isLoading: false,
      successMessage: 'Payment successful!',
      transactionId: response.paymentId,
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    onPaymentStateChanged?.call(PaymentState(
      isLoading: false,
      error: response.message ?? 'Payment failed',
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    onPaymentStateChanged?.call(PaymentState(
      isLoading: false,
      successMessage: 'External wallet payment initiated',
    ));
  }

  void openCheckout({
    required String name,
    required String email,
    required String phone,
    required double amount,
    required String description,
    String? imageUrl,
  }) {
    final options = {
      'key': 'YOUR_RAZORPAY_KEY', // Replace with actual key
      'amount': (amount * 100).toInt(), // Amount in paise
      'name': 'Veltrix Sports',
      'description': description,
      'prefill': {
        'contact': phone,
        'email': email,
      },
      'image': imageUrl ?? 'https://veltrixsports.com/logo.png',
      'theme': {
        'color': '#2563EB',
      },
    };

    try {
      onPaymentStateChanged?.call(PaymentState(isLoading: true));
      _razorpay.open(options);
    } catch (e) {
      onPaymentStateChanged?.call(PaymentState(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void dispose() {
    _razorpay.clear();
  }
}

// Payment Provider
final paymentServiceProvider = Provider<PaymentService>((ref) {
  final service = PaymentService();
  ref.onDispose(() => service.dispose());
  return service;
});

// Payment State Provider
final paymentStateProvider = StateProvider<PaymentState>((ref) {
  return PaymentState();
});
