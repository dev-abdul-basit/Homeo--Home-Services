import 'package:flutter/material.dart';

import 'package:handyman/constants.dart';
import 'package:handyman/helper/global_config.dart';
import 'package:handyman/screens/profile/components/edit_profile/edit_profile_screen.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String? profileFrmHive;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileFrmHive = box!.get('uimage');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 48.0,
                backgroundImage: NetworkImage(profileFrmHive!),
                // backgroundImage: NetworkImage(data[index]['avatar_url']),
              ),
            ),
            Text(
              box!.get('name'),
              style: headingStyle,
            ),
            Text(
              box!.get('email'),
              style: secondaryTextStyle12,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 24, 80, 0),
              child: SizedBox(
                width: 124,
                height: 32,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, EditProfileScreen.routeName);
                  },
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
