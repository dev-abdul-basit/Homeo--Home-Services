import 'package:flutter/material.dart';

import '../../components/coustom_bottom_nav_bar.dart';
import '../../constants.dart';
import '../../enum.dart';
import 'components/body.dart';

class AllServicesScreen extends StatelessWidget {
  static String routeName = "/all_services";
  const AllServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: false,
        title: const Text(
          "All Services",
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: const Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.services),
    );
  }
}
