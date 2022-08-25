import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/components/default_button.dart';
import 'package:handyman/screens/all_services_list_screen/all_services_list_screen.dart';
import '../../../constants.dart';
import '../../../helper/global_config.dart';
import '../../../helper/keyboard.dart';
import '../../home_screen/homescreen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final Completer<GoogleMapController> _controller = Completer();
  LatLng currentPostion = const LatLng(0.0, 0.0);
  String _address = '';

  void _getUserLocation() async {
    Position _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPostion = LatLng(_position.latitude, _position.longitude);
      moveCamera(LatLng(_position.latitude, _position.longitude));
      print("\n---Current Lat long---:\n");
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
    String address = " $subLocality, $locality,  $country";

    setState(() {
      _address = address; // update _address
    });
  }

  Future<void> moveCamera(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: 13,
    )));
  }

  _onCameraMove(CameraPosition position) {
    currentPostion = position.target;
  }

  List<String> myAllData = [];

  var myList = [];
  List<LatLng> list = [];
  //Get Location to Firebase
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('Handyman_Location');
  void firebaseRead() {
    _databaseReference.onValue.listen((DatabaseEvent event) {
      var snapshot = event.snapshot;

      snapshot.children.forEach((child) {
        print(child.key);
        myList.add(child.value);
      });
      print(myList);
      print(myList.length);
      setState(() {
        for (int x = 0; x < myList.length; x++) {
          double latitude = myList[x]['latitude'];
          double longitude = myList[x]['longitude'];
          String providerName = myList[x]['provider'];
          String id = myList[x]['id'];
          // LatLng latLng = myList[x]['latLng'] as LatLng;

          print('latlng from firebasae');

          LatLng location = LatLng(latitude, longitude);
          print(location);
          if (list.contains(location)) {
            list.clear();
            list.add(location);
          } else {
            list.add(location);
          }

          //Passing a dynamic marker id as the index here.
          addMarker(list[x], x, providerName, id);
        }
      });
    });
    //print(list);
  }

  //Adding Index here as an argument
  void addMarker(loc, index, provider, id) {
    //Making this markerId dynamic
    final MarkerId markerId = MarkerId('Marker $index');

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(loc.latitude, loc.longitude),
      infoWindow: InfoWindow(
          title: '$provider',
          onTap: () {
            getBottomSheet(context, '$provider', id);
          }),
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
      //print(marker);
    });
  }

  @override
  void initState() {
    super.initState();
//get current location and marker, and show on map
    _getUserLocation();
    firebaseRead();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  compassEnabled: true,
                  buildingsEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  markers: Set.of(markers.values), //markers to show on map
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
                        text: "Back",
                        press: () {
                          Navigator.of(context).pop();
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

  void getBottomSheet(BuildContext context, String providerName, String id) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      builder: ((context) {
        return Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 32),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    color: kPrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            "Handy Services",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.map,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(providerName)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: DefaultButton(
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServicesListScreen(
                                serviceName: 'Empty',
                                sub_cat: 'Empty',
                                service_title: 'Empty',
                                id: id,
                              ),
                            ));
                      },
                      text: 'View Services',
                    ),
                  )
                  // Row(
                  //   children: const <Widget>[
                  //     SizedBox(
                  //       width: 20,
                  //     ),
                  //     Icon(
                  //       Icons.call,
                  //       color: Colors.blue,
                  //     ),
                  //     SizedBox(
                  //       width: 20,
                  //     ),
                  //     Text("040-123456")
                  //   ],
                  // )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                    child: const Icon(Icons.navigation),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServicesListScreen(
                              serviceName: 'Empty',
                              sub_cat: 'Empty',
                              service_title: 'Empty',
                              id: id,
                            ),
                          ));
                    }),
              ),
            )
          ],
        );
      }),
    );
  }
}
