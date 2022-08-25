import 'dart:async';

import 'package:flutter/material.dart';

import 'package:handyman/constants.dart';

class HomeFilterChips extends StatefulWidget {
  const HomeFilterChips({Key? key}) : super(key: key);

  @override
  State<HomeFilterChips> createState() => _HomeFilterChipsState();
}

class _HomeFilterChipsState extends State<HomeFilterChips> {
  final List<String> _options = [
    'All',
    'Cleaning',
    'Plumbing',
    'Appliances',
    'Laundary'
  ];

  final List<bool> _selected = [true, false, false, false, false];

  int? tappedIndex;
  @override
  void initState() {
    super.initState();
    tappedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 12),
        child: ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: FilterButton(
                  text: _options[index],
                  selected: _selected[index],
                  selectedColor: tappedIndex == index
                      ? kPrimaryColor
                      : kTextColorSecondary,
                  press: () {
                    setState(() {
                      tappedIndex = index;

                      print(index);
                    });
                  },
                ),
              );
            }),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
    required this.text,
    required this.press,
    required this.selected,
    required this.selectedColor,
  }) : super(key: key);
  final String text;
  final Function press;
  final bool selected;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: () {
          press();
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          primary: selectedColor,
          onPrimary: kSecondaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }
}
