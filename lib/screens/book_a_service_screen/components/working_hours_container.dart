import 'package:flutter/material.dart';
import 'package:handyman/constants.dart';

class WorkingHoursContianer extends StatefulWidget {
  const WorkingHoursContianer({Key? key}) : super(key: key);

  @override
  State<WorkingHoursContianer> createState() => _WorkingHoursContianerState();
}

class _WorkingHoursContianerState extends State<WorkingHoursContianer> {
  int _counter = 2;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      margin: const EdgeInsets.all(8),
      child: Card(
        color: kSecondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Working Hours",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kPrimaryLightColor.withOpacity(0.2),
                        ),
                        child: InkWell(
                          onTap: () {
                            _decrement();
                            setState(() {
                              if (_counter <= 2) {
                                _counter = 2;
                              }
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 12.0),
                            child: Icon(
                              Icons.minimize,
                              size: 18,
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('$_counter'),
                    ),
                    Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kPrimaryLightColor.withOpacity(0.2),
                        ),
                        child: InkWell(
                          onTap: () {
                            _increment();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 0.0),
                            child: Icon(
                              Icons.add,
                              size: 18,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
