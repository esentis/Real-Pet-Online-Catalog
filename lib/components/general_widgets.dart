import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

var logger = Logger();
// A BEAUTIFUL SNACKBAR CONSTRUCTOR
void snackBar({
  String text,
  String title,
  int duration,
  IconData iconData,
  Color iconColor,
  TickerProvider context,
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
          textStyle: const TextStyle(color: Colors.white, letterSpacing: .5),
        ),
      ),
      messageText: Text(text),
      shouldIconPulse: true, onTap: (value) {
    print(value);
  },
      showProgressIndicator: true,
      isDismissible: true,
      duration: Duration(seconds: duration),
      progressIndicatorBackgroundColor: Colors.red,
      barBlur: 999999,
      snackStyle: SnackStyle.FLOATING);
}
