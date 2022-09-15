import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/provider_components/provider_default_button.dart';
import 'package:handyman/screens/provider/provider_components/provider_secondry_btn.dart';
import 'package:handyman/screens/provider/screens/home_screen/provider_homescreen.dart';

import '../../../../helper/global_config.dart';
import '../../../../size_config.dart';
import '../../provider_components/provider_config.dart';
import '../../provider_constants.dart';
import 'components/body.dart';
import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:http/http.dart' as http;

class ProviderOffersDetails extends StatefulWidget {
  const ProviderOffersDetails({
    Key? key,
    required this.uid,
    required this.id,
    required this.serviceName,
    required this.b_date,
    required this.b_time,
    required this.b_hours,
    required this.b_price,
    required this.booking_status,
  }) : super(key: key);
  final String uid,
      id,
      serviceName,
      b_date,
      b_time,
      b_hours,
      b_price,
      booking_status;
  static String routeName = "/provider_offer_detail";

  @override
  State<ProviderOffersDetails> createState() => _ProviderOffersDetailsState();
}

class _ProviderOffersDetailsState extends State<ProviderOffersDetails> {
  final String url = providerbaseUrl + "provider_manage_offers.php";

  Future rejectService() async {
    var response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "id": widget.id,
      "booking_status": 'reject',
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
      "booking_status": 'approve',
    });
    //print(response.body);
    setState(() {
      print(response.body);
      Navigator.of(context).pop();
    });

    // throw Exception('Failed to load data');
  }

  //get user TOKEN
  bool? error, sending, success;
  String? msg;
  final String webUrl = providerbaseUrl + "provider_get_user_details.php";
  Future<void> sendData() async {
    var res = await http.post(Uri.parse(webUrl), body: {
      "u_id": widget.uid,
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
          //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      } else {
        //after write success, make fields empty

        setState(() {
          msg = "success sendign data.";
          print(msg);

          sending = false;
          success = true;
          print(data["success"]);

          // add data to hive

          if (data["success"] == 1) {
            print("All done");
            print(data["id"]);
            print('user--token:\n');
            print(data['token']);
            box!.put('userToken', data['token']);
          } else {
            final snackBar = SnackBar(
              content: Text(data["success"] == 0 ? data["msg"] : data["msg"]),
            );
            //ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUserData();
    error = false;
    sending = false;
    success = false;
    msg = "";
    sendData();
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
          visible: widget.booking_status != 'pending' ? false : true,
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
                      sendPushMessage(
                          'Booking Rejected',
                          'Your booking has been rejected',
                          box!.get('userToken'));
                      // Navigator.pushNamedAndRemoveUntil(
                      //     (context), HomeScreen.routeName, (route) => false);
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
                      sendPushMessage(
                          'Booking Accepted',
                          'Your booking has been accepted',
                          box!.get('userToken'));
                    },
                    text: "Accept",
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
                  "Your have accepted the offer\nGo to Offer Section to see details",
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
                      Navigator.pushNamedAndRemoveUntil((context),
                          ProviderHomeScreen.routeName, (route) => false);
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
