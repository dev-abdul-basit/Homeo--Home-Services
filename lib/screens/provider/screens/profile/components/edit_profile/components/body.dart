import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/screens/profile/components/edit_profile/components/provider_edit_profile_form.dart';

import '../../../../../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.enable}) : super(key: key);
  final bool enable;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
              // Center(
              //   child: Stack(
              //     children: [
              //       const CircleAvatar(
              //         radius: 50.0,
              //         backgroundColor: Colors.white,
              //         child: CircleAvatar(
              //           backgroundColor: Colors.white,
              //           radius: 48.0,
              //           backgroundImage: AssetImage("assets/images/user.png"),
              //           // backgroundImage: NetworkImage(data[index]['avatar_url']),
              //         ),
              //       ),
              //       Positioned(
              //         right: 0,
              //         bottom: 0,
              //         child: Container(
              //           padding: const EdgeInsets.all(7.5),
              //           decoration: BoxDecoration(
              //               border: Border.all(width: 2, color: Colors.white),
              //               borderRadius: BorderRadius.circular(48.0),
              //               color: kPrimaryColor),
              //           child: InkWell(
              //             onTap: () {},
              //             child: const Icon(
              //               Icons.linked_camera,
              //               color: Colors.white,
              //               size: 18,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: getProportionateScreenHeight(6)),

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
