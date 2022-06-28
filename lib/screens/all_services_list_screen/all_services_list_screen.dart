import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class ServicesListScreen extends StatefulWidget {
  static String routeName = "/service_list";
  const ServicesListScreen({
    Key? key,
    required this.serviceName,
  }) : super(key: key);
  final String serviceName;

  @override
  State<ServicesListScreen> createState() => _ServicesListScreenState();
}

class _ServicesListScreenState extends State<ServicesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: false,
        title: Text(
          widget.serviceName,
          style: const TextStyle(color: kTextColor),
        ),
      ),
      body: const Body(),
    );
  }
}
