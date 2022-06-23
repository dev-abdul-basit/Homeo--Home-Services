import 'package:flutter/material.dart';

import 'components/body.dart';

class LocationPermissionScreen extends StatelessWidget {
  static String routeName = "/location_permission";

  const LocationPermissionScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
