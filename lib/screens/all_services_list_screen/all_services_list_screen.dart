import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class ServicesListScreen extends StatefulWidget {
  static String routeName = "/service_list";
  const ServicesListScreen({
    Key? key,
    required this.serviceName,
    required this.sub_cat,
    required this.service_title,
    required this.id,
  }) : super(key: key);
  final String serviceName, sub_cat, service_title, id;

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
          widget.serviceName == 'Empty' ? 'Services' : widget.serviceName,
          style: const TextStyle(color: kTextColor),
        ),
      ),
      body: Body(
        service_name: widget.serviceName,
        sub_cat: widget.sub_cat,
        service_title: widget.service_title,
        id: widget.id,
      ),
    );
  }
}
