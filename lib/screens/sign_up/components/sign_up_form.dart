import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:handyman/helper/global_config.dart';
import 'package:handyman/helper/keyboard.dart';

import 'package:http/http.dart' as http;

import 'package:handyman/screens/sign_in/sign_in_screen.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

import 'package:image_picker/image_picker.dart';

import 'dart:async';
import 'dart:io';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

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

  TextEditingController emailctrl = TextEditingController();
  TextEditingController passwordctrl = TextEditingController();
  TextEditingController confirmPasswordctrl = TextEditingController();
  TextEditingController firstNamectrl = TextEditingController();
  TextEditingController lastNamectrl = TextEditingController();
  TextEditingController mobilectrl = TextEditingController();
  TextEditingController cnicctrl = TextEditingController();
  //text controller for TextField

  bool? error, sending, success;
  String? msg;
  // String webUrl = "https://cwp-handyman.herokuapp.com/users";
  String webUrl = baseUrl + "flutterfyp/Registeruser.php";

  // Initially password is obscure
  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool agree = false;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String imageUrl = 'Empty';

  String? fileName;

  static const snackBar = SnackBar(
    content: Text('Provide Required Informaition!'),
  );
  String? mtoken = " ";
  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
    getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
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
                //firstName form

                buildFirstNameFormField(),
                SizedBox(height: getProportionateScreenHeight(12)),
                //last Name Form
                // buildLastNameFormField(),
                // SizedBox(height: getProportionateScreenHeight(12)),
                //email form
                buildEmailFormField(),
                SizedBox(height: getProportionateScreenHeight(12)),
                //Postal Code form
                buildMobileFormField(),
                SizedBox(height: getProportionateScreenHeight(12)),
                //Postal CNIC form
                // buildCnicNameFormField(),
                // SizedBox(height: getProportionateScreenHeight(12)),
                //password form
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(12)),
                //Confirm password form
                buildConfirmPasswordFormField(),

                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
          DefaultButton(
            text: sending! ? "Please wait..." : "Sign Up",
            press: () {
              signUp();
            },
          ),
        ],
      ),
    );
  }

  Future<void> getDeviceToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print('Token:' + mtoken!);
      });
    });
  }

  signUp() async {
    if (imageUrl == 'Empty') {
      const snackBar = SnackBar(
        content: Text('Choose Profile Image'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (_formKey.currentState!.validate() &&
        passwordctrl.text == confirmPasswordctrl.text &&
        imageUrl != 'Empty') {
      _formKey.currentState!.save();
      setState(() {
        sending = true;
      });
      KeyboardUtil.hideKeyboard(context);

      sendData();
    }
  }

  Future<void> sendData() async {
    var request = http.MultipartRequest('POST', Uri.parse(webUrl));
    request.fields["name"] = firstNamectrl.text;
    request.fields["email"] = emailctrl.text;
    request.fields["password"] = passwordctrl.text;
    request.fields["contact"] = mobilectrl.text;
    request.fields["gender"] = 'gender';
    request.fields["adress"] = 'adress';
    request.fields["token"] = mtoken!;
    request.fields["uimage"] = imageUrl;
    request.fields["status"] = 'true';
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
        firstNamectrl.text = "";
        lastNamectrl.text = "";
        emailctrl.text = "";
        mobilectrl.text = "";
        // cnicctrl.text = "";
        passwordctrl.text = "";
        confirmPasswordctrl.text = "";
        //after write success, make fields empty

        setState(() {
          msg = data["msg"];
          print(msg);
          msg = "success sendign data...";
          print(msg);
          sending = false;
          success = true; //mark success and refresh UI with setState
          Navigator.pushNamed(context, SignInScreen.routeName);
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

  //Camera Method
  Future openCamera() async {
    Navigator.of(context).pop();
    var imageFrmCamera = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _selectedImage = File(imageFrmCamera!.path);
      fileName = _selectedImage!.path.split('/').last;
      print(fileName);
      uploadImageToFirebase(_selectedImage!, fileName!);
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

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: firstNamectrl,
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
        hintText: "Full Name",
        fillColor: kFormColor,
        filled: true,
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: lastNamectrl,
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
      controller: emailctrl,
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
      controller: mobilectrl,
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
      controller: passwordctrl,
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
      controller: confirmPasswordctrl,
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

  // TextFormField buildCnicNameFormField() {
  //   return TextFormField(
  //     controller: cnicctrl,
  //     cursorColor: kPrimaryColor,
  //     keyboardType: TextInputType.number,
  //     onSaved: (newValue) => cnic = newValue!,
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         return kConfirmCniC;
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12.0),
  //         borderSide: BorderSide.none,
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12.0),
  //         borderSide: const BorderSide(color: kPrimaryColor),
  //       ),
  //       labelStyle: const TextStyle(color: kPrimaryColor),
  //       focusColor: kPrimaryColor,
  //       hintText: "CNIC",
  //       fillColor: kFormColor,
  //       filled: true,
  //     ),
  //   );
  // }

}
