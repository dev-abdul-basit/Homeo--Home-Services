import 'package:flutter/material.dart';

import '../../../constants.dart';

class ReviewsContainer extends StatefulWidget {
  const ReviewsContainer({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
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
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.amber,
                      ),
                    ),
                    TextSpan(
                      text: " 4.5",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: kTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: " | ",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "40 Reviews",
                      style: TextStyle(
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
            itemCount: _listImages.length,
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
                          backgroundImage: AssetImage(_listImages[index]),
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        const Expanded(
                            child: Text(
                          "Circular Byte",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )),
                        RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                              ),
                              TextSpan(
                                text: " 4.5",
                                style: TextStyle(
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
                        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available",
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
}
