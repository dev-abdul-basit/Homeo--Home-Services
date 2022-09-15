import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/provider_components/provider_no_account_txt.dart';
import 'package:handyman/screens/provider/screens/sign_up/components/provider_sign_up_form.dart';
import '../../../../../helper/global_config.dart';
import '../../../../../size_config.dart';
import '../../../../sign_in/sign_in_screen.dart';
import '../../../provider_components/provider_config.dart';
import '../../../provider_constants.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 36, 8, 8),
                      child: Image.asset(
                        "assets/images/review.png",
                        width: 96,
                        height: 96,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: SizeConfig.screenHeight * 0.75,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                "Create a New Account",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: getProportionateScreenHeight(8)),
                              const SignUpForm(),
                            ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(24)),
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
