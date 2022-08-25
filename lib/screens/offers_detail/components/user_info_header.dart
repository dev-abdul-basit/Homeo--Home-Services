import 'package:flutter/material.dart';

import '../../../constants.dart';


class UserInfoHeader extends StatefulWidget {
  const UserInfoHeader({
    Key? key,
    required this.name,
    required this.email,
    required this.contact,
    required this.adress,
  }) : super(key: key);
  final String name, email, contact, adress;

  @override
  State<UserInfoHeader> createState() => _UserInfoHeaderState();
}

class _UserInfoHeaderState extends State<UserInfoHeader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: kTextColorSecondary.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 8),
              Text(
                "Customer Name" + widget.name,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                "Mobile: " + widget.contact,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                "Email: " + widget.email,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                "Adress: " + widget.adress,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
