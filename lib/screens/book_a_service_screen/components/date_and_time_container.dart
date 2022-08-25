import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:handyman/helper/global_config.dart';
import 'package:handyman/screens/book_a_service_screen/components/special_instructions.dart';
import 'package:handyman/screens/book_a_service_screen/components/working_hours_container.dart';
import 'package:handyman/screens/home_screen/homescreen.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../booking_summary/booking_summary.dart';

class DateAndTimePicker extends StatefulWidget {
  const DateAndTimePicker({
    Key? key,
    required this.title,
    required this.id,
    required this.speciality,
    required this.description,
    required this.note,
    required this.adress,
    required this.rate,
    required this.status,
    required this.spName,
    required this.spId,
    required this.serviceImages,
    required this.serviceImages1,
    required this.serviceImages2,
  }) : super(key: key);

  final String title,
      speciality,
      id,
      description,
      note,
      adress,
      rate,
      status,
      spName,
      spId,
      serviceImages,
      serviceImages1,
      serviceImages2;
  @override
  State<DateAndTimePicker> createState() => _DateAndTimePickerState();
}

class _DateAndTimePickerState extends State<DateAndTimePicker> {
  String? _setTime, _setDate;

  String? _hour, _minute, _time;

  String? dateTime;

  DateTime selectedDate = DateTime.now();

  bool booking = true;

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
        print(_dateController.text);
        print(_timeController.text);
        box!.put('b_date', _dateController.text);
        getAllData();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        _timeController.text = _time!;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        print(_dateController.text);
        print(_timeController.text);
        box!.put('b_time', _timeController.text);
        getAllData();
      });
  }

  ///get data & time for bookings
  ///
  final String url = baseUrlProvider + "user_check_bookings.php";

  late List data;

  var isLoading = false;
  bool isAdmin = true;

  Future getAllData() async {
    var response = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json"
    }, body: {
      "sp_id": widget.spId.toString(),
      "service_id": widget.id.toString(),
    });
    //print(response.body);
    setState(() {
      List convertDataToJson = json.decode(response.body)['result'];
      data = convertDataToJson;
      isLoading = true;
      print('\nDate & Time From DB\n');
      print(data);
      for (var i = 0; i < data.length; i++) {
        if (data[i]['b_date'] == _dateController.text &&
            (data[i]['b_time']).toString().substring(0, 2) ==
                _timeController.text.substring(0, 2)) {
          print('Sorry, Provider has already a booking at this data');
          booking = false;

          print((data[i]['b_time']).toString().substring(0, 2));
        } else {
          print('Great!!! BOOK NOW');
          booking = true;
        }
      }
    });

    // throw Exception('Failed to load data');
  }

///////////
  ///
  bool? error, sending, success;
  String? msg;

  String webUrl = baseUrl + "provider/get_provider_token.php";

  Future<void> getProviderData() async {
    var res = await http.post(Uri.parse(webUrl), body: {
      "spId": widget.spId.toString(),
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
          final snackBar = SnackBar(
            content: Text(data["msg"]),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      } else {
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

            box!.put("p_token", data["p_token"]);
            //mark success and refresh UI with setState

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

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();

    print("_setDate");
    print(_dateController.text);
    print(_timeController.text.substring(0, 2));
    box!.put('b_time', _timeController.text);
    box!.put('b_date', _dateController.text);
    print('init state');
    getAllData();
    getProviderData();
    print('ON BOOKING Details SCREEN**\n PROVIDER TOKEN:');
  }

  @override
  Widget build(BuildContext context) {
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Choose Date',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, letterSpacing: 0.5),
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 72,
                          margin: const EdgeInsets.only(top: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 32),
                            textAlign: TextAlign.center,
                            enabled: false,
                            keyboardType: TextInputType.text,
                            controller: _dateController,
                            onSaved: (String? val) {
                              _setDate = val!;
                            },
                            decoration: const InputDecoration(
                                disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                // labelText: 'Time',
                                contentPadding: EdgeInsets.only(top: 0.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Choose Time',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, letterSpacing: 0.5),
                      ),
                      InkWell(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          width: double.infinity,
                          height: 72,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8)),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 32),
                            textAlign: TextAlign.center,
                            onSaved: (String? val) {
                              _setTime = val!;
                            },
                            enabled: false,
                            keyboardType: TextInputType.text,
                            controller: _timeController,
                            decoration: const InputDecoration(
                                disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                // labelText: 'Time',
                                contentPadding: EdgeInsets.all(5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Divider(
          color: kFormColor,
          height: 8,
          thickness: 8,
        ),
        const SizedBox(height: 8),
        const WorkingHoursContianer(),
        const SizedBox(height: 8),
        const Divider(
          color: kFormColor,
          height: 8,
          thickness: 8,
        ),
        const SpecialInstructions(),
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 28, 24, 8),
          child: SizedBox(
            height: getProportionateScreenHeight(48),
            child: ElevatedButton(
              onPressed: () {
                if (booking == true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingSummary(
                          //first one will be available in next sceen
                          //second one we have here in this screen
                          id: widget.id,
                          title: widget.title,
                          speciality: widget.speciality,
                          description: widget.description,
                          note: widget.note,
                          adress: widget.adress,
                          rate: widget.rate,
                          status: widget.status,
                          spName: widget.spName,
                          spId: widget.spId,
                          serviceImages: widget.serviceImages,
                          serviceImages1: widget.serviceImages1,
                          serviceImages2: widget.serviceImages,
                        ),
                      ));
                } else {
                  const snackBar = SnackBar(
                    content: Text('Can not book at this time'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  //     HomeScreen.routeName, ((route) => false));
                }
              },
              child: Text(
                booking == true ? "Continue" : 'Already booked at this Time',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                primary: booking == true ? kPrimaryColor : kTextColorSecondary,
                onPrimary: kSecondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
        ),
        Visibility(
          visible: booking == true ? false : true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 28, 24, 8),
            child: SizedBox(
              height: getProportionateScreenHeight(48),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      HomeScreen.routeName, ((route) => false));
                },
                child: Text(
                  'Back to Home',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  primary: kPrimaryColor,
                  onPrimary: kSecondaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}
