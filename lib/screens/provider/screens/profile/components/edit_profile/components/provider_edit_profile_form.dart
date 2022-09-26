import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/provider_components/provider_default_button.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../../../helper/global_config.dart';
import '../../../../../../../helper/keyboard.dart';
import '../../../../../../../size_config.dart';
import '../../../../../provider_components/provider_config.dart';
import '../../../../../provider_constants.dart';

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
  String? mobile;
  String? about;
  String? gender;
  String imageUrl = 'Empty';
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? fileName;
  // The inital gender value
  Gender? _selectedGender;

  bool? error, sending, success;
  String? msg;
  String webUrl = providerbaseUrl + "update_provider.php";
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

  @override
  void initState() {
    super.initState();
    error = false;
    sending = false;
    success = false;

    msg = "";
    print(box!.get('gender'));
    if (box!.get('gender') != null) {
      if (box!.get('gender') == 'female') {
        _selectedGender = Gender.female;
        gender = _selectedGender!.name.toString();
      } else if (box!.get('gender') == 'male') {
        _selectedGender = Gender.male;
        gender = _selectedGender!.name.toString();
      }
    } else {
      _selectedGender = Gender.male;
    }
    profileImage = box!.get('profile_img');
  }

  TextEditingController emailctrl =
      TextEditingController(text: box!.get('email'));
  TextEditingController mobilectrl =
      TextEditingController(text: box!.get('mobile'));
  TextEditingController nameectrl =
      TextEditingController(text: box!.get('name'));
  String? profileImage;
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
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50.0,
                                backgroundColor: Colors.white,
                                child: imageUrl == 'Empty'
                                    ? CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 48.0,
                                        backgroundImage:
                                            NetworkImage(profileImage!),
                                      )
                                    : Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                      ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(7.5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
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
                        SizedBox(height: getProportionateScreenHeight(6)),
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
                                        "Name",
                                        style: secondaryTextStyle12,
                                      ),
                                    ),
                                    buildFirstNameFormField(),
                                  ],
                                ),
                              ),
                            ),
                            // Expanded(
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Text(
                            //             "Last Name",
                            //             style: secondaryTextStyle12,
                            //           ),
                            //         ),
                            //         buildLastNameFormField(),
                            //       ],
                            //     ),
                            //   ),
                            // ),
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
                        const Text(
                          "Gender",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
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
                                  "Mobile",
                                  style: secondaryTextStyle12,
                                ),
                              ),
                              buildUserMobileFormField(),
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
                      updateProfile();
                    },
                    text: sending! ? "Please wait..." : "Save",
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
      controller: nameectrl,
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
        hintText: box!.get('name'),
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

  TextFormField buildUserMobileFormField() {
    return TextFormField(
      controller: mobilectrl,
      enabled: widget.enable,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.datetime,
      onSaved: (newValue) => mobile = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter Mobile";
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
        hintText: box!.get('mobile'),
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
      controller: emailctrl,
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
        hintText: box!.get('email'),
        fillColor: kTextColorSecondary.withOpacity(0.2),
        filled: true,
      ),
    );
  }

//functions
  updateProfile() async {
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
      "id": box!.get("id"),
      "name": firstName,
      "email": email,
      "contact": mobile,
      "gender": gender,
      "profile_img": imageUrl == 'Empty' ? box!.get('profile_img') : imageUrl,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print('response:');
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["success"] == 0) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["msg"]; //error message from server
        });
      } else {
        //after write success, make fields empty

        setState(() {
          msg = "success sendign data.";
          print(msg);
          sending = false;
          success = true;
          print(data["msg"]);

          // add data to hive

          if (data["success"] == 1) {
            box!.put("name", nameectrl.text);
            box!.put("email", emailctrl.text);

            box!.put("mobile", mobilectrl.text);
            box!.put("gender", gender);
            box!.put("gender", gender);
            box!.put("profile_img",
                imageUrl == 'Empty' ? box!.get('profile_img') : imageUrl);
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
        // print('_id:');
        // print(box!.get("_id"));

        error = true;
        msg = "Error during sendign data.";
        print(msg);
        print(res.body);
        sending = false;
        //mark error and refresh UI with setState
      });
    }
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
}
