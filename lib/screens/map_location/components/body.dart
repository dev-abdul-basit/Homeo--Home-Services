import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/components/default_button.dart';
import '../../../constants.dart';
import '../../../helper/global_config.dart';
import '../../../helper/keyboard.dart';
import '../../home_screen/homescreen.dart';
import 'package:geocoding/geocoding.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng currentPostion = const LatLng(0.0, 0.0);
  String? searchText;
  final _formKey = GlobalKey<FormState>();

  String _address = "UnKnown Location";
  TextEditingController locationctrl = TextEditingController();
  bool? error, sending, success;
  String? msg;
  String webUrl = baseUrl + "flutterfyp/Updateadress.php";
  bool _enabled = false;
  void _toggle() {
    setState(() {
      _enabled = !_enabled;
    });
  }

  void _getUserLocation() async {
    Position _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPostion = LatLng(_position.latitude, _position.longitude);
      moveCamera(LatLng(_position.latitude, _position.longitude));
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
      locationctrl.text = _address.toString();
    });
  }

  Future<void> moveCamera(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: 15,
    )));
  }

  _onCameraMove(CameraPosition position) {
    currentPostion = position.target;
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();

    error = false;
    sending = false;
    success = false;
    msg = "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: Column(children: <Widget>[
                SizedBox(
                  child: Form(
                    key: _formKey,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              _toggle();
                            },
                            icon: const Icon(
                              Icons.edit_location_alt,
                              color: kPrimaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    controller: locationctrl,
                                    enabled: _enabled,

                                    key: Key(_address.toString()), // <- Magic!
                                    //initialValue: _address.toString(),

                                    maxLines: 3,
                                    style: const TextStyle(color: kTextColor),
                                    onSaved: (newValue) =>
                                        searchText = newValue,
                                    onChanged: (value) {
                                      if (value.isNotEmpty &&
                                          value != "UnKnown Location") {
                                        setState(() {
                                          _address = value;
                                        });
                                      }
                                      return;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter your adress";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        borderSide: const BorderSide(
                                            color: kPrimaryColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        borderSide: const BorderSide(
                                            color: kPrimaryColor),
                                      ),
                                      labelStyle:
                                          const TextStyle(color: kPrimaryColor),
                                      focusColor: kPrimaryColor,
                                      fillColor: kFormColor,
                                      filled: true,
                                      hintText: _address,
                                      label: const Text("Address"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  markers: {
                    Marker(
                      onTap: () {
                        debugPrint('Tapped');
                      },
                      draggable: true,
                      markerId: const MarkerId("Source"),
                      position: currentPostion,
                      onDragEnd: ((LatLng newPosition) {
                        debugPrint(newPosition.latitude.toString());
                        debugPrint(newPosition.longitude.toString());
                      }),
                    ),
                  },
                  initialCameraPosition: CameraPosition(
                    target: currentPostion,
                    zoom: 14.0,
                  ),
                  onCameraMove: _onCameraMove,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(48.0, 0.0, 48.0, 48.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      DefaultButton(
                        text: sending! ? "Please wait..." : "Save",
                        press: () {
                          updateAdress();
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //functions
  updateAdress() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        sending = true;
      });
      KeyboardUtil.hideKeyboard(context);

      sendData();
    }
  }

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(webUrl), body: {
      "id": box!.get("id"),
      "adress": locationctrl.text,
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
        locationctrl.text = _address.toString();

        //after write success, make fields empty

        setState(() {
          msg = "success sendign data.";
          print(msg);
          sending = false;
          success = true;
          print(data["msg"]);

          // add data to hive

          if (data["success"] == 1) {
            print(data["adress"]);

            box!.put("adress", locationctrl.text);

            //mark success and refresh UI with setState
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName, (route) => false);
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
        // print('_id:');
        // print(box!.get("_id"));

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
