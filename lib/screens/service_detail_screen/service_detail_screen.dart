import 'package:flutter/material.dart';
import 'package:handyman/components/default_button.dart';
import 'package:handyman/screens/book_a_service_screen/booking_service_screen.dart';

import 'components/body.dart';

class ServiceDetailScreen extends StatefulWidget {
  static String routeName = "/service_detail";
  const ServiceDetailScreen({
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
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        serviceImages2: widget.serviceImages2,
        fav: widget.fav,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(28.0, 8, 28, 28),
        child: DefaultButton(
          text: "Book Now",
          press: () {
            //Navigator.pushNamed(context, BookingService.routeName);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingService(
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
                    fav: widget.fav,
                  ),
                ));
          },
        ),
      ),
    );
  }
}
