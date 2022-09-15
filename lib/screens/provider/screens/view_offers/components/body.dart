import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/screens/view_offers/components/provider_tab_active_offers.dart';
import 'package:handyman/screens/provider/screens/view_offers/components/provider_tab_completed_offers.dart';
import 'package:handyman/screens/provider/screens/view_offers/components/provider_tab_new_offers.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: <Widget>[
        NewOffers(),
        ActiveBookings(),
        CompletedBookings(),
      ],
    );
  }
}
