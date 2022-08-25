import 'package:flutter/material.dart';

import 'service_list.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.service_name,
    required this.sub_cat,
    required this.service_title,
    required this.id,
  }) : super(key: key);
  final String service_name, sub_cat, service_title, id;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ServiceList(
      service_name: widget.service_name,
      sub_cat: widget.sub_cat,
      service_title: widget.service_title,
      id: widget.id,
    );
  }
}
