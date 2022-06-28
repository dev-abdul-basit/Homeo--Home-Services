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
    {"text": "Cleaning", "icon": "assets/images/burger.png"},
    {"text": "Repairing", "icon": "assets/images/pizza.png"},
    {"text": "Painting", "icon": "assets/images/italian.png"},
    {"text": "Laundary", "icon": "assets/images/chinese.png"},
    {"text": "Appliances", "icon": "assets/images/indian.png"},
    {"text": "Plumbing", "icon": "assets/images/pizza.png"},
    {"text": "Parlour", "icon": "assets/images/burger.png"},
    {"text": "More", "icon": "assets/images/review.png"},
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
