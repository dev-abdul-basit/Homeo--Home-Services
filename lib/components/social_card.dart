import 'package:flutter/material.dart';

class SocalCard extends StatelessWidget {
  const SocalCard({
    Key? key,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Center(
        //padding: const EdgeInsets.only(left: 8, right: 8),
        // height: getProportionateScreenHeight(40),

        child: Image(
          width: 172,
          image: AssetImage(icon),
        ),
      ),
    );
  }
}
