import 'package:flutter/material.dart';
import 'package:handyman/size_config.dart';

import '../../provider_constants.dart';
import 'components/body.dart';

class ProviderMapScreen extends StatelessWidget {
  static String routeName = "/provider_map";

  const ProviderMapScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryBGColor,
        title: const Text(
          "Location",
          style: TextStyle(color: kTextColor),
        ),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
