import 'package:flutter/material.dart';
import 'package:handyman/components/custom_service.dart';

import '../../all_services_list_screen/all_services_list_screen.dart';

class HomeServices extends StatefulWidget {
  const HomeServices({Key? key}) : super(key: key);

  @override
  State<HomeServices> createState() => _HomeServicesState();
}

class _HomeServicesState extends State<HomeServices> {
  List<Map<String, String>> servicesData = [
    {"text": "Cleaning", "icon": "assets/icons/cleaning.png"},
    {"text": "Carpenter", "icon": "assets/icons/carpenter.png"},
    {"text": "Laundry", "icon": "assets/icons/laundry.png"},
    {"text": "Painting", "icon": "assets/icons/painting.png"},
    {"text": "Electrician", "icon": "assets/icons/electrician.png"},
    {"text": "Plumbing", "icon": "assets/icons/plumbing.png"},
    {"text": "Parlour", "icon": "assets/icons/salon.png"},
    {"text": "Car Wash", "icon": "assets/icons/car_wash.png"},
  ];
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        controller: _controller,
        itemCount: servicesData.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 5.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
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
          );
        });
  }
}
