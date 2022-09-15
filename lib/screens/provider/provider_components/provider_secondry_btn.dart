import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../provider_constants.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(48),
      child: ElevatedButton(
        onPressed: () {
          press();
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: kTextColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          primary: kSecondaryColor,
          onPrimary: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
