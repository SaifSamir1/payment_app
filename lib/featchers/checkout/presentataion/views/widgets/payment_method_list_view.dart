import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_progect/featchers/checkout/presentataion/manger/checkout_cubit.dart';
import 'package:payment_progect/featchers/checkout/presentataion/manger/checkout_cubit.dart';
import 'package:payment_progect/featchers/checkout/presentataion/views/widgets/payment_method_item.dart';
import 'package:payment_progect/generated/assets.dart';

class PaymentMethodsListView extends StatefulWidget {
  const PaymentMethodsListView({
    super.key,
  });

  @override
  State<PaymentMethodsListView> createState() => _PaymentMethodsListViewState();
}

class _PaymentMethodsListViewState extends State<PaymentMethodsListView> {
  final List<String> paymentMethodsItems = const [
    Assets.imagesCard,
    Assets.imagesPaypal,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ListView.builder(
          itemCount: paymentMethodsItems.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BlocBuilder<CheckoutCubit, CheckoutState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<CheckoutCubit>(context).changeIndex(index);
                    },
                    child: PaymentMethodItem(
                      isActive: BlocProvider.of<CheckoutCubit>(context).activeIndex == index,
                      image: paymentMethodsItems[index],
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
