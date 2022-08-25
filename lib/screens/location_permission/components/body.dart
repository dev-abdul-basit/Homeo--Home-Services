import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';
import 'package:handyman/helper/global_config.dart';
import 'package:handyman/screens/map_location/map_location_screen.dart';
import '../../../../components/default_button.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/cupertino.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    // _checkForPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(24.0, 48, 24, 24),
              child: Image(
                image: AssetImage(
                  "assets/images/location.png",
                ),
                width: 200.0,
                height: 200.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "Allow ${"AppName"} to use \nyour location",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kTextColor),
              )),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "This app requires access to your\nlocation to match with the nearest\nService Providers! ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
              ),
            ),
            //Set up Location and send user to map
            Padding(
              padding: const EdgeInsets.fromLTRB(48.0, 48, 48, 24),
              child: DefaultButton(
                press: () {
                  _checkForPermissions();
                },
                text: "Allow",
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(48.0, 8, 48, 8),
              child: OutlinedButton(
                child: const Text(
                  "Allow while using app",
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  _checkForPermissions();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: kPrimaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                  primary: kPrimaryColor,
                  onSurface: kPrimaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(48.0, 24, 48, 24),
              child: OutlinedButton(
                child: const Text(
                  "Don't Allow",
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  _checkForPermissions();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: kPrimaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                  primary: kPrimaryColor,
                  onSurface: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Permission Check

//Check contacts permission
  Future _checkForPermissions() async {
    final PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      box!.put('permissions', 'true');
      Navigator.pushNamed(context, MapScreen.routeName);
    } else if (permissionStatus == PermissionStatus.denied) {
      //If permissions have been denied show standard cupertino alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Permissions error'),
          content: const Text('Please enable Location access '
              'in system settings'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    }
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.location.status;

    if (permission != PermissionStatus.granted ||
        permission == PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus = await [
        Permission.location,
      ].request();
      return permissionStatus[Permission.location] ??
          PermissionStatus.restricted;
    } else {
      return permission;
    }
  }
}
