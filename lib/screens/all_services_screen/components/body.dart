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
    {"text": "Cleaning", "icon": "assets/images/burger.png"},
    {"text": "Repairing", "icon": "assets/images/pizza.png"},
    {"text": "Painting", "icon": "assets/images/italian.png"},
    {"text": "Laundary", "icon": "assets/images/chinese.png"},
    {"text": "Appliances", "icon": "assets/images/indian.png"},
    {"text": "Plumbing", "icon": "assets/images/pizza.png"},
    {"text": "Parlour", "icon": "assets/images/burger.png"},
    {"text": "More", "icon": "assets/images/review.png"},
    {"text": "Repairing", "icon": "assets/images/pizza.png"},
    {"text": "Painting", "icon": "assets/images/italian.png"},
    {"text": "Laundary", "icon": "assets/images/chinese.png"},
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
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.white,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    //Navigator.pushNamed(context, ServicesListScreen.routeName);
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
              ),
            );
          }),
    );
  }
}
