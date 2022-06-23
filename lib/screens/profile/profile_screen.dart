import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';
import 'components/body.dart';

//import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: const Body(),
    );
  }
}
