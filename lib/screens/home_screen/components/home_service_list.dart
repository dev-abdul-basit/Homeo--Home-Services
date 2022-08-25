import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';
import 'package:handyman/screens/service_detail_screen/service_detail_screen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../../helper/global_config.dart';

class HomeServiceList extends StatefulWidget {
  const HomeServiceList({Key? key}) : super(key: key);

  @override
  State<HomeServiceList> createState() => _HomeServiceListState();
}

class _HomeServiceListState extends State<HomeServiceList> {
  final ScrollController _controller = ScrollController();

  final String url = baseUrl + "provider/viewallservicesToUser.php";
  final String serviceURL = baseUrl + "provider/viewall_with_filter.php";

  late List data;

  var isLoading = false;
  bool isAdmin = true;
  final List<String> _options = [
    'All',
    'Parlor',
    'Plumbing',
    'Appliances',
    'Laundary'
  ];

  final List<bool> _selected = [true, false, false, false, false];

  int? tappedIndex;
  @override
  void initState() {
    super.initState();
    tappedIndex = 0;

    if (tappedIndex == 0) {
      getAllData();
    }
  }

  Future getAllData() async {
    var response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "service_status": 'approve',
    });
    //print(response.body);
    setState(() {
      List convertDataToJson = json.decode(response.body)['result'];
      data = convertDataToJson;
      isLoading = true;
      print(data);
    });

    // throw Exception('Failed to load data');
  }

  Future getFilterData(String category) async {
    var response = await http.post(Uri.parse(serviceURL), headers: {
      "Accept": "application/json"
    }, body: {
      "service_speciality": category,
      "service_status": 'approve',
    });
    print('\nrating\n');
    //print(response.body);
    setState(() {
      List convertDataToJson = json.decode(response.body)['result'];
      data = convertDataToJson;
      isLoading = true;
      print(data);
    });

    // throw Exception('Failed to load data');
  }

  final String urlRating = baseUrlProvider + "get_reviews.php";

  List dataRating = [];
  Future getReviewsData(String id) async {
    var response = await http.post(Uri.parse(urlRating), headers: {
      "Accept": "application/json"
    }, body: {
      "service_id": id,
    });
    //print(response.body);
    setState(() {
      List convertDataToJson = json.decode(response.body)['result'];
      if (convertDataToJson != null) {
        dataRating = convertDataToJson;
        isLoading = true;
        print('reviews: ');

        print(dataRating);
      } else {
        print('No Data found');
      }
    });

    // throw Exception('Failed to load data');
  }

  int? _selectedIndex;
  _onSelected(int index, bool value) {
    //https://inducesmile.com/google-flutter/how-to-change-the-background-color-of-selected-listview-in-flutter/
    setState(() {
      _selectedIndex = index;
      _favourite = value;
      _favourite = !_favourite;
    });
  }

  bool _favourite = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 12),
            child: ListView.builder(
                itemCount: _options.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FilterButton(
                      text: _options[index],
                      selected: _selected[index],
                      selectedColor: tappedIndex == index
                          ? kPrimaryColor
                          : kTextColorSecondary,
                      press: () {
                        setState(() {
                          tappedIndex = index;
                          if (index == 0) {
                            getAllData();
                          } else {
                            getFilterData(_options[index]);
                            print(_options[index]);
                            myView();
                          }

                          print(index);
                        });
                      },
                    ),
                  );
                }),
          ),
        ),
        myView(),
      ],
    );
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
                        )).then((value) => setState(() => {getAllData()}));
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
