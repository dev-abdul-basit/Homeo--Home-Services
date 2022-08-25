import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProviderInfo extends StatefulWidget {
  const ProviderInfo({
    Key? key,
    required this.booking_id,
    required this.uid,
    required this.serviceName,
    required this.b_date,
    required this.b_time,
    required this.b_hours,
    required this.b_price,
    required this.service_id,
    required this.sp_name,
  }) : super(key: key);
  final String uid,
      serviceName,
      service_id,
      b_date,
      b_time,
      b_hours,
      b_price,
      booking_id,
      sp_name;
  @override
  State<ProviderInfo> createState() => _ProviderInfoState();
}

class _ProviderInfoState extends State<ProviderInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 2, 24, 16),
      child: Row(
        children: [
          // Column(
          //   children: <Widget>[
          //     Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(18),
          //       ),
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(14.0),
          //         child: const Image(
          //           image: AssetImage("assets/images/cleaner_2.png"),
          //           width: 72,
          //           height: 72,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    child: Text(
                      widget.sp_name,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 15.0,
                          color: kTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                    child: Text(
                      widget.b_price,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: kTextColorSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 4.0, right: 2),
                          child: Icon(
                            Icons.circle,
                            size: 8,
                            color: Color(0xFF5FC0AC),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: " Job Finished",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF5FC0AC),
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
