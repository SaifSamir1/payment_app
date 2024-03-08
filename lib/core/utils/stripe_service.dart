import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_progect/core/utils/api_keys.dart';
import 'package:payment_progect/core/utils/api_service.dart';
import 'package:payment_progect/featchers/checkout/data/models/ephemeral_key/ephemeral_key.dart';
import 'package:payment_progect/featchers/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_progect/featchers/checkout/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  ApiService apiService = ApiService();
  //دي اول حاجه علشان اعمل create لل payment intent اللي عايز استخدمه
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.post(
      contentType: Headers.formUrlEncodedContentType,
      body: paymentIntentInputModel.toJson(),
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.secretApiKey,
    );

    var paymentIntentResponse = PaymentIntentModel.fromJson(response.data);
    return paymentIntentResponse;
  }

  //كدا بعمل initialization لل payment intent م
  Future initPaymentSheet({
    required String paymentIntentClintSecrete,
    required String customerEphemeralKeySecret,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClintSecrete,
        customerEphemeralKeySecret: customerEphemeralKeySecret,
        customerId: ApiKeys.customerId,
        //ده اسم العميل اللي عامله الشغل
        merchantDisplayName: 'saif',
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  //دي function هتعمل التلات خطوات اللي فوق مره وحده
  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephemeralKey = await createEphemralKey(customerId: ApiKeys.customerId);
    await initPaymentSheet(
        customerEphemeralKeySecret: ephemeralKey.secret!,
        paymentIntentClintSecrete: paymentIntentModel.clientSecret!);
    await displayPaymentSheet();
  }

  Future<EphemeralKeyModel> createEphemralKey(
      {required String customerId}) async {
    var response = await apiService.post(
        contentType: Headers.formUrlEncodedContentType,
        body: {'customer': customerId},
        url: 'https://api.stripe.com/v1/ephemeral_keys',
        token: ApiKeys.secretApiKey,
        headers: {
          'Stripe-Version': '2023-10-16',
          'Authorization': "Bearer ${ApiKeys.secretApiKey}"
        });

    var ephemeralKeyResponse = EphemeralKeyModel.fromJson(response.data);
    return ephemeralKeyResponse;
  }
}
