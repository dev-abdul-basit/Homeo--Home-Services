import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../helper/global_config.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ServiceProviderInfo extends StatefulWidget {
  const ServiceProviderInfo({Key? key, required this.spId}) : super(key: key);
  final String spId;

  @override
  State<ServiceProviderInfo> createState() => _ServiceProviderInfoState();
}

class _ServiceProviderInfoState extends State<ServiceProviderInfo> {
  bool? error, sending, success;
  String? msg;
  String name = '';
  String mobile = '';
  String adress = '';

  String webUrl = baseUrlProvider + "/getproviderstatus.php";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    error = false;
    sending = false;
    success = false;
    msg = "";

    sendData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: kPrimaryLightColor.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    name == '' ? 'Loading' : name,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    mobile,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    adress,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.black87),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.call,
                  color: Colors.green,
                  size: 36,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
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

          sending = false;
          success = true;
          print(data["success"]);

          // add data to hive

          if (data["success"] == 1) {
            print("All done");
            print(data["id"]);
            print(data["status"]);
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
}
