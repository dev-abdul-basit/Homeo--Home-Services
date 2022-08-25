import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:handyman/components/coustom_bottom_nav_bar.dart';
import 'package:handyman/constants.dart';
import 'package:handyman/enum.dart';

import '../../helper/global_config.dart';
import '../favourite_services/favourite_screen.dart';
import 'components/body.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:async';

import 'package:flutter/foundation.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? error, sending, success;
  String? msg;
  //String webUrl = "https://cwp-handyman.herokuapp.com/login";
  String webUrl = baseUrl + "flutterfyp/get_current_user.php";
  String? mtoken = " ";

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    error = false;
    sending = false;
    success = false;
    msg = "";
    // requestPermission();
    // loadFCM();
    // listenFCM();
    getUserData();
    //getDeviceToken();
    print('user token from login');
    print(box!.get('token'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72.0),
        child: AppBar(
          backgroundColor: kPrimaryColor,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 16, 0, 0),
                child: Text(
                  box!.get("name"),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 4, 0, 8),
                child: Text(
                  box!.get("adress"),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: headingStyleWhite,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 16, 0, 0),
              child: IconButton(
                visualDensity:
                    const VisualDensity(horizontal: -4.0, vertical: -4.0),
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, FavouriteServices.routeName);
                  // sendPushMessage('Noti', 'Noti', mtoken!);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 16, 18, 0),
              child: IconButton(
                visualDensity:
                    const VisualDensity(horizontal: -4.0, vertical: -4.0),
                icon: const Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(8.0, 20, 20, 0),
            //   child: GestureDetector(
            //     onTap: () {},
            //     child: const CircleAvatar(
            //       radius: 18.0,
            //       backgroundImage: AssetImage("assets/images/user.png"),
            //       backgroundColor: Colors.transparent,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      body: const Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }

  Future<void> getDeviceToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print('Token:' + mtoken!);
      });
    });
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

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  Future<void> getUserData() async {
    var res = await http.post(Uri.parse(webUrl), body: {
      "id": box!.get('id'),
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
          final snackBar = SnackBar(
            content: Text(data["msg"]),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      } else {
        //after write success, make fields empty

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
            box!.put("login", "true");
            box!.put("id", data["id"]);
            box!.put("name", data["name"]);
            box!.put("email", data["email"]);
            box!.put("password", data["password"]);
            box!.put("mobile", data["contact"]);
            box!.put("adress", data["adress"]);
            box!.put("uimage", data["uimage"]);
            // box!.put("my_token", data["my_token"]);
            box!.put("status", data["status"]);
            box!.put("token", data["token"]);
            //mark success and refresh UI with setState
            // Navigator.pushNamed(context, LocationPermissionScreen.routeName);
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
