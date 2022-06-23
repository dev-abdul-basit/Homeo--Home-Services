// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.heading,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text, heading, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
        Spacer(),
        Text(
          heading,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(24),
            color: kTextColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12),
              color: kTextColorSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
