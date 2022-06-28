import 'package:flutter/material.dart';
import 'package:handyman/screens/rate_service_screen/components/service_rate_form.dart';

import '../../../components/header_image.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'provider_info.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(children: <Widget>[
              const ServiceImageHeader(),
              Positioned(
                top: 44,
                left: 24,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          color: kFormColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(36)),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: kTextColorSecondary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: getProportionateScreenHeight(12),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 4),
              child: Text(
                "House Cleaning",
                style: headingStyle,
                textAlign: TextAlign.start,
              ),
            ),
            const ProviderInfo(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 0),
              child: Text(
                "Please Rate your Experience",
                style: headingStyle,
                textAlign: TextAlign.start,
              ),
            ),
            const ServiceRateForm(),
          ]),
    );
  }
}
