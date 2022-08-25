import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:handyman/screens/all_services_list_screen/all_services_list_screen.dart';

import '../../../constants.dart';
import '../../../helper/global_config.dart';
import 'dart:async';

import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.category,
    required this.sub1,
    required this.sub2,
    required this.sub3,
    required this.sub4,
    required this.sub5,
  }) : super(key: key);

  final String category, sub1, sub2, sub3, sub4, sub5;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("cat_title" + widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Visibility(
          visible: widget.category == '' ? false : true,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServicesListScreen(
                      serviceName: widget.category,
                      sub_cat: 'Empty',
                      service_title: 'Empty',
                      id: 'Empty',
                    ),
                  ));
            },
            child: ListTile(
              title: Text(
                widget.category,
                style: const TextStyle(
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
        Visibility(
          visible: widget.sub1 == '' ? false : true,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServicesListScreen(
                      serviceName: widget.category,
                      sub_cat: widget.sub1,
                      service_title: 'Empty',
                      id: 'Empty',
                    ),
                  ));
            },
            child: ListTile(
              title: Text(
                widget.sub1,
                style: const TextStyle(
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
        Visibility(
          visible: widget.sub2 == '' ? false : true,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServicesListScreen(
                      serviceName: widget.category,
                      sub_cat: widget.sub2,
                      service_title: 'Empty',
                      id: 'Empty',
                    ),
                  ));
            },
            child: ListTile(
              title: Text(
                widget.sub2,
                style: const TextStyle(
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
        Visibility(
          visible: widget.sub3 == '' ? false : true,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServicesListScreen(
                      serviceName: widget.category,
                      sub_cat: widget.sub3,
                      service_title: 'Empty',
                      id: 'Empty',
                    ),
                  ));
            },
            child: ListTile(
              title: Text(
                widget.sub3,
                style: const TextStyle(
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
        Visibility(
          visible: widget.sub4 == '' ? false : true,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServicesListScreen(
                      serviceName: widget.category,
                      sub_cat: widget.sub4,
                      service_title: 'Empty',
                      id: 'Empty',
                    ),
                  ));
            },
            child: ListTile(
              title: Text(
                widget.sub4,
                style: const TextStyle(
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
        Visibility(
          visible: widget.sub5 == '' ? false : true,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServicesListScreen(
                      serviceName: widget.category,
                      sub_cat: widget.sub5,
                      service_title: 'Empty',
                      id: 'Empty',
                    ),
                  ));
            },
            child: ListTile(
              title: Text(
                widget.sub5,
                style: const TextStyle(
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
      ]),
    );
  }
}
