import 'package:flutter/material.dart';
import 'package:handyman/components/header_image.dart';
import 'package:handyman/screens/service_detail_screen/components/about_section.dart';
import 'package:handyman/screens/service_detail_screen/components/service_info.dart';
import 'package:handyman/size_config.dart';

import '../../../constants.dart';
import 'reviews_container.dart';

class Body extends StatefulWidget {
  const Body({
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
    required this.serviceImages1,
    required this.serviceImages2,
    required this.fav,
  }) : super(key: key);
  final String title,
      speciality,
      description,
      note,
      id,
      adress,
      rate,
      status,
      spName,
      spId,
      serviceImages,
      serviceImages1,
      serviceImages2,
      fav;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            ServiceImageHeader(listImages: [
              widget.serviceImages,
              widget.serviceImages1,
              widget.serviceImages2,
            ]),
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
                        color: kPrimaryColor,
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
          ServiceInfo(
              id: widget.id,
              title: widget.title,
              speciality: widget.speciality,
              description: widget.description,
              note: widget.note,
              adress: widget.adress,
              rate: widget.rate,
              status: widget.status,
              spName: widget.spName,
              spId: widget.spId,
              serviceImages: '',
              fav: widget.fav),
          SizedBox(height: getProportionateScreenHeight(12)),
          const Divider(
            color: kFormColor,
            height: 2,
            thickness: 2,
          ),
          SizedBox(height: getProportionateScreenHeight(12)),
          AboutSection(
            id: widget.id,
            title: widget.title,
            speciality: widget.speciality,
            description: widget.description,
            note: widget.note,
            adress: widget.adress,
            rate: widget.rate,
            status: widget.status,
            spName: widget.spName,
            spId: widget.spId,
            serviceImages: '',
          ),
          SizedBox(
            height: getProportionateScreenHeight(12),
          ),
          //const WorkImagesGridView(),
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
          ReviewsContainer(id: widget.id),
        ],
      ),
    );
  }
}
