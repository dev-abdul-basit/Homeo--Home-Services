import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/provider_components/bottom_bar.dart';

import '../../../../helper/global_config.dart';
import 'components/body.dart';

class ProviderServiceDetailScreen extends StatefulWidget {
  const ProviderServiceDetailScreen({
    Key? key,
    required this.title,
    required this.id,
    required this.speciality,
    required this.description,
    required this.note,
    required this.adress,
    required this.rate,
    required this.status,
    required this.spName,
    required this.spId,
    required this.serviceImages,
    required this.serviceImages1,
    required this.serviceImages2,
  }) : super(key: key);
  static String routeName = "/provider_service_detail";
  final String title,
      speciality,
      id,
      description,
      note,
      adress,
      rate,
      status,
      spName,
      spId,
      serviceImages,
      serviceImages1,
      serviceImages2;

  @override
  State<ProviderServiceDetailScreen> createState() =>
      _ProviderServiceDetailScreenState();
}

class _ProviderServiceDetailScreenState
    extends State<ProviderServiceDetailScreen> {
  bool isAdmin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (box!.containsKey("admin_login")) {
      setState(() {
        isAdmin = true;
      });
    } else {
      setState(() {
        isAdmin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        id: widget.id,
        title: widget.title,
        speciality: widget.speciality,
        description: widget.description,
        note: widget.note,
        adress: widget.adress,
        rate: widget.rate,
        status: widget.status,
        spName: widget.spName,
        spId: widget.spId,
        serviceImages: widget.serviceImages,
        serviceImages1: widget.serviceImages1,
        serviceImages2: widget.serviceImages2,
      ),
      bottomNavigationBar: Visibility(
        visible: isAdmin == true && widget.status == 'pending' ? true : false,
        child: BottomBar(
          id: widget.id,
          status: widget.status,
          p_token: widget.status,
        ),
      ),
    );
  }
}
