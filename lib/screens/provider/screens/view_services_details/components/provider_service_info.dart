import 'package:flutter/material.dart';

import '../../../../../helper/global_config.dart';
import '../../../../../size_config.dart';
import '../../../provider_constants.dart';

class ServiceInfo extends StatefulWidget {
  const ServiceInfo({
    Key? key,
    required this.id,
    required this.title,
    required this.speciality,
    required this.description,
    required this.note,
    required this.adress,
    required this.rate,
    required this.status,
    required this.spName,
    required this.spId,
    required this.serviceImages,
  }) : super(key: key);
  final String title,
      id,
      speciality,
      description,
      note,
      adress,
      rate,
      status,
      spName,
      spId,
      serviceImages;
  @override
  State<ServiceInfo> createState() => _ServiceInfoState();
}

class _ServiceInfoState extends State<ServiceInfo> {
  bool _favourite = true;
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
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.title,
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Visibility(
                visible: false,
                child: IconButton(
                  icon: Icon(
                    _favourite
                        ? Icons.favorite_outline_rounded
                        : Icons.favorite,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _favourite = !_favourite;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(8),
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.spName,
                style: const TextStyle(
                  color: kPrimaryLightColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Visibility(
                visible: isAdmin == true ? false : true,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.amber,
                        ),
                      ),
                      TextSpan(
                        text: "4.5",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kTextColorSecondary,
                        ),
                      ),
                      TextSpan(
                        text: " | ",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kTextColorSecondary,
                        ),
                      ),
                      TextSpan(
                        text: "40 Reviews",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kTextColorSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(8),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 120,
                height: 32,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    widget.speciality,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(
                          Icons.location_on,
                          size: 24,
                          color: kPrimaryColor,
                        ),
                      ),
                      const TextSpan(
                        text: " ",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kTextColorSecondary,
                        ),
                      ),
                      TextSpan(
                        text: widget.adress,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: kTextColorSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(16),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: " Price  ",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kTextColorSecondary,
                        ),
                      ),
                      TextSpan(
                        text: widget.rate,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      const TextSpan(
                        text: " ( PKR ) ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: kTextColorSecondary,
                        ),
                      ),
                      const TextSpan(
                        text: " ( Per Hour ) ",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kTextColorSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
