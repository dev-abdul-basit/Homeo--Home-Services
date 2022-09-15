import 'package:flutter/material.dart';

import 'components/body.dart';

class ProviderSignInScreen extends StatelessWidget {
  static String routeName = "/provider_sign_in";

  const ProviderSignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(300),
      //   child: Container(
      //     color: kPrimaryColor,
      //   ),
      // ),
      body: Body(),
    );
  }
}
