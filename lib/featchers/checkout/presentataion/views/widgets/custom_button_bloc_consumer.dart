

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import '../../../../../core/utils/api_keys.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../data/models/pay_pal_amount_model/details.dart';
import '../../../data/models/pay_pal_amount_model/pay_pal_amount_model.dart';
import '../../../data/models/pay_pal_list_items_model/item.dart';
import '../../../data/models/pay_pal_list_items_model/pay_pal_list_items_model.dart';
import '../../../data/models/payment_intent_input_model.dart';
import '../../manger/checkout_cubit.dart';
import '../thank_you_view.dart';

class CustomButtonBlockConsumer extends StatelessWidget {
  const CustomButtonBlockConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return const ThankYouView();
          }));
        }
        if (state is CheckoutFailure) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(content: Text(state.errorMessage));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          log(state.errorMessage);
        }
      },
      builder: (context, state) {
        return CustomButton(
            onTap: () {
              if (BlocProvider.of<CheckoutCubit>(context).activeIndex == 0){
                PaymentIntentInputModel paymentIntentInputModel = PaymentIntentInputModel(
                  customerId: ApiKeys.customerId,
                  amount: '100',
                  currency: 'USD',
                );
                BlocProvider.of<CheckoutCubit>(context).makePayment(
                    paymentIntentInputModel: paymentIntentInputModel);
              }
              else{
                var transactionDat = getTransactionData();
                excutePayPalPayment(context, transactionDat);
              }
            },
            isLoading: state is CheckoutLoading,
            text: 'Continue');
      },
    );
  }

  void excutePayPalPayment(
      BuildContext context,
      ({
      PayPalAmountModel amountData,
      PayPalListItemsModel listOfItemsData
      }) transactionDat) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKeys.clintId,
        secretKey: ApiKeys.payPalSecretKey,
        transactions: [
          {
            "amount": transactionDat.amountData.toJson(),
            "description": "The payment transaction description.",
            "item_list": transactionDat.listOfItemsData.toJson(),
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.pop(context);
        },
        onError: (error) {
          log("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          if (kDebugMode) {
            print('cancelled:');
          }
          Navigator.pop(context);
        },
      ),
    ));
  }

// record dataType
  ({PayPalAmountModel amountData, PayPalListItemsModel listOfItemsData})
  getTransactionData() {
    var amount = PayPalAmountModel(
        total: "100",
        currency: "USD",
        details: Details(
          subtotal: "100",
          shipping: "0",
          shippingDiscount: 0,
        ));

    Item order1 =
    Item(name: "apple", currency: "USD", quantity: 10, price: "4");
    Item order2 =
    Item(name: "apple", currency: "USD", quantity: 12, price: "5");

    var listOfItems = PayPalListItemsModel(items: [order1, order2]);

    return (amountData: amount, listOfItemsData: listOfItems);
  }
}
