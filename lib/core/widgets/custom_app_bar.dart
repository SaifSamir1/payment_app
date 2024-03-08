import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:payment_progect/generated/assets.dart';

import '../utils/styls.dart';

AppBar buildAppBar({final String? title}) {
  return AppBar(
    leading: Center(
      child: SvgPicture.asset(
        Assets.imagesArrow,
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: Text(
      title ?? '',
      textAlign: TextAlign.center,
      style: Styles.style25,
    ),
  );
}
