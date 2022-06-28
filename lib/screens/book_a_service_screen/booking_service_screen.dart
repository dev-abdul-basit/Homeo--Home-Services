import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class BookingService extends StatelessWidget {
  static String routeName = "/book_a_service";
  const BookingService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: false,
        title: const Text(
          "Booking Confirmation",
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: const Body(),
    );
  }
}
