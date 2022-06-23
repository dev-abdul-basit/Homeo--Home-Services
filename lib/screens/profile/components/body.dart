import 'package:flutter/material.dart';
import 'package:handyman/screens/profile/components/preferences.dart';
import 'package:handyman/screens/profile/components/profile_header.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(12)),
            const ProfileHeader(),
            SizedBox(
              height: getProportionateScreenWidth(36),
              width: double.infinity,
              child: Container(
                color: kTextColorSecondary.withOpacity(0.2),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 8, 8, 8),
                  child: Text(
                    "Preferences",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(12)),
            const ProfilePreferences(),
          ],
        ),
      ),
    );
  }
}
