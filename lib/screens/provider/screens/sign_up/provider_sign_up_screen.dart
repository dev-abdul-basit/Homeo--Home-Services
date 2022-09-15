import 'package:flutter/material.dart';

import 'components/body.dart';

class ProvierSignUpScreen extends StatelessWidget {
  static String routeName = "/provider_sign_up";

  const ProvierSignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: Text("Sign Up"),
      // ),
      body: Body(),
    );
  }
}
