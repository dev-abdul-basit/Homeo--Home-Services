import 'package:flutter/material.dart';
import 'package:handyman/screens/rate_service_screen/components/service_rate_form.dart';

import '../../../components/header_image.dart';
import '../../../constants.dart';
import '../../../helper/global_config.dart';
import '../../../size_config.dart';
import 'provider_info.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.booking_id,
    required this.uid,
    required this.serviceName,
    required this.b_date,
    required this.b_time,
    required this.b_hours,
    required this.b_price,
    required this.service_id,
    required this.sp_name,
    required this.sp_id,
  }) : super(key: key);
  final String uid,
      serviceName,
      service_id,
      b_date,
      b_time,
      b_hours,
      b_price,
      booking_id,
      sp_name,
      sp_id;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final List<String> _listImages = [
    "assets/images/cleaner_2.png",
    "assets/images/repair_man.jpg",
    "assets/images/wall_painting.jpg",
    "assets/images/cleaner_2.png",
    "assets/images/repair_man.jpg",
    "assets/images/wall_painting.jpg",
    "assets/images/cleaner_2.png",
    "assets/images/repair_man.jpg",
    "assets/images/wall_painting.jpg",
  ];
  final String url = baseUrl + "provider/viewallservicesToUser.php";

  late List data;

  var isLoading = false;
  bool isAdmin = true;

  @override
  void initState() {
    super.initState();
    // getAllData();
  }

  Future getAllData() async {
    var response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "service_status": 'approve',
    });
    //print(response.body);
    setState(() {
      List convertDataToJson = json.decode(response.body)['result'];
      data = convertDataToJson;
      isLoading = true;
      print(data);
    });

    // throw Exception('Failed to load data');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Visibility(
            //   visible: false,
            //   child: Stack(children: <Widget>[
            //     const ServiceImageHeader(
            //       listImages: [
            //         "assets/images/cleaner_2.png",
            //         "assets/images/repair_man.jpg",
            //         "assets/images/wall_painting.jpg",
            //       ],
            //     ),
            //     Positioned(
            //       top: 44,
            //       left: 24,
            //       child: Center(
            //         child: InkWell(
            //           onTap: () {
            //             Navigator.of(context).pop();
            //           },
            //           child: Container(
            //             width: 48,
            //             height: 48,
            //             decoration: BoxDecoration(
            //                 color: kFormColor.withOpacity(0.5),
            //                 borderRadius: BorderRadius.circular(36)),
            //             child: const Padding(
            //               padding: EdgeInsets.only(left: 8.0),
            //               child: Icon(
            //                 Icons.arrow_back_ios,
            //                 color: kTextColorSecondary,
            //                 size: 20,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ]),
            // ),
            SizedBox(
              height: getProportionateScreenHeight(12),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 4),
              child: Text(
                widget.serviceName,
                style: headingStyle,
                textAlign: TextAlign.start,
              ),
            ),
            ProviderInfo(
              booking_id: widget.booking_id,
              service_id: widget.service_id,
              uid: widget.uid,
              serviceName: widget.serviceName,
              b_date: widget.b_date,
              b_time: widget.b_time,
              b_hours: widget.b_hours,
              b_price: widget.b_price,
              sp_name: widget.sp_name,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 0),
              child: Text(
                "Please Rate your Experience",
                style: headingStyle,
                textAlign: TextAlign.start,
              ),
            ),
            ServiceRateForm(
              booking_id: widget.booking_id,
              service_id: widget.service_id,
              uid: widget.uid,
              serviceName: widget.serviceName,
              b_date: widget.b_date,
              b_time: widget.b_time,
              b_hours: widget.b_hours,
              b_price: widget.b_price,
              sp_name: widget.sp_name,
              sp_id: widget.sp_id,
            ),
          ]),
    );
  }
}
