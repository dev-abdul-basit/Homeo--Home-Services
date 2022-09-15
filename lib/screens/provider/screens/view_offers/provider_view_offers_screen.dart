import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/provider_components/provider_coustom_bottom_nav_bar.dart';

import '../../provider_constants.dart';
import '../../provider_enum.dart';
import 'components/body.dart';

class ProviderViewOffersScreen extends StatelessWidget {
  static String routeName = "/provider_view_offers";
  const ProviderViewOffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: false,
          title: const Text(
            "Offers",
            style: TextStyle(color: kTextColor),
          ),
          bottom: const TabBar(
              labelColor: kPrimaryLightColor,
              unselectedLabelColor: kTextColorSecondary,
              indicatorColor: kPrimaryColor,
              tabs: [
                Tab(text: 'New'),
                Tab(text: 'Active'),
                Tab(text: 'Completed'),
              ]),
        ),
        body: const Body(),
        bottomNavigationBar:
            const CustomBottomNavBar(selectedMenu: MenuState.offers),
      ),
    );
  }
}
