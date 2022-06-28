import 'package:flutter/material.dart';

import 'components/body.dart';

class RateServiceScreen extends StatelessWidget {
  static String routeName = "/rate_service";
  const RateServiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   elevation: 2,
      //   centerTitle: false,
      //   title: const Text(
      //     "",
      //     style: TextStyle(color: kTextColor),
      //   ),
      // ),
      body: Body(),
    );
  }
}
