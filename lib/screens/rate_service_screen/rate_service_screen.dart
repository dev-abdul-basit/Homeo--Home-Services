import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class RateServiceScreen extends StatefulWidget {
  static String routeName = "/rate_service";
  const RateServiceScreen({
    Key? key,
    required this.uid,
    required this.id,
    required this.serviceName,
    required this.b_date,
    required this.b_time,
    required this.b_hours,
    required this.b_price,
    required this.booking_status,
    required this.user_booking_status,
    required this.service_id,
    required this.sp_name,
    required this.sp_id,
  }) : super(key: key);
  final String uid,
      id,
      serviceName,
      b_date,
      b_time,
      b_hours,
      b_price,
      booking_status,
      user_booking_status,
      service_id,
      sp_name,
      sp_id;

  @override
  State<RateServiceScreen> createState() => _RateServiceScreenState();
}

class _RateServiceScreenState extends State<RateServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: false,
        title: const Text(
          "Rate a service",
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: Body(
        booking_id: widget.id,
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
    );
  }
}
