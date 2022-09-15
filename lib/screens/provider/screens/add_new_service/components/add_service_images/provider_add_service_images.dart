import 'package:flutter/material.dart';

import '../../../../provider_constants.dart';
import 'components/body.dart';

class AddServiceImages extends StatefulWidget {
  static String routeName = "/add_service_images";
  const AddServiceImages({
    Key? key,
    required this.title,
    required this.speciality,
    required this.description,
    required this.note,
    required this.adress,
    required this.rate,
    required this.sub_cat,
  }) : super(key: key);
  final String title, speciality, description, note, adress, rate, sub_cat;

  @override
  State<AddServiceImages> createState() => _AddServiceImagesState();
}

class _AddServiceImagesState extends State<AddServiceImages> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("Data");
    print(widget.title);
    print(widget.speciality);
    print(widget.adress);
    print(widget.note);
    print(widget.description);
    print(widget.rate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: false,
        title: const Text(
          "Add Images",
          style: TextStyle(color: kTextColor),
        ),
      ),
      body: Body(
        title: widget.title,
        speciality: widget.speciality,
        description: widget.description,
        note: widget.note,
        adress: widget.adress,
        rate: widget.rate,
        sub_cat: widget.sub_cat,
      ),
    );
  }
}
