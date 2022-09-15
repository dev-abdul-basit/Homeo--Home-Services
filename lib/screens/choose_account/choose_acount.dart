import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'components/body.dart';

class ChooseAccount extends StatelessWidget {
  static String routeName = "/choose_account";

  const ChooseAccount({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}
