import 'package:flutter/material.dart';

import 'package:handyman/screens/sign_up/components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  const SignUpScreen({Key? key}) : super(key: key);
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
