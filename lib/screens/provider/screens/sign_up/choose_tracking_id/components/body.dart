import 'dart:io';

import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/screens/sign_up/choose_tracking_id/components/provider_tracking_id_form.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.name,
    required this.email,
    required this.gender,
    required this.mobile,
    required this.cnic,
    required this.password,
    required this.profileImg,
  }) : super(key: key);
  final String name, email, password, cnic, mobile, gender;
  final File? profileImg;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: TrackingForm(
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
