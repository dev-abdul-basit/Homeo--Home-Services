import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';

import 'components/body.dart';

class FavouriteServices extends StatefulWidget {
  static String routeName = "/fav_screen";
  const FavouriteServices({Key? key}) : super(key: key);

  @override
  State<FavouriteServices> createState() => _FavouriteServicesState();
}

class _FavouriteServicesState extends State<FavouriteServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Favourites",
        style: headingStyle,
      )),
      body: const Body(),
    );
  }
}
