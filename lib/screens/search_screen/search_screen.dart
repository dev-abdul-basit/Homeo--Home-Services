import 'package:flutter/material.dart';
import 'package:handyman/helper/global_config.dart';
import 'package:handyman/screens/home_screen/homescreen.dart';

import '../../constants.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../all_services_list_screen/all_services_list_screen.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search_screen";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool? searching, error;
  var data;
  String? query;
  //String dataurl = baseUrl + "/provider/search.php" "?query=";
  String dataurl = baseUrl + "/provider/search.php";
  @override
  void initState() {
    searching = false;
    error = false;
    query = "";
    super.initState();
  }

  void getSuggestion() async {
    //get suggestion function
    var res = await http.post(
        Uri.parse(dataurl + "?query=" + Uri.encodeComponent(query!)),
        body: {
          "service_title": _controller.text,
        });
    //in query there might be unwant character so, we encode the query to url
    if (res.statusCode == 200) {
      setState(() {
        data = json.decode(res.body);
        print(data);
        if (data.toString().contains('true')) {
          print('eerrorooror');
          const snackBar = SnackBar(
            content: Text('No Results, Try again'),
          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        //update data value and UI
      });
    } else {
      //there is error
      setState(() {
        error = true;
      });
    }
  }

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          leading: searching!
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      searching = false;
                      //set not searching on back button press
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeScreen.routeName, ((route) => false));
                    });
                  },
                ),
          //if searching is true then show arrow back else play arrow
          title: searching! ? searchField() : const Text("Search Services"),
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    searching = true;
                  });
                }), // search icon button

            //add more icons here
          ],
          backgroundColor: searching! ? kPrimaryColor : kPrimaryLightColor,
          //if searching set background to orange, else set to deep orange
        ),
        body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                child: data == null
                    ? Container(
                        padding: const EdgeInsets.all(20),
                        child: searching!
                            ? Text(data.toString().contains('true')
                                ? 'No Results'
                                : "Please wait")
                            : const Text("Search any services")
                        //if is searching then show "Please wait"
                        //else show search peopels text
                        )
                    : Container(
                        child: searching!
                            ? showSearchSuggestions()
                            : const Text("Find any services"),
                      )
                // if data is null or not retrived then
                // show message, else show suggestion
                )));
  }

  Widget showSearchSuggestions() {
    List suggestionlist = List.from(data["data"].map((i) {
      return SearchSuggestion.fromJSON(i);
    }));
    //serilizing json data inside model list.
    return Column(
      children: suggestionlist.map((suggestion) {
        return InkResponse(
            onTap: () {
              //when tapped on suggestion
              print(suggestion.id); //pint student id
              print(suggestion.name); //pint student id
              //send to service list screen
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServicesListScreen(
                      serviceName: 'Empty',
                      sub_cat: 'Empty',
                      service_title: suggestion.name,
                      id: 'Empty',
                    ),
                  ));
            },
            child: SizedBox(
                width: double.infinity, //make 100% width
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      data.toString().contains('true')
                          ? 'Try Again, Nothing found'
                          : suggestion.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )));
      }).toList(),
    );
  }

  Widget searchField() {
    //search input field
    return Container(
        child: TextField(
      controller: _controller,
      autofocus: true,
      //textInputAction: TextInputAction.search,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
        hintText: "Search Services",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ), //under line border, set OutlineInputBorder() for all side border
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ), // focused border color
      ), //decoration for search input field
      onChanged: (value) {
        query = value; //update the value of query
        // getSuggestion(); //start to get suggestion
      },
      onSubmitted: (value) {
        getSuggestion();
      },
    ));
  }
}

//serarch suggestion data model to serialize JSON data
class SearchSuggestion {
  String id, name;
  SearchSuggestion({required this.id, required this.name});

  factory SearchSuggestion.fromJSON(Map<String, dynamic> json) {
    return SearchSuggestion(
      id: json["id"],
      name: json["service_title"],
    );
  }
}
