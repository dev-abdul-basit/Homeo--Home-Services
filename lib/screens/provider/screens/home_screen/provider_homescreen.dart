import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman/screens/provider/provider_components/provider_coustom_bottom_nav_bar.dart';

import '../../../../helper/global_config.dart';
import '../../provider_components/provider_config.dart';
import '../../provider_constants.dart';
import '../../provider_enum.dart';
import 'components/body.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Import the firebase_core and cloud_firestore plugin

import 'package:firebase_database/firebase_database.dart';

class ProviderHomeScreen extends StatefulWidget {
  static String routeName = "/provider_home";

  const ProviderHomeScreen({Key? key}) : super(key: key);

  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  bool? error, sending, success;
  String? msg;
  String _address = '';
  String webUrl = providerbaseUrl + "/getproviderstatus.php";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    error = false;
    sending = false;
    success = false;
    msg = "";
    print('id');
    print(box!.get('id'));
    print(box!.get('status'));
    sendData();
    _getUserLocation();
  }

  void sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAK_aG2S4:APA91bEdT80xbI915lAdt7rMycCZW3ayWnnwDByQ25jp1Xiy-SLaq4pLm4RCy8qTl91ba6QFvQ6G5n8F4VdVys-TD2cljZoObB4pWTZieR4OafWcvmBd28c2FU7oLWAOnaliPUhieuP9',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

//Get Current LatLong
  LatLng currentPostion = const LatLng(0.0, 0.0);
  void _getUserLocation() async {
    Position _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPostion = LatLng(_position.latitude, _position.longitude);
      debugPrint('HOME PAGE');

      debugPrint('Current Lat long: ' + currentPostion.toString());
      debugPrint('Current Lat :' + currentPostion.latitude.toString());
      debugPrint('Current  long :' + currentPostion.longitude.toString());
      saveDataToFireBase(context, _position.latitude, _position.longitude);
    });
    // getting adress from latlong
    List<Placemark> placemarks =
        await placemarkFromCoordinates(_position.latitude, _position.longitude);
    Placemark placeMark = placemarks[0];
    String? name = placeMark.name;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;
    String address = " $subLocality, $locality,  $country";

    setState(() {
      _address = address; // update _address
    });
  }

  //Save Location to Firebase
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('Handyman_Location');
  saveDataToFireBase(BuildContext context, double lat, double lng) async {
// Create a CollectionReference called users that references the firestore collection

    _databaseReference.child(box!.get('id')).set({
      'id': box!.get('id'),
      'provider': box!.get('name'),
      'latitude': lat,
      'longitude': lng,
    }).onError(
      (error, stackTrace) => ('ERROR WRITING DATA TO FIREBASE DATABASE'),
    );
    //await _databaseReference.push().set(toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFormColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72.0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: kPrimaryColor,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 16, 0, 0),
                child: Text(
                  box!.get("name"),
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 4, 0, 8),
                child: Text(
                  _address,
                  style: subheadingStyleWhite,
                ),
              ),
            ],
          ),
        ),
      ),
      body: const Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(webUrl), body: {
      "id": box!.get("id"),
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print('Home:response:');
      print(res.body); //print raw response on console

      var data = json.decode(res.body);
      print('data:');
      // print(data); //decoding json to array
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

            box!.put("provider_login", true);
            box!.put("id", data["id"]);
            box!.put("name", data["name"]);
            box!.put("email", data["email"]);
            box!.put("password", data["password"]);
            box!.put("mobile", data["contact"]);
            // box!.put("adress", data["adress"]);
            box!.put("cnic", data["cnic"]);
            box!.put("gender", data["gender"]);
            box!.put("status", data["status"]);
            //mark success and refresh UI with setState

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
