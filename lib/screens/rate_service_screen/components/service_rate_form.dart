import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../components/custom_dialog.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../helper/keyboard.dart';

class ServiceRateForm extends StatefulWidget {
  const ServiceRateForm({Key? key}) : super(key: key);

  @override
  State<ServiceRateForm> createState() => _ServiceRateFormState();
}

class _ServiceRateFormState extends State<ServiceRateForm> {
  String ratingValue = "Good";
  String? _productreview;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 8, 24, 0),
            child: Text(
              ratingValue,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: Color(0xFF5FC0AC),
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Center(
          child: RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
              setState(() {
                if (rating <= 1) {
                  ratingValue = "Below Average";
                } else if (rating <= 2 && rating >= 1) {
                  ratingValue = "Average";
                } else if (rating <= 3 && rating >= 2) {
                  ratingValue = "Good";
                } else if (rating <= 4 && rating >= 3) {
                  ratingValue = "Very Good";
                } else if (rating <= 5 && rating >= 4) {
                  ratingValue = "Exellent";
                }
              });
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(key: _formKey, child: buildProdctReviewFormField()),
        ),
        //*********** */
        //*********** */

        Padding(
          padding: const EdgeInsets.fromLTRB(36.0, 0, 36, 56),
          child: DefaultButton(
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                debugPrint("Saved");
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      Timer(const Duration(seconds: 2), () {
                        _controller.clear();
                        Navigator.of(context).pop();
                      });
                      return const CustomDialog();
                    });
              }
            },
            text: "Submit",
          ),
        )
      ],
    );
  }

  TextFormField buildProdctReviewFormField() {
    return TextFormField(
      controller: _controller,
      cursorColor: kPrimaryColor,
      maxLines: 5,
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => _productreview = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter a Review";
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
        focusColor: kPrimaryColor,
        hintText: "Write review",
        fillColor: kFormColor.withOpacity(0.2),
        filled: true,
      ),
    );
  }
}
