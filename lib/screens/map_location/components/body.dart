import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/components/default_button.dart';
import '../../../constants.dart';
import '../../home_screen/homescreen.dart';
import 'package:geocoding/geocoding.dart';

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

  void _getUserLocation() async {
    Position _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPostion = LatLng(_position.latitude, _position.longitude);
      moveCamera(LatLng(_position.latitude, _position.longitude));
      print("latlong::");
      print(currentPostion);
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
    String address =
        "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";

    setState(() {
      print("address:::");
      print(address);
      _address = address; // update _address
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
            height: 150,
            child: Column(children: <Widget>[
              SizedBox(
                child: Form(
                  key: _formKey,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              key: Key(_address.toString()), // <- Magic!
                              //initialValue: _address.toString(),

                              initialValue:
                                  _address.toString() == "UnKnown Location"
                                      ? "Enter Adress"
                                      : _address.toString(),
                              maxLines: 3,
                              style: const TextStyle(color: kTextColor),
                              onSaved: (newValue) => searchText = newValue,
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
                                if (value!.isEmpty ||
                                    value == ("Enter Adress")) {
                                  return "Please enter your adress";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide:
                                      const BorderSide(color: kPrimaryColor),
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
                      markerId: const MarkerId("Source"),
                      position: currentPostion),
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
                      press: () {
                        // If user saves location, send user to Home
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              HomeScreen.routeName, (route) => false);
                        }
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     HomeScreen.routeName, (route) => false);
                      },
                      text: ("Save"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
