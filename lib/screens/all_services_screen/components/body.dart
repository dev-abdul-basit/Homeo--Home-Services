import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../components/custom_service.dart';
import '../../../helper/global_config.dart';
import '../../services_sub_categories/services_sub_categories.dart';
import 'package:http/http.dart' as http;

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

  final String url = baseUrlProvider + "admin_get_all_cat.php";

  late List data;

  var isLoading = false;
  Future getAllCategories() async {
    print('\nAll Cat\n');
    var response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "cat_status": 'true',
    });

    print(response.body);
    setState(() {
      var convertDataToJson = json.decode(response.body)['result'];
      data = convertDataToJson;
      isLoading = true;
      print(data);
    });
  }

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (isLoading == true) {
          return GridView.builder(
              controller: _controller,
              itemCount: data.length,
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
                          builder: (context) => ServicesSubCategories(
                            serviceName: data[index]['cat_title'] ?? '',
                            sub1: data[index]['sub1'] ?? '',
                            sub2: data[index]['sub2'] ?? '',
                            sub3: data[index]['sub3'] ?? '',
                            sub4: data[index]['sub4'] ?? '',
                            sub5: data[index]['sub5'] ?? '',
                          ),
                        ));
                  },
                  child: CustomService(
                    icon: data[index]['cat_image'],
                    text: data[index]['cat_title'],
                  ),
                );
              });
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
