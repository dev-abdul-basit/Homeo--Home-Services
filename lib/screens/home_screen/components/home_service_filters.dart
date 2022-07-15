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
  Widget _buildChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _options.length; i++) {
      ChoiceChip filterChip = ChoiceChip(
        selected: _selected[i],
        label: Text(_options[i], style: const TextStyle(color: Colors.white)),
        elevation: 2,
        selectedColor: kPrimaryLightColor,
        backgroundColor: kTextColorSecondary,
        onSelected: (bool selected) {
          setState(() {
            _selected[i] = selected;
            print(_options[i].toString());
            print(_selected[i].toString());
          });
        },
      );

      chips.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: filterChip));
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 12),
        child: _buildChips(),
      ),
    );
  }
}
