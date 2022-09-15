import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../provider_components/provider_config.dart';
import '../../../provider_constants.dart';

class ReviewsContainer extends StatefulWidget {
  const ReviewsContainer({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<ReviewsContainer> createState() => _ReviewsContainerState();
}

class _ReviewsContainerState extends State<ReviewsContainer> {
  final List<String> _listImages = [
    "assets/images/cleaner_2.png",
    "assets/images/cleaner_2.png",
    "assets/images/cleaner_2.png",
    "assets/images/cleaner_2.png",
    "assets/images/cleaner_2.png",
  ];
  final ScrollController _controller = ScrollController();

  final String url = providerbaseUrl + "get_reviews.php";

  late List data;

  var isLoading = false;
  bool isAdmin = true;

  @override
  void initState() {
    super.initState();
    print('service id: ' + widget.id);

    getReviewsData();
  }

  Future getReviewsData() async {
    var response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "service_id": widget.id.toString(),
    });
    //print(response.body);
    setState(() {
      List convertDataToJson = json.decode(response.body)['result'];
      if (convertDataToJson != null) {
        data = convertDataToJson;
        isLoading = true;
        print('reviews: ');

        print(data);
      } else {
        print('No Data found');
      }
    });

    // throw Exception('Failed to load data');
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return Container(
        margin: const EdgeInsets.only(left: 24, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.amber,
                        ),
                      ),
                      TextSpan(
                        text: data.length != 0
                            ? data[0]['rating']
                            : 'No Reviews Yet',
                        style: const TextStyle(
                            fontSize: 14.0,
                            color: kTextColor,
                            fontWeight: FontWeight.w500),
                      ),
                      const TextSpan(
                        text: " | ",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: kTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: data.length != 0
                            ? data.length.toString() + " Reviews"
                            : '',
                        style: const TextStyle(
                            fontSize: 14.0,
                            color: kTextColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "View All",
                    style: TextStyle(
                        fontSize: 12,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            ListView.builder(
              controller: _controller,
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(providerbaseUrl +
                                "flutterfyp/" +
                                data[index]['user_image']),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: Text(
                            data[index]['user_name'],
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          )),
                          RichText(
                            text: TextSpan(
                              children: [
                                const WidgetSpan(
                                  child: Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.amber,
                                  ),
                                ),
                                TextSpan(
                                  text: data[index]['rating'],
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      color: kTextColorSecondary,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: kFormColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 32.0, right: 16, top: 8, bottom: 8),
                        child: Text(
                          data[index]['review_text'],
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: kTextColor.withOpacity(0.5),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Divider(
                      color: kPrimaryColor.withOpacity(0.3),
                      height: 1,
                      thickness: 1,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
