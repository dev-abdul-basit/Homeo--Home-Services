import 'package:flutter/material.dart';
import 'package:handyman/screens/all_services_list_screen/all_services_list_screen.dart';

import '../../../components/custom_service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Map<String, String>> servicesData = [
    {"text": "Cleaning", "icon": "assets/icons/cleaning.png"},
    {"text": "Carpenter", "icon": "assets/icons/carpenter.png"},
    {"text": "Laundry", "icon": "assets/icons/laundry.png"},
    {"text": "Painting", "icon": "assets/icons/painting.png"},
    {"text": "Electrician", "icon": "assets/icons/electrician.png"},
    {"text": "Plumbing", "icon": "assets/icons/plumbing.png"},
    {"text": "Parlour", "icon": "assets/icons/salon.png"},
    {"text": "Car Wash", "icon": "assets/icons/car_wash.png"},
    {"text": "Shifting", "icon": "assets/icons/shifting.png"},
    {"text": "Appliances", "icon": "assets/icons/appliances.png"},
    {"text": "Repairing", "icon": "assets/icons/repairing.png"},
  ];
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 16, 8, 8),
      child: GridView.builder(
          controller: _controller,
          itemCount: servicesData.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServicesListScreen(
                            serviceName: servicesData[index]['text']!),
                      ));
                },
                child: CustomService(
                  icon: servicesData[index]['icon']!,
                  text: servicesData[index]['text']!,
                ),
              ),
            );
          }),
    );
  }
}
