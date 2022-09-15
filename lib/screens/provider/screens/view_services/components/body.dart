import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/screens/view_services/components/provider_tab_approved_services.dart';

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
        ApprovedServices(),
        // PendingServices(),
      ],
    );
  }
}
