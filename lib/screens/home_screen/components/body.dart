import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';
import 'package:handyman/screens/all_services_screen/all_services_screen.dart';
import 'package:handyman/screens/home_screen/components/home_service_list.dart';
import 'package:handyman/screens/view_providers_map/view_providers_map.dart';

import '../../../size_config.dart';
import 'home_service_filters.dart';
import 'home_services.dart';

import 'home_header.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: getProportionateScreenHeight(6)),
            const Padding(
              padding: EdgeInsets.only(left: 18.0, right: 8.0),
              child: Text(
                "Search for Services",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(12)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenHeight(16)),
            const Divider(
              thickness: 1,
              color: kTextColorSecondary,
              height: 2.0,
            ),
            SizedBox(height: getProportionateScreenWidth(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 18.0, right: 8.0),
                  child: Text(
                    "Services",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AllServicesScreen.routeName);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 18.0),
                    child: Text(
                      "See All",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
            const HomeServices(),
            SizedBox(height: getProportionateScreenWidth(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 18.0, right: 8.0),
                  child: Text(
                    "Most Popular Services",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, ViewProviderMapScreen.routeName);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 18.0),
                    child: Text(
                      "Map View",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),

            // const HomeFilterChips(),
            SizedBox(height: getProportionateScreenHeight(8)),
            const HomeServiceList(),
            SizedBox(height: getProportionateScreenWidth(24)),
          ],
        ),
      ),
    );
  }
}
