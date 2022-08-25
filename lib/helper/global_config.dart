library config.globals;

import 'package:hive/hive.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:async';

Box? box;
String baseUrl = "https://fluttercorner.000webhostapp.com/";
String baseUrlProvider = "https://fluttercorner.000webhostapp.com/provider/";
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
