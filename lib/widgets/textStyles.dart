import 'package:flutter/material.dart';
import 'package:travelman/widgets/consts_temp.dart';

// ignore: must_be_immutable
class BoldText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  bool isVeryBold = false;

  BoldText(this.text, this.size, this.color);
  BoldText.veryBold(this.text, this.size, this.color, this.isVeryBold);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontFamily: "nunito",
            fontWeight: isVeryBold ? FontWeight.w900 : FontWeight.w700,
            color: color,
            fontSize: size));
  }
}

class NormalText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;

  NormalText(this.text, this.color, this.size);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontFamily: "nunito",
            fontWeight: FontWeight.w300,
            color: color,
            fontSize: size));
  }
}

class AppTextStyles {
  static const headerTextStyle = const TextStyle(
      fontSize: 32.0, fontWeight: FontWeight.w800, color: headerTextColor);

  static const subHeaderTextStyle = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
  );

  static const unselectedTabTextStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );

  static const selectedTabTextStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );
}
