import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';

import '../../../size_config.dart';
import 'nearby_vendors.dart';

import 'home_header.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(12)),
            const HomeHeader(),
            const Divider(
              thickness: 1,
              color: kTextColorSecondary,
              height: 2.0,
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            const NearByVendors(),
          ],
        ),
      ),
    );
  }
}
