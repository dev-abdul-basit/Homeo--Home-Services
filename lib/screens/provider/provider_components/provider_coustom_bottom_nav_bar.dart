import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/screens/home_screen/provider_homescreen.dart';
import 'package:handyman/screens/provider/screens/profile/provider_profile_screen.dart';
import 'package:handyman/screens/provider/screens/view_offers/provider_view_offers_screen.dart';
import 'package:handyman/screens/provider/screens/view_services/provider_view_booking_screen.dart';

import '../../../size_config.dart';
import '../provider_constants.dart';
import '../provider_enum.dart';

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
                            ProviderHomeScreen.routeName, (route) => false);
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
                      Icons.notifications_active_outlined,
                      color: MenuState.offers == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ProviderViewOffersScreen.routeName);
                    },
                  ),
                  Container(
                    child: MenuState.offers == selectedMenu
                        ? const Visibility(
                            child: Text(
                              "Offers",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            visible: true,
                          )
                        : const Visibility(
                            child: Text("Offers"),
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
                      Icons.bookmark_added_rounded,
                      color: MenuState.services == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ProviderViewServicesScreen.routeName);
                    },
                  ),
                  Container(
                    child: MenuState.services == selectedMenu
                        ? const Visibility(
                            child: Text(
                              "Services",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            visible: true,
                          )
                        : const Visibility(
                            child: Text("Services"),
                            visible: false,
                          ),
                  ),
                ],
              ),
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     IconButton(
              //       icon: Icon(
              //         Icons.store_mall_directory,
              //         color: MenuState.cart == selectedMenu
              //             ? kPrimaryColor
              //             : inActiveIconColor,
              //       ),
              //       onPressed: () {},
              //     ),
              //     Container(
              //       child: MenuState.cart == selectedMenu
              //           ? const Visibility(
              //               child: Text(
              //                 "Cart",
              //                 style: TextStyle(color: kPrimaryColor),
              //               ),
              //               visible: true,
              //             )
              //           : const Visibility(
              //               child: Text("Cart"),
              //               visible: false,
              //             ),
              //     ),
              //   ],
              // ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.person_outline_rounded,
                        color: MenuState.profile == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ProviderProfileScreen.routeName);
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
