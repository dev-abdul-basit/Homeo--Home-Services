import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  dialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Image.asset(
            'assets/images/review.png',
            height: 140,
            width: 140,
          ),
          const Text(
            "Review Submit",
            style: TextStyle(
              fontSize: 20.0,
              color: Color(0xFF0B735F),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            "Thanks for feedback!",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 32.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
