import 'package:flutter/material.dart';
import 'package:handyman/helper/global_config.dart';

import '../../../constants.dart';
import 'service_summary.dart';
import 'user_info_header.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.uid,
    required this.serviceName,
    required this.b_date,
    required this.b_time,
    required this.b_hours,
    required this.b_price,
  }) : super(key: key);
  final String uid, serviceName, b_date, b_time, b_hours, b_price;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final String webUrl = baseUrlProvider + "provider_get_user_details.php";

  late List data;

  var isLoading = false;
  bool isAdmin = true;
  bool? error, sending, success;
  String? msg;

  String customerName = '';
  String customerMobile = '';
  String customerEmail = '';
  String customerAdress = '';

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
          isLoading = true;
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

            customerName = data['name'];
            customerMobile = data['contact'];
            customerEmail = data['email'];
            customerAdress = data['adress'];
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
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UserInfoHeader(
                name: customerName,
                email: customerEmail,
                contact: customerMobile,
                adress: customerAdress),
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
              uid: widget.uid,
              serviceName: widget.serviceName,
              b_date: widget.b_date,
              b_time: widget.b_time,
              b_hours: widget.b_hours,
              b_price: widget.b_price,
            ),
            const SizedBox(height: 16),

            //ServiceProviderInfo(),
          ],
        ),
      ),
    );
  }
}
