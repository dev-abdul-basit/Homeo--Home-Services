import 'package:flutter/material.dart';
import 'package:handyman/helper/global_config.dart';

import '../../components/default_button.dart';
import '../../components/secondry_btn.dart';
import '../../constants.dart';
import '../../size_config.dart';
import '../home_screen/homescreen.dart';
import 'components/body.dart';
import 'dart:async';

import 'package:http/http.dart' as http;

class OffersDetails extends StatefulWidget {
  const OffersDetails({
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
  }) : super(key: key);
  final String uid,
      id,
      serviceName,
      b_date,
      b_time,
      b_hours,
      b_price,
      booking_status,
      user_booking_status;
  static String routeName = "/offer_detail";

  @override
  State<OffersDetails> createState() => _OffersDetailsState();
}

class _OffersDetailsState extends State<OffersDetails> {
  final String url = baseUrlProvider + "user_manage_offers.php";

  Future rejectService() async {
    var response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "id": widget.id,
      "user_booking_status": 'cancel',
    });
    //print(response.body);
    setState(() {
      print(response.body);
      Navigator.of(context).pop();
    });

    // throw Exception('Failed to load data');
  }

  Future approveService() async {
    var response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "id": widget.id,
      "user_booking_status": 'complete',
    });
    //print(response.body);
    setState(() {
      print(response.body);
      Navigator.of(context).pop();
    });

    // throw Exception('Failed to load data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: false,
          title: const Text(
            'Details',
            //widget.booking_status == 'approve' ? "In Progress" : 'Active',
            style: TextStyle(color: kTextColor),
          ),
        ),
        body: Body(
          uid: widget.uid,
          serviceName: widget.serviceName,
          b_date: widget.b_date,
          b_time: widget.b_time,
          b_hours: widget.b_hours,
          b_price: widget.b_price,
        ),
        bottomNavigationBar: Visibility(
          visible: widget.user_booking_status == 'complete' ? false : true,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SecondaryButton(
                    press: () {
                      print("id:");
                      print(widget.id);
                      rejectService();
                      const snackBar = SnackBar(
                        content: Text('You have cancelled your booking'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    text: "Cancel",
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(8)),
                Expanded(
                  child: DefaultButton(
                    press: () {
                      approveService();
                      //showConfirmationScreen(context);
                    },
                    text: "Finish Job",
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void showConfirmationScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      builder: ((context) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 24),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Image.asset(
                  "assets/images/paymentsuccess.png",
                  width: 200,
                  height: 200,
                ),
              ),
              const Expanded(
                child: Text(
                  "Congratulations",
                  style: TextStyle(
                      color: kPrimaryLightColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  "Your have the offer\nas Completed.Go to Completed Section to see details",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          (context), HomeScreen.routeName, (route) => false);
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.5 / 2),
                      decoration: BoxDecoration(
                          gradient: kPrimaryGradientColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          Text(
                            "Back to home",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
