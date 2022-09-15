import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/routes.dart';
import 'package:handyman/screens/splash/splash_screen.dart';
import 'helper/global_config.dart';
import 'theme.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:firebase_core/firebase_core.dart';
//

import '../../../helper/global_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // Workmanager().initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode:
  //         true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  //     );
  // Workmanager().registerOneOffTask("task-identifier", "simpleTask");
  Directory documentsDirectory = await getApplicationDocumentsDirectory();

  Hive.init(documentsDirectory.path);

  box = await Hive.openBox('easyLogin');
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  runApp(const MyApp());
}

///////////////////////////
// const fetchBackground = "fetchBackground";

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
//       case fetchBackground:
//         Position _position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high,
//         );
//         print("\n---Workmanager Lat long---:\n");
//         print("\n$fetchBackground\n");
//         print(_position.toString());

//         break;
//     }
//     return Future.value(true);
//   });
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Workmanager().registerPeriodicTask(
    //   "1",
    //   fetchBackground,
    //   frequency: const Duration(seconds: 5000),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HandyMan',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
