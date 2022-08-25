import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:handyman/screens/home_screen/homescreen.dart';

import '../../../components/custom_dialog.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../helper/global_config.dart';
import '../../../helper/keyboard.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ServiceRateForm extends StatefulWidget {
  const ServiceRateForm({
    Key? key,
    required this.booking_id,
    required this.uid,
    required this.serviceName,
    required this.b_date,
    required this.b_time,
    required this.b_hours,
    required this.b_price,
    required this.service_id,
    required this.sp_name,
    required this.sp_id,
  }) : super(key: key);
  final String uid,
      serviceName,
      service_id,
      b_date,
      b_time,
      b_hours,
      b_price,
      booking_id,
      sp_name,
      sp_id;

  @override
  State<ServiceRateForm> createState() => _ServiceRateFormState();
}

class _ServiceRateFormState extends State<ServiceRateForm> {
  bool? error, sending, success;
  String? msg;
  String name = '';
  String mobile = '';
  String adress = '';

  String ratingurl = baseUrlProvider + "ratings.php";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    error = false;
    sending = false;
    success = false;
    msg = "";
  }

  String reviewValue = "Very Good";
  String ratingPoints = "4.0";
  String? _reviewComment;
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
              reviewValue,
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
            initialRating: 4.0,
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
                rating = rating;
                print('rate' + rating.toString());

                if (rating <= 1) {
                  reviewValue = "Below Average";
                } else if (rating <= 2 && rating >= 1) {
                  reviewValue = "Average";
                } else if (rating <= 3 && rating >= 2) {
                  reviewValue = "Good";
                } else if (rating <= 4 && rating >= 3) {
                  reviewValue = "Very Good";
                } else if (rating <= 5 && rating >= 4) {
                  reviewValue = "Exellent";
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
              sendData();
            },
            text: "Submit",
          ),
        )
      ],
    );
  }

  sendData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // if all are valid then go to success screen
      KeyboardUtil.hideKeyboard(context);
      debugPrint("Saved");
      print('review: ' + reviewValue);
      print('Comment: ' + _reviewComment!);
      print('rating: ' + ratingPoints);
    }

    sendRatingDetails();
  }

  Future<void> sendRatingDetails() async {
    var res = await http.post(Uri.parse(ratingurl), body: {
      //provider info
      "p_id": widget.sp_id.toString(),
      "u_id": box!.get('id').toString(),
      //user info
      "service_id": widget.service_id.toString(),
      "user_name": box!.get('name'),
      "user_image": box!.get('uimage'),
      //service details
      "rating": ratingPoints.toString(),
      "rating_value": reviewValue.toString(),
      "review_text": _reviewComment.toString(),

      "review_status": 'true',
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print('response:');
      // print(res.body); //print raw response on console

      var data = json.decode(res.body);
      print('data:');
      print(data); //decoding json to array
      if (data["success"] == 0) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["msg"]; //error message from server
          final snackBar = SnackBar(
            content: Text(data["msg"]),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      } else {
        setState(() {
          msg = "success sendign data.";
          print(msg);

          sending = false;
          success = true;
          print(data["rating"]);

          // add data to hive

          if (data["success"] == 1) {
            print("Review Sent");

            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  Timer(const Duration(seconds: 2), () {
                    _controller.clear();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.routeName, ((route) => false));
                  });
                  return const CustomDialog();
                });
          } else {
            final snackBar = SnackBar(
              content: Text(data["success"] == 0 ? data["msg"] : data["msg"]),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            print(data["msg"]);
          }
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "Error during sendign data.";
        print(msg);
        print(res.body);
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }

  TextFormField buildProdctReviewFormField() {
    return TextFormField(
      controller: _controller,
      cursorColor: kPrimaryColor,
      maxLines: 5,
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => _reviewComment = newValue!,
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
