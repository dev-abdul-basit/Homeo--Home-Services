import 'package:flutter/material.dart';

import '../../../../provider_constants.dart';
import 'components/body.dart';

class ProviderEditProfileScreen extends StatefulWidget {
  const ProviderEditProfileScreen({Key? key}) : super(key: key);

  static String routeName = "/edit_profile_provider";

  @override
  State<ProviderEditProfileScreen> createState() =>
      _ProviderEditProfileScreenState();
}

class _ProviderEditProfileScreenState extends State<ProviderEditProfileScreen> {
  // Initially TextField is disabled
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBGColor,
      appBar: AppBar(
        elevation: 2,
        title: Text(
          "Profile",
          style: headingStyle,
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 32.0, top: 24),
            child: InkWell(
              onTap: () {
                // _toggle();
                setState(() {
                  _enabled = !_enabled;
                  debugPrint(_enabled.toString());
                });
              },
              child: const Text(
                "Edit",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
      body: Body(
        enable: _enabled,
      ),
    );
  }
}
