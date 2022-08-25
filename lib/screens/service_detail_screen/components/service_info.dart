import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';

import '../../../helper/global_config.dart';
import '../../../size_config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ServiceInfo extends StatefulWidget {
  const ServiceInfo({
    Key? key,
    required this.id,
    required this.title,
    required this.speciality,
    required this.description,
    required this.note,
    required this.adress,
    required this.rate,
    required this.status,
    required this.spName,
    required this.spId,
    required this.serviceImages,
    required this.fav,
  }) : super(key: key);
  final String title,
      id,
      speciality,
      description,
      note,
      adress,
      rate,
      status,
      spName,
      spId,
      serviceImages,
      fav;

  @override
  State<ServiceInfo> createState() => _ServiceInfoState();
}

class _ServiceInfoState extends State<ServiceInfo> {
  bool? error, sending, success;
  String? msg;
  String webUrl = baseUrl + "provider/setFavourite.php";
  final String url = baseUrlProvider + "get_reviews.php";

  late List data;

  var isLoading = false;
  bool isAdmin = true;
  bool? _favourite;
  @override
  void initState() {
    super.initState();
    print('service id: ' + widget.id);
    if (widget.fav == '0') {
      _favourite = false;
    } else if (widget.fav == '1') {
      _favourite = true;
    }

    getReviewsData();

    error = false;
    sending = false;
    success = false;
    msg = "";
  }

  Future getReviewsData() async {
    var response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "service_id": widget.id.toString(),
    });
    //print(response.body);
    setState(() {
      List convertDataToJson = json.decode(response.body)['result'];
      if (convertDataToJson != null) {
        data = convertDataToJson;
        isLoading = true;
        print('reviews: ');

        print(data);
      } else {
        print('No Data found');
      }
    });

    // throw Exception('Failed to load data');
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return Container(
        margin: const EdgeInsets.only(left: 24, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: kTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _favourite == false
                        ? Icons.favorite_outline_rounded
                        : Icons.favorite,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _favourite = !_favourite!;
                      print(_favourite);
                      if (_favourite == true) {
                        print('1');
                        sendData('1');
                      } else {
                        print('0');
                        sendData('0');
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(8)),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.spName,
                        style: const TextStyle(
                          color: kPrimaryLightColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.verified,
                          size: 20,
                          color: widget.status == 'pending'
                              ? kTextColorSecondary
                              : kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.amber,
                        ),
                      ),
                      TextSpan(
                        text: data.length != 0
                            ? data[0]['rating']
                            : 'No Reviews Yet',
                        style: const TextStyle(
                            fontSize: 14.0,
                            color: kTextColor,
                            fontWeight: FontWeight.w500),
                      ),
                      const TextSpan(
                        text: " | ",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kTextColorSecondary,
                        ),
                      ),
                      TextSpan(
                        text: data.length != 0
                            ? data.length.toString() + " Reviews"
                            : '',
                        style: const TextStyle(
                            fontSize: 14.0,
                            color: kTextColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(8)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 120,
                  height: 32,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      widget.speciality,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.location_on,
                            size: 24,
                            color: kPrimaryColor,
                          ),
                        ),
                        const TextSpan(
                          text: " ",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: kTextColorSecondary,
                          ),
                        ),
                        TextSpan(
                          text: widget.adress,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: kTextColorSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(16),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Rs ",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                        TextSpan(
                          text: widget.rate,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                        const TextSpan(
                          text: " ( Per Hour ) ",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: kTextColorSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
    return const CircularProgressIndicator();
  }

  Future<void> sendData(String favValue) async {
    var res = await http.post(Uri.parse(webUrl), body: {
      "id": widget.id,
      "fav": favValue,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print('response:');
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["success"] == 0) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["msg"]; //error message from server
        });
      } else {
        setState(() {
          msg = "success sendign data.";
          print(msg);
          sending = false;
          success = true;
          print(data["msg"]);

          if (data["success"] == 1) {
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
