import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../provider_constants.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
    required this.a,
    required this.b,
    required this.press,
  }) : super(key: key);
  final String a, b;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          a,
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () {
            press();
          },
          child: Text(
            b,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
