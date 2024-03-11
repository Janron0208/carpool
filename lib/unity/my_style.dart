import 'package:flutter/material.dart';

class MyStyle {
  Container BG_PinkPurple(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: Image.asset(
        'images/bg2.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Text showTextSCW(String text, double size, FontWeight weight, Color color) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: weight),
    );
  }

  Text showTextS(String text, double size) {
    return Text(
      text,
      style: TextStyle(fontSize: size),
    );
  }

  Text showTextSC(String text, double size, Color color) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color),
    );
  }

  MyStyle();
}
