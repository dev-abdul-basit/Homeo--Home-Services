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
  var snackBar = const SnackBar(
    content: Text('Yay! A SnackBar!'),
  );

  // File? _selectedImage;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  String? fileName;
  Uint8List? imagebytes1;
  String? base64string1;
  List<String>? base64stringList = [];

  List<Uint8List>? bytesList = [];
  Uint8List? bytes1;
  Uint8List? bytes2;
  List<int>? imageBytes;
  var imagePath;
  void selectImages() async {
    List<XFile>? selectedImages = await imagePicker.pickMultiImage(
      imageQuality: 40,
    );

    if (selectedImages!.isNotEmpty) {
      for (int i = 0; i < selectedImages.length; i++) {
        imageBytes = await selectedImages[i].readAsBytes(); //convert to bytes
        base64string1 = base64.encode(imageBytes!);

        //Decode
        bytes1 = const Base64Codec().decode(base64string1!);
        //bytes2 = const Base64Codec().decode(base64string2!);
        bytesList!.add(bytes1!);
        // base64stringList!.add(base64string1!);
        print('list');
        print(base64stringList);
      }
    }

    setState(() {
      if (selectedImages.isNotEmpty) {
        imageFileList!.addAll(selectedImages);
      }
    });
    for (int i = 0; i < selectedImages.length; i++) {
      imagePath = File(selectedImages[i].path);
      fileName = selectedImages[i].path.split('/').last;
      //print(path.toString());
      print(fileName);
      uploadImageToFirebase(imagePath, fileName!);
    }
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
        base64stringList!.add(downloadUrl);
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
            "You can add upto 3",
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
              selectImages();
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  itemCount: base64stringList!.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 1.0),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: kFormColor,
                      child: base64stringList != null
                          ? Image.network(base64stringList![index])
                          // : Image.file(
                          //     File(imageFileList![index].path),
                          //     fit: BoxFit.cover,
                          //     width: 150,
                          //     height: 150,
                          //   ),
                          // : Image.memory(bytesList![index]),
                          : const CircularProgressIndicator(),
                    );
                  }),
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
    if (base64stringList != null) {
      setState(() {
        sending = true;
      });
      KeyboardUtil.hideKeyboard(context);

      sendData();
    } else {
      print("Eror");
      snackBar = const SnackBar(
        content: Text('OOps!!.Eror'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> sendData() async {
    if (base64stringList!.length <= 2) {
      snackBar = const SnackBar(
        content: Text('Must Choose 3 images'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      sending = false;
      error = true;
    } else if (base64stringList!.length <= 3) {
      var res = await http.post(Uri.parse(webUrl), body: {
        "service_title": widget.title,
        "service_speciality": widget.speciality,
        "sub_cat": widget.sub_cat,
        "service_description": widget.description,
        "service_extra_note": widget.note,
        "adress": widget.adress,
        "service_status": box!.get('status'),
        "service_images": base64stringList![0].toString(),
        "service_provider_id": box!.get('id').toString(),
        "service_provider_name": box!.get('name'),
        "rate": widget.rate,
        "fav": '0',
        "image1": base64stringList![1].toString(),
        "image2": base64stringList![2].toString(),
      }); //sending post request with header data

      if (res.statusCode == 200) {
        print('full response:');
        print('sent image:');
        print(base64string1);
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
            snackBar = SnackBar(
              content: Text(data["msg"]),
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
          snackBar = const SnackBar(
            content: Text('OOps!!.Eror'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    } else {
      sending = false;
      error = true;
      print('lenght:' + base64stringList!.length.toString());

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
