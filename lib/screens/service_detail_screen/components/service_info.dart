import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';

import '../../../size_config.dart';

class ServiceInfo extends StatefulWidget {
  const ServiceInfo({Key? key}) : super(key: key);

  @override
  State<ServiceInfo> createState() => _ServiceInfoState();
}

class _ServiceInfoState extends State<ServiceInfo> {
  bool _favourite = true;
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
              const Text(
                "House Cleaning",
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  _favourite ? Icons.favorite_outline_rounded : Icons.favorite,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _favourite = !_favourite;
                  });
                },
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
              const Text(
                "Jenny Wilson",
                style: TextStyle(
                  color: kPrimaryLightColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              RichText(
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
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(8),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 72,
                height: 32,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Cleaning",
                    style: TextStyle(
                      fontSize: 14,
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
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.location_on,
                          size: 24,
                          color: kPrimaryColor,
                        ),
                      ),
                      TextSpan(
                        text: " ",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kTextColorSecondary,
                        ),
                      ),
                      TextSpan(
                        text:
                            "Street 15, House 15 A, Bahria Phase 8, Rawalpindi",
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
            height: getProportionateScreenHeight(16),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Rs: 2500 ",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      TextSpan(
                        text: " ( Per Floor ) ",
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
