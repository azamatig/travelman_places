import 'package:flutter/material.dart';

final korange = const Color(0xFFFF9933);
final korangelite = const Color(0xFFFFBE83);
final kwhite = const Color(0xFFFFFFFF);
final kdarkBlue = const Color(0xFF333366);
final kblack = const Color(0xFF000000);
final kgreyDark = Colors.grey.shade700;
final kgreyFill = Colors.grey.shade100;

const primaryColor = const Color(0xFFFFAC00);
const statusBarColor = Colors.white;
const appBarColor = Colors.white;
const scaffoldColor = Colors.white;

const headerTextColor = const Color(0xFF120E4C);
const notificationSectionColor = const Color(0xFF1D2637);

const orange = const Color(0xFFFFAC00);
const red = const Color(0xFFEE604E);
const blue = const Color(0xFF7D7DE3);
const unselectedCardColor = const Color(0xFFF6F6F6);

const kPinBlue = Color.fromARGB(255, 57, 90, 255);

const kToken = 'f41230bc222d3528d8909d1def2913d3';
const kInputDecoration = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 10),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: kPinBlue,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

//Textss

const String POPPINS = "Poppins";
const String OPEN_SANS = "OpenSans";
const String SKIP = "Skip";
const String NEXT = "Next";
const String SLIDER_HEADING_1 = "Fast Travel!";
const String SLIDER_HEADING_2 = "Easy to Use!";
const String SLIDER_HEADING_3 = "Safest Option";
const String SLIDER_DESC =
    "Live the best and easiest traveling experience with us,the fastest and most reliable option you can ever find.";
