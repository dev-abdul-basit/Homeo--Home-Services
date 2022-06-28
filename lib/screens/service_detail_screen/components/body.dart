import 'package:flutter/material.dart';
import 'package:handyman/components/header_image.dart';
import 'package:handyman/screens/service_detail_screen/components/about_section.dart';
import 'package:handyman/screens/service_detail_screen/components/service_info.dart';
import 'package:handyman/size_config.dart';

import '../../../constants.dart';
import 'reviews_container.dart';
import 'show_work_images.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          const ServiceInfo(),
          SizedBox(
            height: getProportionateScreenHeight(12),
          ),
          const Divider(
            color: kFormColor,
            height: 2,
            thickness: 2,
          ),
          SizedBox(
            height: getProportionateScreenHeight(12),
          ),
          const AboutSection(),
          SizedBox(
            height: getProportionateScreenHeight(12),
          ),
          const WorkImagesGridView(),
          SizedBox(
            height: getProportionateScreenHeight(12),
          ),
          const Divider(
            color: kFormColor,
            height: 8,
            thickness: 8,
          ),
          SizedBox(
            height: getProportionateScreenHeight(24),
          ),
          const ReviewsContainer(),
        ],
      ),
    );
  }
}
