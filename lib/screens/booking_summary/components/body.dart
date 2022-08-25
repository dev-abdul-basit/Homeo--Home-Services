import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';
import 'package:handyman/screens/booking_summary/components/service_provider_info.dart';

import '../../../components/default_button.dart';
import '../../../helper/global_config.dart';
import '../../home_screen/homescreen.dart';
import 'service_summary.dart';
import 'user_info_header.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({
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
      serviceImages2;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool? error, sending, success;
  String? msg;
  String name = '';
  String mobile = '';
  String adress = '';

  String webUrl = baseUrlProvider + "/getproviderstatus.php";
  String bookingUrl = baseUrlProvider + "bookings.php";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    error = false;
    sending = false;
    success = false;
    msg = "";

    print('ON BOOKING CONFIRMATION SCREEN**\n PROVIDER TOKEN:');
    print(box!.get('p_token'));

    sendData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const UserInfoHeader(),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Service Summary",
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),
            ServiceSummary(
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
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Service Provider Info",
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),
            ServiceProviderInfo(spId: widget.spId),
            const SizedBox(height: 48),
            DefaultButton(
              press: () {
                // showConfirmationScreen(context);
                print('userdetails');
                print(box!.get('name'));
                print(box!.get('mobile'));
                print(box!.get('email'));
                print(box!.get('adress'));
                print('Service Details');
                print(widget.title);
                print(box!.get('b_date'));
                print(box!.get('b_time'));
                print(box!.get('hours'));
                print(box!.get('instructions'));
                print("Total Price: " +
                    (int.parse(widget.rate) * box!.get('hours')).toString());

                print(name);
                print(adress);
                print(mobile);
                sendBookingDetails();
              },
              text: sending! ? "Please wait..." : "Cofirm & Book",
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendBookingDetails() async {
    var res = await http.post(Uri.parse(bookingUrl), body: {
      //provider info
      "sp_id": widget.spId.toString(),
      "sp_name": widget.spName,
      //user info
      "u_id": box!.get('id').toString(),
      "u_name": box!.get('name'),
      "adress": box!.get('adress'),
      //service details
      "service_id": widget.id.toString(),
      "service_title": widget.title,
      "service_cat": widget.speciality,
      "b_date": box!.get('b_date').toString(),
      "b_time": box!.get('b_time').toString(),
      "b_hours": box!.get('hours').toString(),
      "b_price": (int.parse(widget.rate) * box!.get('hours')).toString(),
      "booking_status": 'pending',
      "user_booking_status": 'true',
      "image": widget.serviceImages1,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print('response:');
      print(res.body); //print raw response on console

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
          print(data["success"]);

          // add data to hive

          if (data["success"] == 1) {
            print("All done");
            sendPushMessage('You have a new booking from ' + box!.get('name'),
                'New Booking', box!.get('p_token'));
            showConfirmationScreen(context);
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

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(webUrl), body: {
      "id": widget.spId,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print('response:');
      print(res.body); //print raw response on console

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
          print('Sending Noti');

          sending = false;
          success = true;
          print(data["success"]);

          // add data to hive

          if (data["success"] == 1) {
            print("All done");

            name = data['name'];
            mobile = data['contact'];
            adress = data['adress'];
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
                  "Your Booking has been confirmed.",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
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
