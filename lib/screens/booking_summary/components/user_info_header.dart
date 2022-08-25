import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';

import '../../../helper/global_config.dart';

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: kFormColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 8,
                ),
                Text(
                  box!.get('name'),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  box!.get('mobile'),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  box!.get('email'),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  box!.get('adress'),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
              ]),
        ),
      ),
    );
  }
}
