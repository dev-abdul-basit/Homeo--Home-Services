import 'package:flutter/material.dart';
import 'package:handyman/components/default_button.dart';
import 'package:handyman/screens/booking_summary/booking_summary.dart';

import '../../../constants.dart';

class SpecialInstructions extends StatefulWidget {
  const SpecialInstructions({Key? key}) : super(key: key);

  @override
  State<SpecialInstructions> createState() => _SpecialInstructionsState();
}

class _SpecialInstructionsState extends State<SpecialInstructions> {
  String? specialInstructions;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Instructions",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: buildSpecialInstructionsFormField(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 28, 24, 8),
            child: DefaultButton(
              press: () {
                Navigator.pushNamed(context, BookingSummary.routeName);
              },
              text: "Continue",
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildSpecialInstructionsFormField() {
    return TextFormField(
      maxLines: 4,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => specialInstructions = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter Your instructions";
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
        focusColor: kPrimaryColor,
        hintText: "Instructions",
        fillColor: kTextColorSecondary.withOpacity(0.2),
        filled: true,
      ),
    );
  }
}
