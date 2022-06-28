import 'package:flutter/material.dart';

import '../../../constants.dart';

class ServiceSummary extends StatelessWidget {
  const ServiceSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: kTextColorSecondary.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Service Name",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Date: 24/07/2022",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black87),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Time: 11:00 AM",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black87),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Total Hours: 06 hrs",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black87),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Total Price : 5000",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryLightColor),
                ),
                SizedBox(
                  height: 8,
                ),
              ]),
        ),
      ),
    );
  }
}
