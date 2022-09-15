import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/screens/home_screen/provider_homescreen.dart';
import 'package:handyman/screens/provider/screens/view_services_details/components/provider_about_section.dart';
import 'package:handyman/screens/provider/screens/view_services_details/components/provider_reviews_container.dart';
import 'package:handyman/screens/provider/screens/view_services_details/components/provider_service_info.dart';
import 'package:handyman/screens/provider/screens/view_services_details/components/provider_show_work_images.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../helper/global_config.dart';
import '../../../../../size_config.dart';
import '../../../provider_components/provider_config.dart';
import '../../../provider_components/provider_delete_dialog.dart';
import '../../../provider_components/provider_header_image.dart';
import '../../../provider_constants.dart';

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
      description,
      note,
      id,
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
  bool isAdmin = false;
  final List<String> _listImages = [];
  bool? error, sending, success;
  String? msg;
  String webUrl = providerbaseUrl + "delete_service.php";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (box!.containsKey("admin_login")) {
      setState(() {
        isAdmin = true;
      });
    } else {
      setState(() {
        isAdmin = false;
      });
      error = false;
      sending = false;
      success = false;

      msg = "";
    }

    _listImages.add(widget.serviceImages);
    _listImages.add(widget.serviceImages1);
    _listImages.add(widget.serviceImages2);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(children: <Widget>[
            ServiceImageHeader(
              listImages: [
                widget.serviceImages,
                widget.serviceImages1,
                widget.serviceImages2
              ],
            ),
            Positioned(
              top: 44,
              left: 24,
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        color: kFormColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(36)),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: kTextColorSecondary,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 44,
              right: 24,
              child: Center(
                child: InkWell(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          // Navigator.of(context).pop();

                          return CustomDeleteDialog(
                            press: () {
                              sendData();
                            },
                            close: () {
                              Navigator.of(context).pop();
                            },
                          );
                        });
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        color: kFormColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(36)),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
          SizedBox(
            height: getProportionateScreenHeight(12),
          ),
          ServiceInfo(
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
            serviceImages: '',
          ),
          SizedBox(
            height: getProportionateScreenHeight(12),
          ),
          const Divider(
            color: kFormColor,
            height: 2,
            thickness: 2,
          ),
          SizedBox(
            height: getProportionateScreenHeight(12),
          ),
          AboutSection(
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
            serviceImages: '',
          ),
          SizedBox(
            height: getProportionateScreenHeight(12),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                isAdmin == true ? "Work ID" : "",
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 12,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Visibility(
              visible: isAdmin == true ? true : false,
              child: const WorkImagesGridView()),
          //const WorkImagesGridView(),
          SizedBox(
            height: getProportionateScreenHeight(12),
          ),
          const Divider(
            color: kFormColor,
            height: 8,
            thickness: 8,
          ),
          SizedBox(
            height: getProportionateScreenHeight(24),
          ),
          Visibility(
              visible: isAdmin == true ? false : true,
              child: ReviewsContainer(id: widget.id)),
        ],
      ),
    );
  }

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(webUrl), body: {
      "id": widget.id.toString(),
      "service_provider_id": widget.spId.toString(),
      "service_status": 'delete',
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
          Navigator.of(context).pushNamedAndRemoveUntil(
            ProviderHomeScreen.routeName,
            (route) => false,
          );
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
