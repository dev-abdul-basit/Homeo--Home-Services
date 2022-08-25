import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../helper/global_config.dart';

class ServiceSummary extends StatefulWidget {
  const ServiceSummary({
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
      serviceImages2;

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
                  "Service: " + widget.title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  "Date: " + box!.get('b_date'),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  "Time: " + box!.get('b_time'),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  "Total Hours: " + box!.get('hours').toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  "Total Price: " +
                      (int.parse(widget.rate) * box!.get('hours')).toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryLightColor),
                ),
                const SizedBox(height: 8),
              ]),
        ),
      ),
    );
  }
}
