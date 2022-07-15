import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';
import 'package:handyman/screens/service_detail_screen/service_detail_screen.dart';

class HomeServiceList extends StatefulWidget {
  const HomeServiceList({Key? key}) : super(key: key);

  @override
  State<HomeServiceList> createState() => _HomeServiceListState();
}

class _HomeServiceListState extends State<HomeServiceList> {
  final ScrollController _controller = ScrollController();
  final List<String> _listImages = [
    "assets/images/cleaner_2.png",
    "assets/images/repair_man.jpg",
    "assets/images/wall_painting.jpg",
    "assets/images/cleaner_2.png",
    "assets/images/repair_man.jpg",
    "assets/images/wall_painting.jpg",
    "assets/images/cleaner_2.png",
    "assets/images/repair_man.jpg",
    "assets/images/wall_painting.jpg",
  ];
  bool _favourite = true;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return ListView.builder(
          controller: _controller,
          shrinkWrap: true,
          itemCount: _listImages.length,
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
                  Navigator.pushNamed(context, ServiceDetailScreen.routeName);
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
                            image: AssetImage(
                              _listImages[index],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Person Name",
                              style: TextStyle(
                                fontSize: 14,
                                color: kTextColorSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "House Cleaning",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: kTextColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "RS:2500",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            RichText(
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
                                    text: "4.5",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: kTextColorSecondary,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " | ",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: kTextColorSecondary,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "40 Reviews",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: kTextColorSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _favourite
                              ? Icons.favorite_outline_rounded
                              : Icons.favorite,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _favourite = !_favourite;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
