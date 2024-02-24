

import 'package:flutter/material.dart';
import 'package:payment_progect/featchers/checkout/presentataion/views/widgets/mycart_view_body.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: buildAppBar(title: 'My Cart'),
      body: const MyCartViewBody(),
    );
  }
}
