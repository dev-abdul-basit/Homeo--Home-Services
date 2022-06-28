import 'package:flutter/material.dart';

import '../../../constants.dart';

class ServiceProviderInfo extends StatelessWidget {
  const ServiceProviderInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: kPrimaryLightColor.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Service Provider Name",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Mobile: 03450254505",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Adress, location",
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.call,
                  color: Colors.green,
                  size: 36,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
