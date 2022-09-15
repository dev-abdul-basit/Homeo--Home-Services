import 'package:flutter/material.dart';
import 'package:handyman/screens/choose_account/choose_acount.dart';
import 'package:handyman/screens/provider/provider_components/provider_custom_logout_dialog.dart';

import '../../../../../helper/global_config.dart';
import '../../../../map_location/map_location_screen.dart';
import '../../../../sign_in/sign_in_screen.dart';
import '../../../provider_constants.dart';

class ProfilePreferences extends StatefulWidget {
  const ProfilePreferences({Key? key}) : super(key: key);

  @override
  State<ProfilePreferences> createState() => _ProfilePreferencesState();
}

class _ProfilePreferencesState extends State<ProfilePreferences> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, MapScreen.routeName);
            },
            child: ListTile(
              title: const Text(
                'Adress Details',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: kTextColor,
                    fontSize: 15),
              ),
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: kTextColorSecondary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  color: kTextColor,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: kTextColor,
                size: 12,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: InkWell(
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    // Navigator.of(context).pop();

                    return CustomLogoutDialog(
                      press: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              // Navigator.of(context).pop();

                              return CustomLogoutDialog(
                                press: () {
                                  box!.delete("provider_login");
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      ChooseAccount.routeName,
                                      (route) => false);
                                  //  Navigator.of(context).pop();
                                },
                                close: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            });
                      },
                      close: () {
                        Navigator.of(context).pop();
                      },
                    );
                  });
            },
            child: ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: kTextColor,
                    fontSize: 15),
              ),
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: kTextColorSecondary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.logout,
                  color: kTextColor,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: kTextColor,
                size: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
