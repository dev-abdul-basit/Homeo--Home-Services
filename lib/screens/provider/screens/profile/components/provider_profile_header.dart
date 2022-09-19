import 'package:flutter/material.dart';
import 'package:handyman/screens/profile/components/edit_profile/edit_profile_screen.dart';
import 'package:handyman/screens/provider/screens/profile/components/edit_profile/provider_edit_profile_screen.dart';

import '../../../../../helper/global_config.dart';
import '../../../provider_constants.dart';

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
    profileFrmHive = box!.get('profile_img');
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
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: box!.get('name'),
                    style: const TextStyle(
                        fontSize: 14.0,
                        color: kTextColor,
                        fontWeight: FontWeight.w500),
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.verified,
                      size: 20,
                      color: box!.get('status') == 'pending'
                          ? kTextColorSecondary
                          : kPrimaryColor,
                    ),
                  ),
                ],
              ),
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
                    Navigator.pushNamed(
                        context, ProviderEditProfileScreen.routeName);
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
