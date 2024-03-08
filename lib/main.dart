import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'core/utils/api_keys.dart';
import 'featchers/checkout/presentataion/views/mycart_view.dart';

void main() {
  Stripe.publishableKey = ApiKeys.publishableKey;

  runApp(const PaymentApp());
}

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyCartView(),
    );
  }
}

// PaymentIntentModel create payment intent(amount , currency , customerId)
// keySecret createEphemeralKey( customerId)
// initPaymentSheet (merchantDisplayName , intentClientSecret , ephemeralKeySecret)
// presentPaymentSheet()
