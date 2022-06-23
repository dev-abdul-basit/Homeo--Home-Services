import 'package:flutter/widgets.dart';

import 'package:handyman/screens/home_screen/homescreen.dart';

import 'package:handyman/screens/map_location/map_location_screen.dart';

import 'package:handyman/screens/profile/components/edit_profile/edit_profile_screen.dart';
import 'package:handyman/screens/profile/profile_screen.dart';

import 'package:handyman/screens/splash/splash_screen.dart';
import 'package:handyman/screens/sign_in/sign_in_screen.dart';

import 'package:handyman/screens/forgot_password/forgot_password_screen.dart';
import 'package:handyman/screens/location_permission/location_permission_screen.dart';
import 'package:handyman/screens/otp/otp_screen.dart';
import 'package:handyman/screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LocationPermissionScreen.routeName: (context) =>
      const LocationPermissionScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  // CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  MapScreen.routeName: (context) => const MapScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),

  // CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  EditProfileScreen.routeName: (context) => const EditProfileScreen(),
};
