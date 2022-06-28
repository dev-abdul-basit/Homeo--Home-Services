import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';
import 'package:handyman/screens/booking_summary/components/service_provider_info.dart';

import 'service_summary.dart';
import 'user_info_header.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            UserInfoHeader(),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Service Summary",
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 8),
            ServiceSummary(),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Service Provider Info",
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 8),
            ServiceProviderInfo(),
          ],
        ),
      ),
    );
  }
}
