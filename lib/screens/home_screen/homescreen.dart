import 'package:flutter/material.dart';
import 'package:handyman/components/coustom_bottom_nav_bar.dart';
import 'package:handyman/constants.dart';
import 'package:handyman/enum.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72.0),
        child: AppBar(
          backgroundColor: kPrimaryColor,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(0.0, 16, 0, 0),
                child: Text(
                  "Your address",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 4, 0, 8),
                child: Text(
                  "Albertstrabe 29,0....",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: headingStyleWhite,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 16, 0, 0),
              child: IconButton(
                visualDensity:
                    const VisualDensity(horizontal: -4.0, vertical: -4.0),
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 16, 0, 0),
              child: IconButton(
                visualDensity:
                    const VisualDensity(horizontal: -4.0, vertical: -4.0),
                icon: const Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 20, 0),
              child: GestureDetector(
                onTap: () {},
                child: const CircleAvatar(
                  radius: 18.0,
                  backgroundImage: AssetImage("assets/images/user.png"),
                  backgroundColor: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
      body: const Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
