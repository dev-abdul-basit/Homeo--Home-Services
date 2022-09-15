import 'package:flutter/material.dart';

import '../../provider_constants.dart';
import 'components/body.dart';

class ProviderAddNewServiceScreen extends StatelessWidget {
  static String routeName = "/provider_add_service";
  const ProviderAddNewServiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: false,
        title: const Text(
          "Add Service",
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: const Body(),
      // bottomNavigationBar:
      //     const CustomBottomNavBar(selectedMenu: MenuState.services),
    );
  }
}
