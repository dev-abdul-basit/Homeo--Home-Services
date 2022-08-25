import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';

import '../../../components/no_account_txt.dart';
import '../../../size_config.dart';
import '../../sign_in/sign_in_screen.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(0)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: SizeConfig.screenHeight * 0.4,
                      decoration: const BoxDecoration(
                        gradient: kPrimaryGradientColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 48, 8, 8),
                        child: Text(
                          "LOGO",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 48),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(36.0, 120.0, 36.0, 36.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: SizeConfig.screenHeight * 0.7,
                        child: Card(
                          color: kSecondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListView(shrinkWrap: true,
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Create a New Account",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kTextColor,
                                      fontSize: getProportionateScreenWidth(20),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Sign Up to create a new account.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: kTextColorSecondary,
                                      fontSize: getProportionateScreenWidth(14),
                                    ),
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(4)),
                                  const SignUpForm(),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(2)),
                NoAccountText(
                    a: "Already have an account?",
                    b: " Sign In",
                    press: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          SignInScreen.routeName, (route) => false);
                    }),
                SizedBox(height: getProportionateScreenHeight(4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
