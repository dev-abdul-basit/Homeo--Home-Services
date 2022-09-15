import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/provider_components/provider_coustom_bottom_nav_bar.dart';

import '../../provider_constants.dart';
import '../../provider_enum.dart';
import 'components/body.dart';

class ProviderViewServicesScreen extends StatelessWidget {
  const ProviderViewServicesScreen({Key? key}) : super(key: key);
  static String routeName = "/provider_view_services";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: false,
          title: const Text(
            "My Services",
            style: TextStyle(color: kTextColor),
          ),
          bottom: const TabBar(
              labelColor: kPrimaryLightColor,
              unselectedLabelColor: kTextColorSecondary,
              indicatorColor: kPrimaryColor,
              tabs: [
                Tab(text: 'My Services'),
                // Tab(text: 'Pending'),
              ]),
        ),
        body: const Body(),
        bottomNavigationBar:
            const CustomBottomNavBar(selectedMenu: MenuState.services),
      ),
    );
  }
}
