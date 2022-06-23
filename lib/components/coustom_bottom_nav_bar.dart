import 'package:flutter/material.dart';

import 'package:handyman/screens/home_screen/homescreen.dart';
import 'package:handyman/screens/profile/profile_screen.dart';

import '../constants.dart';
import '../enum.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.home_outlined,
                        color: MenuState.home == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            HomeScreen.routeName, (route) => false);
                        // Navigator.pushNamed(context, HomeScreen.routeName);
                      }),
                  Container(
                    child: MenuState.home == selectedMenu
                        ? const Visibility(
                            child: Text(
                              "Home",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            visible: true,
                          )
                        : const Visibility(
                            child: Text("Home"),
                            visible: false,
                          ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.list_alt_outlined,
                      color: MenuState.orders == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    child: MenuState.orders == selectedMenu
                        ? const Visibility(
                            child: Text(
                              "Orders",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            visible: true,
                          )
                        : const Visibility(
                            child: Text("Orders"),
                            visible: false,
                          ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.message_outlined,
                      color: MenuState.chat == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    child: MenuState.chat == selectedMenu
                        ? const Visibility(
                            child: Text(
                              "Chat",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            visible: true,
                          )
                        : const Visibility(
                            child: Text("Chat"),
                            visible: false,
                          ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.store_mall_directory,
                      color: MenuState.cart == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    child: MenuState.cart == selectedMenu
                        ? const Visibility(
                            child: Text(
                              "Cart",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            visible: true,
                          )
                        : const Visibility(
                            child: Text("Cart"),
                            visible: false,
                          ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.person_add_alt_outlined,
                        color: MenuState.profile == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            ProfileScreen.routeName, (route) => false);
                        // Navigator.pushNamed(context, ProfileScreen.routeName),
                      }),
                  Container(
                    child: MenuState.profile == selectedMenu
                        ? const Visibility(
                            child: Text(
                              "Profile",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            visible: true,
                          )
                        : const Visibility(
                            child: Text("Profile"),
                            visible: false,
                          ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
