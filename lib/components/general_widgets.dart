import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

var logger = new Logger();
// A BEAUTIFUL SNACKBAR CONSTRUCTOR
snackBar({
  String text,
  String title,
  int duration,
  IconData iconData,
  Color iconColor,
}) {
  return Get.snackbar(
    '', // title
    '', // message
    icon: Icon(
      iconData,
      color: iconColor,
    ),
    titleText: Text(
      title,
      style: GoogleFonts.comfortaa(
        textStyle: TextStyle(color: Colors.white, letterSpacing: .5),
      ),
    ),
    messageText: Text(text),
    shouldIconPulse: true,
    onTap: (value) {
      print(value);
    },
    barBlur: 300,
    isDismissible: true,
    duration: Duration(seconds: duration),
  );
}