import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';
import 'package:handyman/screens/book_a_service_screen/components/working_hours_container.dart';

import 'date_and_time_container.dart';
import 'special_instructions.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            DateAndTimePicker(),
            SizedBox(height: 8),
            Divider(
              color: kFormColor,
              height: 8,
              thickness: 8,
            ),
            SizedBox(height: 8),
            WorkingHoursContianer(),
            SizedBox(height: 8),
            Divider(
              color: kFormColor,
              height: 8,
              thickness: 8,
            ),
            SpecialInstructions(),
          ],
        ),
      ),
    );
  }
}
