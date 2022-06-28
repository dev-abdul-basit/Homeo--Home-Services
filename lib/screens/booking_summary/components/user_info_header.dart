import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';

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
              children: const <Widget>[
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Your Name",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "0343054546465",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "example@gmail.com",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Adress, house number, street, City, PK",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 8,
                ),
              ]),
        ),
      ),
    );
  }
}
