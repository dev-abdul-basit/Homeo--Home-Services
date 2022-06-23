import 'package:flutter/material.dart';
import 'package:handyman/components/default_button.dart';
import 'package:handyman/screens/otp/otp_screen.dart';
import 'package:handyman/size_config.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(25),
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              const Text(
                "Enter your email to recover your password ",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: kTextColorSecondary,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              const Padding(
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                child: ForgotPassForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key? key}) : super(key: key);

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
                return kEmailNullError;
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
                return kInvalidEmailError;
              }
              return null;
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: kPrimaryColor),
              ),
              labelStyle: const TextStyle(color: kPrimaryColor),
              focusColor: kPrimaryColor,
              fillColor: kFormColor,
              filled: true,
              hintText: "Enter email",
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                // Sending to OTP Screen
                Navigator.of(context).pushNamedAndRemoveUntil(
                    OtpScreen.routeName, (route) => false);
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
        ],
      ),
    );
  }
}
