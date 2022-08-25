import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';
import 'package:handyman/screens/book_a_service_screen/components/working_hours_container.dart';

import '../../../components/default_button.dart';
import '../../../helper/global_config.dart';
import '../../../size_config.dart';
import '../../booking_summary/booking_summary.dart';
import 'date_and_time_container.dart';
import 'special_instructions.dart';

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
      id,
      description,
      note,
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
    return Container(
      margin: const EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DateAndTimePicker(
              //first one will be available in next sceen
              //second one we have here in this screen
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
              serviceImages: widget.serviceImages,
              serviceImages1: widget.serviceImages1,
              serviceImages2: widget.serviceImages,
            ),
            // const SizedBox(height: 8),
            // const Divider(
            //   color: kFormColor,
            //   height: 8,
            //   thickness: 8,
            // ),
            // const SizedBox(height: 8),
            // const WorkingHoursContianer(),
            // const SizedBox(height: 8),
            // const Divider(
            //   color: kFormColor,
            //   height: 8,
            //   thickness: 8,
            // ),
            // const SpecialInstructions(),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(24.0, 28, 24, 8),
            //   child: SizedBox(
            //     height: getProportionateScreenHeight(48),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => BookingSummary(
            //                 //first one will be available in next sceen
            //                 //second one we have here in this screen
            //                 id: widget.id,
            //                 title: widget.title,
            //                 speciality: widget.speciality,
            //                 description: widget.description,
            //                 note: widget.note,
            //                 adress: widget.adress,
            //                 rate: widget.rate,
            //                 status: widget.status,
            //                 spName: widget.spName,
            //                 spId: widget.spId,
            //                 serviceImages: widget.serviceImages,
            //                 serviceImages1: widget.serviceImages1,
            //                 serviceImages2: widget.serviceImages,
            //               ),
            //             ));
            //       },
            //       child: Text(
            //         box!.get('booking') != "true"
            //             ? "Continue"
            //             : 'Already booked at this Time',
            //         style: TextStyle(
            //           fontSize: getProportionateScreenWidth(18),
            //           color: Colors.white,
            //         ),
            //       ),
            //       style: ElevatedButton.styleFrom(
            //         padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            //         primary: box!.get('booking') != "true"
            //             ? kPrimaryColor
            //             : kTextColorSecondary,
            //         onPrimary: kSecondaryColor,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(25)),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
