// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:handyman/screens/location_permission/location_permission_screen.dart';
import 'package:handyman/screens/provider/provider_components/provider_default_button.dart';
import 'package:handyman/screens/provider/screens/home_screen/provider_homescreen.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../helper/global_config.dart';
import '../../../../../helper/keyboard.dart';
import '../../../../../size_config.dart';
import '../../../provider_components/provider_config.dart';
import '../../../provider_constants.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool remember = false;
  final List<String> errors = [];
  bool isLogin = false;

  // Initially password is obscure
  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool? error, sending, success;
  String? msg;

  String webUrl = providerbaseUrl + "/providerlogin.php";

  @override
  void initState() {
    super.initState();
    error = false;
    sending = false;
    success = false;
    msg = "";
    if (box!.containsKey("provider_login")) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            ProviderHomeScreen.routeName, (route) => false);
      });

      isLogin = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(12)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(0)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },
              ),
              const Text(
                "Remember me",
                style: TextStyle(fontSize: 12, color: kTextColorSecondary),
              ),
              Spacer(),
              // GestureDetector(

              //   onTap: () => Navigator.pushNamed(
              //       context, ForgotPasswordScreen.routeName),
              //   child: const Text(
              //     "Forgot Password",
              //     style: TextStyle(
              //         decoration: TextDecoration.none,
              //         fontSize: 12,
              //         color: kPrimaryColor),
              //   ),
              // )
            ],
          ),
          //FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 12),
            child: DefaultButton(
              text: sending! ? "Please wait..." : "Sign In",
              press: () {
                signIn();
              },
            ),
          ),
        ],
      ),
    );
  }

//Functions

  signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        sending = true;
      });
      KeyboardUtil.hideKeyboard(context);

      sendData();
    }
  }

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(webUrl), body: {
      "email": emailController.text,
      "password": passwordController.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print('response:');
      print(res.body); //print raw response on console

      var data = json.decode(res.body);
      print('data:');
      print(data); //decoding json to array
      if (data["success"] == 0) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["msg"]; //error message from server
          final snackBar = SnackBar(
            content: Text(data["msg"]),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      } else {
        emailController.text = "";
        passwordController.text = "";
        //after write success, make fields empty

        setState(() {
          msg = "success sendign data.";
          print(msg);

          sending = false;
          success = true;
          print(data["success"]);

          // add data to hive

          if (data["success"] == 1) {
            print("All done");
            print(data["id"]);
            print(data["p_token"]);
            box!.put("provider_login", true);
            box!.put("id", data["id"]);
            box!.put("name", data["name"]);
            box!.put("email", data["email"]);
            box!.put("password", data["password"]);
            box!.put("mobile", data["contact"]);
            // box!.put("adress", data["adress"]);
            box!.put("cnic", data["cnic"]);
            box!.put("gender", data["gender"]);
            box!.put("status", data["status"]);
            box!.put("p_token", data["p_token"]);
            box!.put("image", data["image"]);
            box!.put("profile_img", data["profile_img"]);
            //mark success and refresh UI with setState
            if (box!.containsKey("permissions")) {
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    ProviderHomeScreen.routeName, (route) => false);
              });

              isLogin = true;
            } else {
              Navigator.pushNamed(context, LocationPermissionScreen.routeName);
            }
          } else {
            final snackBar = SnackBar(
              content: Text(data["success"] == 0 ? data["msg"] : data["msg"]),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            print(data["msg"]);
          }
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "Error during sendign data.";
        print(msg);
        print(res.body);
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      autocorrect: false,
      obscureText: _obscureText,
      enableSuggestions: false,
      cursorColor: kPrimaryColor,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            // _formKey.currentState!.validate();
          });
        } else if (value.length >= 8) {
          setState(() {});
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (value.length < 3) {
          return kShortPassError;
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
        hintText: "Enter your password",
        fillColor: kFormColor,
        filled: true,
        labelStyle: const TextStyle(color: kPrimaryColor),
        suffixIcon: GestureDetector(
          onTap: _toggle,
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: kTextColorSecondary,
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailController,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          //removeError(error: kEmailNullError);
          setState(() {
            //  _formKey.currentState!.validate();
          });
        } else if (emailValidatorRegExp.hasMatch(value)) {
          // removeError(error: kInvalidEmailError);
          // _formKey.currentState!.validate();
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          //addError(error: kEmailNullError);
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          // addError(error: kInvalidEmailError);
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
        hintText: "Enter your email",
        fillColor: kFormColor,
        filled: true,
      ),
    );
  }
}
