import 'package:payment_progect/featchers/checkout/data/models/payment_intent_input_model.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
