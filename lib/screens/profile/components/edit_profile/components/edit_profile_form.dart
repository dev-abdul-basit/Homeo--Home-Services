import 'package:flutter/material.dart';

import '../../../../../components/default_button.dart';
import '../../../../../constants.dart';
import '../../../../../helper/keyboard.dart';

enum Gender { male, female }

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({Key? key, required this.enable}) : super(key: key);
  final bool enable;

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? city;
  String? country;
  String? firstName;
  String? lastName;
  String? dateofbirth;
  String? about;

  // The inital gender value
  Gender _selectedGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "First Name",
                                        style: secondaryTextStyle12,
                                      ),
                                    ),
                                    buildFirstNameFormField(),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Last Name",
                                        style: secondaryTextStyle12,
                                      ),
                                    ),
                                    buildLastNameFormField(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Email",
                                  style: secondaryTextStyle12,
                                ),
                              ),
                              buildEmailFormField(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              const Expanded(
                                child: Text(
                                  "Gender",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      activeColor: kPrimaryColor,
                                      value: Gender.male,
                                      groupValue: _selectedGender,
                                      onChanged: (Gender? value) {
                                        setState(() {
                                          _selectedGender = value!;
                                        });
                                      },
                                    ),
                                    const Text("Male")
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio(
                                      activeColor: kPrimaryColor,
                                      value: Gender.female,
                                      groupValue: _selectedGender,
                                      onChanged: (Gender? value) {
                                        setState(() {
                                          _selectedGender = value!;
                                        });
                                      },
                                    ),
                                    const Text("Female")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Date of birth",
                                  style: secondaryTextStyle12,
                                ),
                              ),
                              buildDateOfBirthFormField(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "City",
                                          style: secondaryTextStyle12,
                                        ),
                                      ),
                                      buildCityNameFormField(),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Country",
                                          style: secondaryTextStyle12,
                                        ),
                                      ),
                                      buildCountryNameFormField(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "About",
                                  style: secondaryTextStyle12,
                                ),
                              ),
                              buildAboutFormField(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(48.0, 24, 48, 24),
                  child: DefaultButton(
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // if all are valid then go to success screen
                        KeyboardUtil.hideKeyboard(context);
                        debugPrint("Saved");
                      }
                    },
                    text: "Save",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      enabled: widget.enable,
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
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
        focusColor: kPrimaryColor,
        hintText: "First Name",
        fillColor: kTextColorSecondary.withOpacity(0.2),
        filled: true,
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      enabled: widget.enable,
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
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
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
        fillColor: kTextColorSecondary.withOpacity(0.2),
        filled: true,
      ),
    );
  }

  TextFormField buildDateOfBirthFormField() {
    return TextFormField(
      enabled: widget.enable,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.datetime,
      onSaved: (newValue) => dateofbirth = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter Date of Birth";
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
        focusColor: kPrimaryColor,
        hintText: "Date of Birth",
        fillColor: kTextColorSecondary.withOpacity(0.2),
        filled: true,
      ),
    );
  }

  TextFormField buildCityNameFormField() {
    return TextFormField(
      enabled: widget.enable,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => city = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter City";
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
        focusColor: kPrimaryColor,
        hintText: "City",
        fillColor: kTextColorSecondary.withOpacity(0.2),
        filled: true,
      ),
    );
  }

  TextFormField buildCountryNameFormField() {
    return TextFormField(
      enabled: widget.enable,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => city = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter City";
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
        focusColor: kPrimaryColor,
        hintText: "Country",
        fillColor: kTextColorSecondary.withOpacity(0.2),
        filled: true,
      ),
    );
  }

  TextFormField buildAboutFormField() {
    return TextFormField(
      enabled: widget.enable,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => about = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter About yourself";
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
        focusColor: kPrimaryColor,
        hintText: "About",
        fillColor: kTextColorSecondary.withOpacity(0.2),
        filled: true,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      enabled: widget.enable,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return kInvalidEmailError;
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
        focusColor: kPrimaryColor,
        hintText: "email@gmail.com",
        fillColor: kTextColorSecondary.withOpacity(0.2),
        filled: true,
      ),
    );
  }
}
