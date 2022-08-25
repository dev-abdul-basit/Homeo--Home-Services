import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class BookingService extends StatefulWidget {
  static String routeName = "/book_a_service";
  const BookingService({
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
  State<BookingService> createState() => _BookingServiceState();
}

class _BookingServiceState extends State<BookingService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: false,
        title: const Text(
          "Booking Details",
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: Body(
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
        fav: widget.fav,
      ),
    );
  }
}
