import 'package:flutter/material.dart';
import 'package:handyman/helper/keyboard.dart';

import 'package:handyman/screens/location_permission/location_permission_screen.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;
  String? firstName;
  String? lastName;
  String? mobile;
  String? cnic;

  bool remember = false;
  final List<String> errors = [];

  // Initially password is obscure
  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //firstName form

          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(12)),
          //last Name Form
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(12)),
          //email form
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(12)),
          //Postal Code form
          buildMobileFormField(),
          SizedBox(height: getProportionateScreenHeight(12)),
          //Postal CNIC form
          buildCnicNameFormField(),
          SizedBox(height: getProportionateScreenHeight(12)),
          //password form
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(12)),
          //Confirm password form
          buildConfirmPasswordFormField(),

          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Sign Up",
            press: () {
              if (_formKey.currentState!.validate() &&
                  password == confirmPassword) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                Navigator.pushNamed(
                    context, LocationPermissionScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => firstName = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kNamelNullError;
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
        hintText: "First Name",
        fillColor: kFormColor,
        filled: true,
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => lastName = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kNamelNullError;
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
        hintText: "Last Name",
        fillColor: kFormColor,
        filled: true,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
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
        hintText: "Enter email",
        fillColor: kFormColor,
        filled: true,
      ),
    );
  }

  TextFormField buildMobileFormField() {
    return TextFormField(
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => mobile = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kCodeNullError;
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
        hintText: "Mobile",
        fillColor: kFormColor,
        filled: true,
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      autocorrect: false,
      obscureText: _obscureText,
      enableSuggestions: false,
      cursorColor: kPrimaryColor,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          // removeError(error: kPassNullError);
          setState(() {
            // _formKey.currentState!.validate();
          });
        } else if (value.length >= 8) {
          // removeError(error: kShortPassError);
          setState(() {
            //  _formKey.currentState!.validate();
          });
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          //addError(error: kPassNullError);

          return kPassNullError;
        } else if (value.length < 8) {
          //addError(error: kShortPassError);
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

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      autocorrect: false,
      obscureText: _obscureText,
      enableSuggestions: false,
      cursorColor: kPrimaryColor,
      onSaved: (newValue) => confirmPassword = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kPassNullError;
        } else if (value.length < 8) {
          return kShortPassError;
        } else if (password != confirmPassword) {
          return kConfirmPasswordError;
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
        hintText: "Confirm password",
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

  TextFormField buildCnicNameFormField() {
    return TextFormField(
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => cnic = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kConfirmCniC;
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
        hintText: "CNIC",
        fillColor: kFormColor,
        filled: true,
      ),
    );
  }
}
