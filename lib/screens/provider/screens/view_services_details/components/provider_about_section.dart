import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/screens/profile/provider_profile_screen.dart';

import '../../../../../helper/global_config.dart';
import '../../../provider_constants.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({
    Key? key,
    required this.title,
    required this.id,
    required this.speciality,
    required this.description,
    required this.note,
    required this.adress,
    required this.rate,
    required this.status,
    required this.spName,
    required this.spId,
    required this.serviceImages,
  }) : super(key: key);
  final String title,
      speciality,
      description,
      note,
      adress,
      id,
      rate,
      status,
      spName,
      spId,
      serviceImages;

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool isAdmin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (box!.containsKey("admin_login")) {
      setState(() {
        isAdmin = true;
      });
    } else {
      setState(() {
        isAdmin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "About Service",
                style: TextStyle(
                    fontSize: 18,
                    color: kTextColor,
                    fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ProviderProfileScreen.routeName);
                },
                child: const Text(
                  "",
                  style: TextStyle(
                      fontSize: 12,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: kTextColor.withOpacity(0.5),
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: 8),
          Text(
            widget.note,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: kTextColor.withOpacity(0.5),
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
