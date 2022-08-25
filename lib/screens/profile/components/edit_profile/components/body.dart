import 'package:flutter/material.dart';

import 'package:handyman/constants.dart';
import 'package:handyman/screens/profile/components/edit_profile/components/edit_profile_form.dart';

import '../../../../../helper/global_config.dart';
import '../../../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.enable}) : super(key: key);
  final bool enable;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? profileImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileImage = baseUrl + '/flutterfyp/' + box!.get('uimage');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //Edit Form
              Expanded(
                child: EditProfileForm(
                  enable: widget.enable,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
