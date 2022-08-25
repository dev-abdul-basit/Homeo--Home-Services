import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';

import 'components/body.dart';

class ServicesSubCategories extends StatefulWidget {
  static String routeName = "/sub_categories";

  const ServicesSubCategories({
    Key? key,
    required this.serviceName,
    required this.sub1,
    required this.sub2,
    required this.sub3,
    required this.sub4,
    required this.sub5,
  }) : super(key: key);

  final String serviceName, sub1, sub2, sub3, sub4, sub5;

  @override
  State<ServicesSubCategories> createState() => _ServicesSubCategoriesState();
}

class _ServicesSubCategoriesState extends State<ServicesSubCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.serviceName,
          style: const TextStyle(color: kTextColor),
        ),
      ),
      body: Body(
        category: widget.serviceName,
        sub1: widget.sub1,
        sub2: widget.sub2,
        sub3: widget.sub3,
        sub4: widget.sub4,
        sub5: widget.sub5,
      ),
    );
  }
}
