import 'package:flutter/material.dart';

import '../../../constants.dart';

class ServiceSummary extends StatefulWidget {
  const ServiceSummary({
    Key? key,
    required this.uid,
    required this.serviceName,
    required this.b_date,
    required this.b_time,
    required this.b_hours,
    required this.b_price,
  }) : super(key: key);
  final String uid, serviceName, b_date, b_time, b_hours, b_price;

  @override
  State<ServiceSummary> createState() => _ServiceSummaryState();
}

class _ServiceSummaryState extends State<ServiceSummary> {
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
              children: <Widget>[
                const SizedBox(height: 8),
                Text(
                  "Service: " + widget.serviceName,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Date: " + widget.b_date,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black87),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Time: " + widget.b_time,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black87),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Total Hours: " + widget.b_hours,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black87),
                ),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Price: " + widget.b_price,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryLightColor),
                ),
                const SizedBox(
                  height: 8,
                ),
              ]),
        ),
      ),
    );
  }
}
