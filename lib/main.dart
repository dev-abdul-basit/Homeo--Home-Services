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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory documentsDirectory = await getApplicationDocumentsDirectory();

  Hive.init(documentsDirectory.path);

  box = await Hive.openBox('easyLogin');
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocer App',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
