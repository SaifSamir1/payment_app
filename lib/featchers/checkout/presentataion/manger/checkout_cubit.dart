import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment_progect/featchers/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_progect/featchers/checkout/data/repositry/checkout_repo.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this.checkoutRepo) : super(CheckoutInitial());

  CheckoutRepo checkoutRepo;

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(CheckoutLoading());

    var data = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);

    data.fold(
      (l) => emit(CheckoutFailure(errorMessage: l.errorMessage)),
      (r) => emit(
        CheckoutSuccess(),
      ),
    );
  }

  int activeIndex = 0;

  void changeIndex(int index)
  {
    activeIndex = index;
    emit(ChangeIndexSuccess());
  }
  @override
  void onChange(Change<CheckoutState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
