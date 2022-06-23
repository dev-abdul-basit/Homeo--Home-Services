import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';

import 'components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";

  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBGColor,
      appBar: AppBar(
        title: const Text(""),
      ),
      body: const Body(),
    );
  }
}
