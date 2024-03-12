import 'package:flutter/material.dart';

class MyStyle {
  Container BG_Image(BuildContext context, String string) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: Image.asset(
        'images/$string',
        fit: BoxFit.cover,
      ),
    );
  }

  Container BG_Color(BuildContext context, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      color: color,
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

  Color color1 = Color.fromARGB(255, 37, 63, 96);
  Color color2 = Color.fromARGB(255, 81, 101, 128);
  Color color3 = Color.fromARGB(255, 124, 140, 160);
  Color color4 = Color.fromARGB(255, 168, 178, 191);
  Color color5 = Color.fromARGB(255, 211, 217, 223);
  Color color6 = Color.fromARGB(255, 255, 255, 255);

  MyStyle();
}
