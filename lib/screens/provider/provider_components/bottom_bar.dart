import 'package:flutter/material.dart';

import 'dart:async';

import 'package:http/http.dart' as http;

import '../../../../helper/global_config.dart';
import '../provider_constants.dart';
import 'provider_default_button.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
    required this.id,
    required this.status,
    required this.p_token,
  }) : super(key: key);
  final String id, status, p_token;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    super.initState();
    print('idi');
    print(widget.id);
    print(widget.status);
    print(widget.p_token);
  }

  final String url = baseUrl + "adminVerifySP.php";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kFormColor,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  rejectService();
                },
                child: const Text(
                  "Reject",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: const BorderSide(color: Colors.red),
                  ),
                  padding: const EdgeInsets.only(bottom: 16, top: 16),
                  primary: Colors.white,
                  onPrimary: kPrimaryColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DefaultButton(
                press: () {
                  approveService();
                },
                text: "Approve",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future rejectService() async {
    var response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "id": widget.id,
      "status": 'reject',
    });
    //print(response.body);
    setState(() {
      print(response.body);
      sendPushMessage('Profile Rejected',
          'Your Profile can not be approved at the moment', widget.p_token);
      Navigator.of(context).pop();
    });

    // throw Exception('Failed to load data');
  }

  Future approveService() async {
    var response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "id": widget.id,
      "status": 'approve',
    });
    //print(response.body);
    setState(() {
      print(response.body);
      sendPushMessage(
          'Profile Accepted', 'You can now create Services', widget.p_token);
      Navigator.of(context).pop();
    });

    // throw Exception('Failed to load data');
  }
}
