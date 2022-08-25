import 'package:flutter/material.dart';
import 'size_config.dart';

//const kPrimaryBGColor = Color(0xFFF5F5F5);
const kPrimaryBGColor = Color(0xFFFFFCFC);
const kPrimaryColor = Color.fromARGB(255, 118, 32, 238);
const kPrimaryLightColor = Color.fromARGB(255, 170, 113, 250);
const kFormColor = Color(0xFFF6F6F6);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color.fromARGB(255, 118, 32, 238),
    Color.fromARGB(255, 170, 113, 250)
  ],
);
const kSecondaryColor = Color(0xFFFFFFFF);
const kTextColor = Color(0xFF000000);
const kTextColorSecondary = Color(0xFF949494);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(20),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
final headingStyleWhite = TextStyle(
  fontSize: getProportionateScreenWidth(20),
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
final secondaryTextStyle12 = TextStyle(
  fontSize: getProportionateScreenWidth(12),
  color: kTextColorSecondary,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kCodeNullError = "Please Enter Postal Code";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kConfirmPasswordError = "Please Enter your address";
const String kConfirmCniC = "Please Enter your CNIC";

final otpInputDecoration = InputDecoration(
  filled: true,
  fillColor: kFormColor,
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide.none,
  );
}
