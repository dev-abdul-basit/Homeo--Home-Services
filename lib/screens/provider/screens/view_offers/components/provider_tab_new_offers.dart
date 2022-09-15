import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/screens/offers_detail/provider_offers_detail_screen.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../../helper/global_config.dart';
import '../../../provider_components/provider_config.dart';
import '../../../provider_constants.dart';

class NewOffers extends StatefulWidget {
  const NewOffers({Key? key}) : super(key: key);

  @override
  State<NewOffers> createState() => _NewOffersState();
}

class _NewOffersState extends State<NewOffers> {
  final ScrollController _controller = ScrollController();
  // final List<String> _listImages = [
  //   "assets/images/cleaner_2.png",
  //   "assets/images/cleaner_2.png",
  //   "assets/images/cleaner_2.png",
  //   "assets/images/cleaner_2.png",
  //   "assets/images/cleaner_2.png",
  //   "assets/images/cleaner_2.png",
  //   "assets/images/cleaner_2.png",
  //   "assets/images/cleaner_2.png",
  //   "assets/images/cleaner_2.png",
  // ];

  final String url = providerbaseUrl + "provider_view_bookings.php";
  // final String webUrl = baseUrl + "provider_get_user_details.php";

  late List data;

  var isLoading = false;
  bool isAdmin = true;

  @override
  void initState() {
    super.initState();
    print('id:..');
    print(box!.get('id'));
    getAllData();
  }

  Future getAllData() async {
    var response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "booking_status": 'pending',
      "user_booking_status": 'true',
      "sp_id": box!.get('id'),
    });
    //print(response.body);
    setState(() {
      List convertDataToJson = json.decode(response.body)['result'];
      data = convertDataToJson;
      isLoading = true;

      // print(id);
    });

    // throw Exception('Failed to load data');
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (isLoading == true) {
          return ListView.builder(
            controller: _controller,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 8,
                margin: const EdgeInsets.only(left: 24, right: 24, top: 16),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18.0),
                                child: Image(
                                  width: 96,
                                  height: 96,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    data[index]['image'],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(height: 4),
                                  Text(
                                    data[index]['service_title'],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: kTextColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data[index]['u_name'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: kTextColorSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Total Price " + data[index]['b_price'],
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    data[index]['adress'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: kTextColorSecondary,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                child: const Text(
                                  "View Details",
                                  style: TextStyle(
                                      fontSize: 12, color: kSecondaryColor),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProviderOffersDetails(
                                              //first one will be available in next sceen
                                              //second one we have here in this screen
                                              id: data[index]['id'],
                                              uid: data[index]['u_id'],
                                              serviceName: data[index]
                                                  ['service_title'],
                                              b_date: data[index]['b_date'],
                                              b_time: data[index]['b_time'],
                                              b_hours: data[index]['b_hours'],
                                              b_price: data[index]['b_price'],
                                              booking_status: data[index]
                                                  ['booking_status'],
                                            ),
                                          ))
                                      .then((value) =>
                                          setState(() => {getAllData()}));
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
