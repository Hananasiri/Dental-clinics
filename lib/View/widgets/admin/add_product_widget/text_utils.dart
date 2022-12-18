
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';



class TextUtils extends StatelessWidget {
  final String text;

  TextUtils(
      {Key? key,
        required this.text,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style:
      // GoogleFonts.lato
      // textStyle:
      TextStyle(
        color: Colors.grey.shade800,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),

    );
  }
}
