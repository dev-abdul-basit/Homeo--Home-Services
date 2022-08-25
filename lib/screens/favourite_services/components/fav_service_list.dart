import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';
import 'package:handyman/screens/service_detail_screen/service_detail_screen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../helper/global_config.dart';

class FavServiceList extends StatefulWidget {
  const FavServiceList({Key? key}) : super(key: key);

  @override
  State<FavServiceList> createState() => _FavServiceListState();
}

class _FavServiceListState extends State<FavServiceList> {
  final ScrollController _controller = ScrollController();

  final String url = baseUrl + "provider/viewallservicesToUser.php";
  final String favServiceURL = baseUrl + "provider/view_favourites.php";

  late List data;

  var isLoading = false;

  @override
  void initState() {
    super.initState();
    getFavouriteData();
  }

  Future getFavouriteData() async {
    var response = await http.post(Uri.parse(favServiceURL), headers: {
      "Accept": "application/json"
    }, body: {
      "fav": '1',
    });

    setState(() {
      List convertDataToJson = json.decode(response.body)['result'];
      data = convertDataToJson;
      isLoading = true;
      print(data);
    });

    // throw Exception('Failed to load data');
  }

  @override
  Widget build(BuildContext context) {
    return myView();
  }

  Builder myView() {
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
                  onTap: () {
                    //Navigator.pushNamed(context, ServiceDetailScreen.routeName);
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceDetailScreen(
                                //first one will be available in next sceen
                                //second one we have here in this screen
                                title: data[index]['service_title'],
                                id: data[index]['id'],
                                speciality: data[index]['service_speciality'],
                                description: data[index]['service_description'],
                                note: data[index]['service_extra_note'],
                                adress: data[index]['adress'],
                                rate: data[index]['rate'],
                                status: data[index]['service_status'],
                                spName: data[index]['service_provider_name'],
                                spId: data[index]['service_provider_id'],
                                serviceImages: data[index]['service_images'],
                                serviceImages1: data[index]['image1'],
                                serviceImages2: data[index]['image2'],
                                fav: data[index]['fav'],
                              ),
                            ))
                        .then((value) => setState(() => {getFavouriteData()}));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: Row(
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
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                data[index]['image1'],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: data[index]
                                          ['service_provider_name'],
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: kTextColorSecondary,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Icon(
                                        Icons.verified,
                                        size: 20,
                                        color: data[index]
                                                    ['service_provider_name'] ==
                                                'pending'
                                            ? kTextColorSecondary
                                            : kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                data[index]['service_title'],
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: kTextColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                data[index]['rate'],
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const WidgetSpan(
                                      child: Icon(
                                        Icons.location_on,
                                        size: 18,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    // TextSpan(
                                    //   text: dataRating.length != 0
                                    //       ? dataRating[0]['rating']
                                    //       : 'No Reviews Yet',
                                    //   style: const TextStyle(
                                    //       fontSize: 14.0,
                                    //       color: kTextColor,
                                    //       fontWeight: FontWeight.w500),
                                    // ),
                                    TextSpan(
                                      text: data[index]['adress'],
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: kTextColorSecondary,
                                      ),
                                    ),
                                    // TextSpan(
                                    //   text: dataRating.length != 0
                                    //       ? dataRating.length.toString() +
                                    //           " Reviews"
                                    //       : '',
                                    //   style: const TextStyle(
                                    //       fontSize: 14.0,
                                    //       color: kTextColor,
                                    //       fontWeight: FontWeight.w500),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // IconButton(
                        //   icon: Icon(
                        //     _favourite
                        //         ? Icons.favorite_outline_rounded
                        //         : Icons.favorite,
                        //     color: kPrimaryColor,
                        //   ),
                        //   onPressed: () {
                        //     setState(() {
                        //       // _favourite = !_favourite;
                        //       _onSelected(index, _favourite);
                        //       print('index');
                        //     });
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
    required this.text,
    required this.press,
    required this.selected,
    required this.selectedColor,
  }) : super(key: key);
  final String text;
  final Function press;
  final bool selected;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: () {
          press();
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          primary: selectedColor,
          onPrimary: kSecondaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }
}
