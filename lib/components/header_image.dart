import 'package:flutter/material.dart';

import '../constants.dart';

class ServiceImageHeader extends StatefulWidget {
  const ServiceImageHeader({Key? key}) : super(key: key);

  @override
  State<ServiceImageHeader> createState() => _ServiceImageHeaderState();
}

class _ServiceImageHeaderState extends State<ServiceImageHeader> {
  int currentPage = 0;
  final List<String> _listImages = [
    "assets/images/cleaner_2.png",
    "assets/images/wall_painting.jpg",
    "assets/images/repair_man.jpg",
    "assets/images/cleaner_2.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: PageView.builder(
              onPageChanged: (index) {
                currentPage = index;
                setState(() {});
              },
              scrollDirection: Axis.horizontal,
              itemCount: _listImages.length,
              itemBuilder: (context, index) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(_listImages[index]),
                          fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24))),
                );
              }),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _listImages.length,
              (index) => buildDot(index: index),
            ),
          ),
        )
      ],
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      //  width: 8,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
