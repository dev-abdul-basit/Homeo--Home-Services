import 'package:flutter/material.dart';
import 'package:handyman/components/default_button.dart';

import '../book_a_service_screen/booking_service_screen.dart';
import 'components/body.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({Key? key}) : super(key: key);
  static String routeName = "/service_detail";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 2,
      //   centerTitle: false,
      //   title: const Text(
      //     "Details",
      //     style: TextStyle(color: kTextColor),
      //   ),
      // ),
      body: const Body(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(28.0, 8, 28, 28),
        child: DefaultButton(
          text: "Book Now",
          press: () {
            Navigator.pushNamed(context, BookingService.routeName);
          },
        ),
      ),
    );
  }
}
