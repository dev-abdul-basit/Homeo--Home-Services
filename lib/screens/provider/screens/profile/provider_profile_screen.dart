import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/provider_components/provider_coustom_bottom_nav_bar.dart';
import 'package:handyman/screens/provider/provider_enum.dart';
import '../../../../../helper/global_config.dart';

import '../../provider_constants.dart';
import 'components/body.dart';

//import 'components/body.dart';

class ProviderProfileScreen extends StatelessWidget {
  static String routeName = "/provider_profile";

  const ProviderProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: const Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
