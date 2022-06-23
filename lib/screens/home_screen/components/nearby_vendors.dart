import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NearByVendors extends StatefulWidget {
  const NearByVendors({Key? key}) : super(key: key);

  @override
  State<NearByVendors> createState() => _NearByVendorsState();
}

class _NearByVendorsState extends State<NearByVendors> {
  var isLoading = false;
  final String url = "https://api.github.com/users";
  late List data;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
      Uri.parse(url),
    );
    //print(response.body);
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson;
      isLoading = true;
    });

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "Nearby Services",
                style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Ink(
                  height: 30,
                  width: 72,
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Map View",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Center(
              child: Builder(
                builder: (context) {
                  if (isLoading == true) {
                    return ListView.builder(
                      shrinkWrap: true,
                      controller: _controller,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            if (isLoading == true) {}
                          },
                          child: Ink(
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 1),
                              shadowColor: kFormColor,
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              child: Image(
                                                image: NetworkImage(
                                                    data[index]['avatar_url']),
                                                width: 72,
                                                height: 72,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: SizedBox(
                                            width: 200,
                                            child: Text(
                                              data[index]['login'],
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontSize: 20.0,
                                                  color: kTextColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: SizedBox(
                                            width: 200,
                                            child: Text(
                                              data[index]['login'],
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                color: kTextColorSecondary,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: SizedBox(
                                            width: 200,
                                            child: RichText(
                                              text: const TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: Icon(
                                                      Icons.location_on,
                                                      size: 14,
                                                      color: kPrimaryColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "Location",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color:
                                                          kTextColorSecondary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 24.0),
                                          child: RichText(
                                            text: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.star,
                                                    size: 18,
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: " 5",
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: kTextColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 24.0, top: 8),
                                          child: Text(
                                            "Open",
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                        // By default, show a loading spinner.
                      },
                    );
                  } else if (isLoading = false) {
                    return const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    );
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
