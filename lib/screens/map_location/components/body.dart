import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/components/default_button.dart';
import '../../../constants.dart';
import '../../home_screen/homescreen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.0,
  );

  String? searchText;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(48.0, 24.0, 48.0, 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                child: Form(
                  key: _formKey,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          onSaved: (newValue) => searchText = newValue,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {});
                            }
                            return;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return kEmailNullError;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor),
                            ),
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            focusColor: kPrimaryColor,
                            fillColor: kSecondaryColor,
                            filled: true,
                            hintText: "Search location here...",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: kPrimaryColor, // border color
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2), // border width
                            child: Container(
                              // or ClipRRect if you need to clip the content
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kPrimaryColor, // inner circle color
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ), // inner content
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DefaultButton(
                press: () {
                  // If user saves location, send user to Home
                  // if (_formKey.currentState!.validate()) {

                  //   Navigator.of(context).pushNamedAndRemoveUntil(
                  //       HomeScreen.routeName, (route) => false);
                  // }
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      HomeScreen.routeName, (route) => false);
                },
                text: ("Save"),
              )
            ],
          ),
        )
      ],
    ));
  }
}
