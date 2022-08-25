import 'package:flutter/widgets.dart';
import 'package:handyman/screens/all_services_list_screen/all_services_list_screen.dart';
import 'package:handyman/screens/book_a_service_screen/booking_service_screen.dart';
import 'package:handyman/screens/booking_summary/booking_summary.dart';
import 'package:handyman/screens/favourite_services/favourite_screen.dart';

import 'package:handyman/screens/offers_detail/offers_detail_screen.dart';
import 'package:handyman/screens/rate_service_screen/rate_service_screen.dart';
import 'package:handyman/screens/services_sub_categories/services_sub_categories.dart';
import 'package:handyman/screens/view_bookings/view_bookings_screen.dart';
import 'package:handyman/screens/all_services_screen/all_services_screen.dart';

import 'package:handyman/screens/home_screen/homescreen.dart';

import 'package:handyman/screens/map_location/map_location_screen.dart';

import 'package:handyman/screens/profile/components/edit_profile/edit_profile_screen.dart';
import 'package:handyman/screens/profile/profile_screen.dart';
import 'package:handyman/screens/search_screen/search_screen.dart';
import 'package:handyman/screens/service_detail_screen/service_detail_screen.dart';

import 'package:handyman/screens/splash/splash_screen.dart';
import 'package:handyman/screens/sign_in/sign_in_screen.dart';

import 'package:handyman/screens/forgot_password/forgot_password_screen.dart';
import 'package:handyman/screens/location_permission/location_permission_screen.dart';
import 'package:handyman/screens/otp/otp_screen.dart';
import 'package:handyman/screens/sign_up/sign_up_screen.dart';
import 'package:handyman/screens/view_providers_map/view_providers_map.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LocationPermissionScreen.routeName: (context) =>
      const LocationPermissionScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  MapScreen.routeName: (context) => const MapScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  EditProfileScreen.routeName: (context) => const EditProfileScreen(),
  SearchScreen.routeName: (context) => const SearchScreen(),
  AllServicesScreen.routeName: (context) => const AllServicesScreen(),
  ViewAllBookingsScreen.routeName: (context) => const ViewAllBookingsScreen(),
  ServicesListScreen.routeName: (context) => const ServicesSubCategories(
        serviceName: '',
        sub1: '',
        sub2: '',
        sub3: '',
        sub4: '',
        sub5: '',
      ),
  ServicesSubCategories.routeName: (context) => const ServicesListScreen(
        serviceName: '',
        sub_cat: '',
        service_title: '',
        id: '',
      ),
  ServiceDetailScreen.routeName: (context) => const ServiceDetailScreen(
        id: '',
        title: '',
        speciality: '',
        description: '',
        note: '',
        adress: '',
        rate: '',
        status: '',
        spName: '',
        spId: '',
        serviceImages: '',
        serviceImages1: '',
        serviceImages2: '',
        fav: '',
      ),
  BookingService.routeName: (context) => const BookingService(
        id: '',
        title: '',
        speciality: '',
        description: '',
        note: '',
        adress: '',
        rate: '',
        status: '',
        spName: '',
        spId: '',
        serviceImages: '',
        serviceImages1: '',
        serviceImages2: '',
        fav: '',
      ),
  BookingSummary.routeName: (context) => const BookingSummary(
        id: '',
        title: '',
        speciality: '',
        description: '',
        note: '',
        adress: '',
        rate: '',
        status: '',
        spName: '',
        spId: '',
        serviceImages: '',
        serviceImages1: '',
        serviceImages2: '',
      ),
  RateServiceScreen.routeName: (context) => const RateServiceScreen(
        id: '',
        uid: '',
        serviceName: '',
        b_date: '',
        b_time: '',
        b_hours: '',
        b_price: '',
        booking_status: '',
        user_booking_status: '',
        service_id: '',
        sp_name: '',
        sp_id: '',
      ),
  FavouriteServices.routeName: (context) => const FavouriteServices(),
  ViewProviderMapScreen.routeName: (context) => const ViewProviderMapScreen(),
  OffersDetails.routeName: (context) => const OffersDetails(
        id: '',
        uid: '',
        serviceName: '',
        b_date: '',
        b_time: '',
        b_hours: '',
        b_price: '',
        booking_status: '',
        user_booking_status: '',
      ),
};
