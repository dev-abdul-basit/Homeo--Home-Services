import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/provider_components/provider_default_button.dart';
import 'package:handyman/screens/provider/screens/sign_in/provider_sign_in_screen.dart';

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

import '../../../../../../helper/global_config.dart';
import '../../../../../../helper/keyboard.dart';
import '../../../../../../size_config.dart';
import '../../../../../sign_in/sign_in_screen.dart';
import '../../../../provider_components/provider_config.dart';
import '../../../../provider_constants.dart';

class TrackingForm extends StatefulWidget {
  const TrackingForm({
    Key? key,
    required this.name,
    required this.email,
    required this.gender,
    required this.mobile,
    required this.cnic,
    required this.password,
    required this.profileImg,
  }) : super(key: key);
  final String name, email, password, cnic, mobile, gender;
  final File? profileImg;
  @override
  State<TrackingForm> createState() => _TrackingFormState();
}

class _TrackingFormState extends State<TrackingForm> {
  String webUrl = providerbaseUrl + "provider_add_license_img.php";
  bool? error, sending, success;
  String? msg;
  ////////////
  bool agree = false;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  String? fileName;

  String imageUrl = 'Empty';

  static const snackBar = SnackBar(
    content: Text('Provide Required Informaition!'),
  );
  //Camera Method
  Future openCamera() async {
    var imageFrmCamera = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _selectedImage = File(imageFrmCamera!.path);
    });
    //if (mounted) Navigator.of(context).pop();
  }

  //Gallery method
  Future openGallery() async {
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
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();

    print("uid");
    print(box!.get('uid'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: getProportionateScreenHeight(24)),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Tracking ID",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: kTextColor, fontSize: 18),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(12)),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Please choose a tracking id issued by NADRA, or any other document that validates you.",
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: TextStyle(color: kTextColorSecondary, fontSize: 14),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(24)),
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
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
                SizedBox(height: getProportionateScreenHeight(20)),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        label: const Text("Gallery"),
                        onPressed: () {
                          openGallery();
                        },
                        icon: const Icon(
                          Icons.image_outlined,
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: kPrimaryLightColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                    ),
                    SizedBox(width: getProportionateScreenHeight(20)),
                    Expanded(
                      child: ElevatedButton.icon(
                        label: const Text("Camera"),
                        onPressed: () {
                          openCamera();
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: kPrimaryLightColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: agree,
                      activeColor: kPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          agree = value!;
                        });
                      },
                    ),
                    const Text(
                      "I agree to Terms & Conditions",
                      style:
                          TextStyle(fontSize: 12, color: kTextColorSecondary),
                    ),
                  ],
                ),
              ],
            ),
            DefaultButton(
              text: sending! ? "Please wait..." : "Sign Up",
              press: () {
                signUp();
              },
            ),
          ]),
    );
  }

//Notification to Admin
  void sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAK_aG2S4:APA91bEdT80xbI915lAdt7rMycCZW3ayWnnwDByQ25jp1Xiy-SLaq4pLm4RCy8qTl91ba6QFvQ6G5n8F4VdVys-TD2cljZoObB4pWTZieR4OafWcvmBd28c2FU7oLWAOnaliPUhieuP9',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

  ///end
  signUp() async {
    if (imageUrl == 'Empty') {
      const snackBar = SnackBar(
        content: Text('Choose License Image'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (agree == true && _selectedImage != null && imageUrl != 'Empty') {
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
    request.fields['id'] = box!.get('uid');
    request.fields['image'] = imageUrl;
    // var pic = await http.MultipartFile.fromPath("image", _selectedImage!.path);

    // request.files.add(pic);

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
          print('Sending Notification');
          sendPushMessage(
              "New Provider Register", "Click to See Details", adminToken);
          msg = data["msg"];
          print(msg);
          msg = "success sendign data...";
          print(msg);
          sending = false;
          success = true; //mark success and refresh UI with setState
          Navigator.pushNamed(context, ProviderSignInScreen.routeName);
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
