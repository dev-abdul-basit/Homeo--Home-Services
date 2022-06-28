import 'package:flutter/material.dart';
import 'package:handyman/screens/search_screen/search_screen.dart';

import '../../../constants.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String? searchValue;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
        child: SizedBox(
          height: 48,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
            child: buildSearchFormField(),
          ),
        ),
      ),
    );
  }

  TextFormField buildSearchFormField() {
    return TextFormField(
      onTap: () => (Navigator.pushNamed(context, SearchScreen.routeName)),
      cursorColor: kTextColorSecondary.withOpacity(0.2),
      keyboardType: TextInputType.text,
      showCursor: false,
      onSaved: (newValue) => searchValue = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return "Search here";
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
          borderSide: BorderSide(color: kTextColorSecondary.withOpacity(0.2)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(color: kPrimaryColor),
        focusColor: kTextColorSecondary.withOpacity(0.2),
        hintText: "Search",
        fillColor: kTextColorSecondary.withOpacity(0.2),
        filled: true,
        prefixIcon: const Icon(
          Icons.search,
          color: kTextColorSecondary,
        ),
      ),
    );
  }
}
