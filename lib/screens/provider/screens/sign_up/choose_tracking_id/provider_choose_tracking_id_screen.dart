import 'dart:io';

import 'package:flutter/material.dart';
import 'components/body.dart';

class ChooseTrackingID extends StatefulWidget {
  static String routeName = "/sign_in_tracking_id";
  const ChooseTrackingID({
    Key? key,
    required this.name,
    required this.email,
    required this.gender,
    required this.mobile,
    required this.cnic,
    required this.password,
    this.profileImg,
  }) : super(key: key);

  final String name, email, password, cnic, mobile, gender;
  final File? profileImg;

  @override
  State<ChooseTrackingID> createState() => _ChooseTrackingIDState();
}

class _ChooseTrackingIDState extends State<ChooseTrackingID> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(300),
      //   child: Container(
      //     color: kPrimaryColor,
      //   ),
      // ),
      body: Body(
        name: widget.name,
        email: widget.email,
        gender: widget.gender,
        mobile: widget.mobile,
        cnic: widget.cnic,
        password: widget.password,
        profileImg: widget.profileImg,
      ),
    );
  }
}
