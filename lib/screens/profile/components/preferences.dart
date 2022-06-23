import 'package:flutter/material.dart';

import '../../../constants.dart';

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
            onTap: () {},
            child: ListTile(
              title: const Text(
                'Payment Methods',
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
                  Icons.payment,
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
            onTap: () {},
            child: ListTile(
              title: const Text(
                'Order History',
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
                  Icons.history,
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
            onTap: () {},
            child: ListTile(
              title: const Text(
                'Settings',
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
                  Icons.settings,
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
            onTap: () {},
            child: ListTile(
              title: const Text(
                'Delivery Details',
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
                  Icons.location_on,
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
            onTap: () {},
            child: ListTile(
              title: const Text(
                'Language',
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
                  Icons.language,
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
            onTap: () {},
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
