import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:handyman/screens/provider/provider_components/provider_default_button.dart';
import 'package:handyman/screens/provider/screens/home_screen/provider_homescreen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'dart:async';

import 'package:http/http.dart' as http;

import '../../../../../../../helper/global_config.dart';
import '../../../../../../../helper/keyboard.dart';
import '../../../../../../../size_config.dart';
import '../../../../../provider_components/provider_config.dart';
import '../../../../../provider_constants.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.title,
    required this.speciality,
    required this.description,
    required this.note,
    required this.adress,
    required this.rate,
    required this.sub_cat,
  }) : super(key: key);
  final String title, speciality, description, note, adress, rate, sub_cat;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String webUrl = providerbaseUrl + "providerAddService.php";
  bool? error, sending, success;
  String? msg;
  ////////////

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  String? fileName;

  String imageUrl = 'Empty';

  static const snackBar = SnackBar(
    content: Text('Provide Required Informaition!'),
  );
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
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: getProportionateScreenHeight(16)),
          const Text(
            "Choose Service images",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(4)),
          const Text(
            "",
            style: TextStyle(
              color: kTextColorSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(24)),
          ElevatedButton.icon(
            label: const Text(
              "Choose Images",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            icon: const Icon(Icons.add_photo_alternate_outlined),
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColor.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.fromLTRB(8, 24, 8, 24)),
            onPressed: () {
              _optionsDialogBox();
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
            ),
          ),
          DefaultButton(
            press: () {
              //  Navigator.pushNamed(context, AddServiceImages.routeName);
              // showConfirmationScreen(context);
              submitService();
            },
            text: sending! ? "Please wait..." : "Submit",
          ),
          SizedBox(height: getProportionateScreenHeight(48)),
        ],
      ),
    );
  }

  submitService() async {
    if (imageUrl != 'Empty') {
      setState(() {
        sending = true;
      });
      KeyboardUtil.hideKeyboard(context);

      sendData();
    } else {
      print("Eror");
      const snackBar = SnackBar(
        content: Text('Provide Required Informaition!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> sendData() async {
    if (imageUrl == 'Empty') {
      const snackBar = SnackBar(
        content: Text('Provide Required Informaition!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      sending = false;
      error = true;
    } else if (imageUrl != 'Empty') {
      var res = await http.post(Uri.parse(webUrl), body: {
        "service_title": widget.title,
        "service_speciality": widget.speciality,
        "sub_cat": widget.sub_cat,
        "service_description": widget.description,
        "service_extra_note": widget.note,
        "adress": widget.adress,
        "service_status": box!.get('status'),
        "service_images": imageUrl,
        "service_provider_id": box!.get('id').toString(),
        "service_provider_name": box!.get('name'),
        "rate": widget.rate,
        "fav": '0',
        "image1": 'empty',
        "image2": 'empty',
      }); //sending post request with header data

      if (res.statusCode == 200) {
        print('full response:');
        print('sent image:');

        print(res.body); //print raw response on console
        var data = json.decode(res.body); //decoding json to array
        if (data["success"] == 0) {
          setState(() {
            //refresh the UI when error is recieved from server
            print('error is recieved from server');
            sending = false;
            error = true;
            msg = data["msg"];
            print(msg); //error message from server
            const snackBar = SnackBar(
              content: Text('Provide Required Informaition!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            showConfirmationScreen(context);
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
          const snackBar = SnackBar(
            content: Text('Provide Required Informaition!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    } else {
      sending = false;
      error = true;

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  void showConfirmationScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      builder: ((context) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 24),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Image.asset(
                  "assets/images/paymentsuccess.png",
                  width: 200,
                  height: 200,
                ),
              ),
              const Expanded(
                child: Text(
                  "Congratulations",
                  style: TextStyle(
                      color: kPrimaryLightColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  "Your Service Has been created",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil((context),
                          ProviderHomeScreen.routeName, (route) => false);
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.5 / 2),
                      decoration: BoxDecoration(
                          gradient: kPrimaryGradientColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          Text(
                            "Back to home",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
