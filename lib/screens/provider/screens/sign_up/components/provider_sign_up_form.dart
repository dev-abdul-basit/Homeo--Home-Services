import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/provider_components/provider_default_button.dart';
import 'package:handyman/screens/provider/screens/sign_up/choose_tracking_id/provider_choose_tracking_id_screen.dart';

import 'package:image_picker/image_picker.dart';

import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import '../../../../../helper/global_config.dart';
import '../../../../../helper/keyboard.dart';
import '../../../../../size_config.dart';
import '../../../provider_components/provider_config.dart';
import '../../../provider_constants.dart';

enum Gender { male, female }

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String webUrl = providerbaseUrl + "providerregister.php";
  bool? error, sending, success;
  String? msg;
  ////////////
  bool agree = false;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  String imageUrl = 'Empty';

  String? fileName;

  static const snackBar = SnackBar(
    content: Text('Provide Profile Image!'),
  );

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  //String? confirmPassword;
  String? firstName;
  //String? lastName;
  String? mobile;
  String? cnic;
  String? gender;
  // The inital gender value
  Gender _selectedGender = Gender.male;
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

  String? mtoken = " ";
  Future<void> getDeviceToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print('Token:' + mtoken!);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    gender = _selectedGender.name.toString();
    print(gender);
    error = false;
    sending = false;
    success = false;
    msg = "";
    getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 48.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(48.0),
                            child: imageUrl == 'Empty'
                                ? Image.asset(
                                    "assets/images/cleaner_2.png",
                                    fit: BoxFit.fill,
                                    width: 150,
                                    height: 150,
                                  )
                                : Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 150,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(7.5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(48.0),
                              color: kPrimaryColor),
                          child: InkWell(
                            onTap: () {
                              _optionsDialogBox();
                            },
                            child: const Icon(
                              Icons.linked_camera,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(12)),
                //firstName form..//last Name Form
                buildFirstNameFormField(),
                // SizedBox(height: getProportionateScreenHeight(12)),
                // buildLastNameFormField(),

                SizedBox(height: getProportionateScreenHeight(12)),
                buildEmailFormField(),

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
                                  gender = value.name.toString();
                                  print(gender);
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
                                  gender = value.name.toString();
                                  print(gender);
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
                SizedBox(height: getProportionateScreenHeight(12)),
                //Postal Mobile form
                buildMobileFormField(),
                SizedBox(height: getProportionateScreenHeight(12)),
                //Postal CNIC form
                buildCnicNameFormField(),
                SizedBox(height: getProportionateScreenHeight(12)),
                //password form
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(12)),
                //Confirm password form
                //  buildConfirmPasswordFormField(),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(48)),
          DefaultButton(
            text: sending! ? "Please wait..." : "Continue",
            press: () {
              signUp();
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
        hintText: "Name",
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

  //Camera Method
  Future openCamera() async {
    Navigator.of(context).pop();
    var imageFrmCamera = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _selectedImage = File(imageFrmCamera!.path);
    });
    //if (mounted) Navigator.of(context).pop();
  }

  //Gallery method
  Future openGallery() async {
    Navigator.of(context).pop();
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(pickedFile!.path);
      fileName = _selectedImage!.path.split('/').last;
      print(fileName);
      uploadImageToFirebase(_selectedImage!, fileName!);
    });
    // if (mounted) Navigator.of(context).pop();
  }

  final Reference _storageReference =
      FirebaseStorage.instance.ref().child("contact_images");

  void uploadImageToFirebase(File file, String fileName) async {
    // Create the file metadata
    //final metadata = SettableMetadata(contentType: "image/jpeg");

    file.absolute.existsSync();
    //upload
    _storageReference.child(fileName).putFile(file).then((firebaseFile) async {
      var downloadUrl = await firebaseFile.ref.getDownloadURL();

      setState(() {
        imageUrl = downloadUrl;
        print("downloadUrl");
        print(downloadUrl);
      });
    });
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Your Method'),
          backgroundColor: kFormColor,
          contentPadding: const EdgeInsets.all(20.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text("Take a Picture"),
                  onTap: openCamera,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                const Divider(
                  color: Colors.white70,
                  height: 1.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: const Text("Open Gallery"),
                  onTap: openGallery,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _sendToNextScreen(BuildContext context) {
    if (imageUrl == 'Empty') {
      const snackBar = SnackBar(
        content: Text('Choose Profile Image'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      // if all are valid then go to success screen
      KeyboardUtil.hideKeyboard(context);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChooseTrackingID(
              //first one will be available in next sceen
              //second one we have here in this screen
              name: firstName!,
              email: email!,
              gender: gender!,
              mobile: mobile!,
              cnic: cnic!,
              password: password!,
              profileImg: _selectedImage,
            ),
          ));
    }
  }

  signUp() async {
    if (_formKey.currentState!.validate() && _selectedImage != null) {
      _formKey.currentState!.save();
      setState(() {
        sending = true;
      });
      KeyboardUtil.hideKeyboard(context);

      sendData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> sendData() async {
    var request = http.MultipartRequest('POST', Uri.parse(webUrl));
    request.fields['name'] = firstName!;
    request.fields['email'] = email!;
    request.fields['password'] = password!;
    request.fields['contact'] = mobile!;
    request.fields['cnic'] = cnic!;
    request.fields['gender'] = gender!;
    request.fields['adress'] = 'adress';
    request.fields['status'] = 'pending';
    request.fields['image'] = 'late';
    request.fields['p_token'] = mtoken!;
    request.fields['profile_img'] = imageUrl;

    // var profilePic =
    //     await http.MultipartFile.fromPath("img", _selectedImage!.path);

    // request.files.add(profilePic);
    var response = await request.send();
    print(response.statusCode);
    var responsed = await http.Response.fromStream(response);
    print(request);

    if (response.statusCode == 200) {
      print('full response:');
      print(responsed.body); //print raw response on console
      var data = json.decode(responsed.body); //decoding json to array
      if (data["success"] == 0) {
        setState(() {
          //refresh the UI when error is recieved from server
          print('error is recieved from server');
          sending = false;
          error = true;
          msg = data["msg"];
          print(msg); //error message from server
        });
      } else {
        //after write success, make fields empty

        setState(() {
          msg = data["msg"];
          print(msg);
          msg = "success sendign data...";
          print(msg);
          sending = false;
          success = true; //mark success and refresh UI with setState
          _sendToNextScreen(context);
          box!.put("uid", data['id']);
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "Error during sendign data.";
        print(msg);
        print(responsed.body);
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }
}
