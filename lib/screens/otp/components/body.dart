import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';
import 'package:handyman/size_config.dart';

import '../../../components/default_button.dart';
import 'otp_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(24)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: SizeConfig.screenHeight * 0.02),
              const Center(
                child: Image(
                  image: AssetImage("assets/images/otp_verify.png"),
                  width: 250,
                  height: 250,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  "Verification",
                  textAlign: TextAlign.start,
                  style: headingStyle,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  "Enter the OTP code sent to your email",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              //buildTimer(),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: OtpForm(),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              const Center(
                child: Text(
                  "Did not receive a code?",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 18,
                      color: kTextColorSecondary),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // OTP code resend
                  },
                  child: const Text(
                    "RESEND",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultButton(
                  text: "Done",
                  press: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 00.0),
          duration: const Duration(seconds: 30),
          builder: (_, value, child) => const Text(
            "00:00",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
