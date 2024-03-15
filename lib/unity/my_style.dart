import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  Text showTextNumberS(String? text, double size) {
    String formatAmount() {
      String price = text!;
      String priceInText = "";
      int counter = 0;
      for (int i = (price.length - 1); i >= 0; i--) {
        counter++;
        String str = price[i];
        if ((counter % 3) != 0 && i != 0) {
          priceInText = "$str$priceInText";
        } else if (i == 0) {
          priceInText = "$str$priceInText";
        } else {
          priceInText = ",$str$priceInText";
        }
      }
      return priceInText.trim();
    }

    return Text(
      formatAmount(),
      style: TextStyle(fontSize: size),
    );
  }

  Text showTextNumberSC(String? text, double size, Color color) {
    String formatAmount() {
      String price = text!;
      String priceInText = "";
      int counter = 0;
      for (int i = (price.length - 1); i >= 0; i--) {
        counter++;
        String str = price[i];
        if ((counter % 3) != 0 && i != 0) {
          priceInText = "$str$priceInText";
        } else if (i == 0) {
          priceInText = "$str$priceInText";
        } else {
          priceInText = ",$str$priceInText";
        }
      }
      return priceInText.trim();
    }

    return Text(
      formatAmount(),
      style: TextStyle(fontSize: size, color: color),
    );
  }

  Text showTextNumberSCW(
      String? text, double size, Color color, FontWeight weight) {
    String formatAmount() {
      String price = text!;
      String priceInText = "";
      int counter = 0;
      for (int i = (price.length - 1); i >= 0; i--) {
        counter++;
        String str = price[i];
        if ((counter % 3) != 0 && i != 0) {
          priceInText = "$str$priceInText";
        } else if (i == 0) {
          priceInText = "$str$priceInText";
        } else {
          priceInText = ",$str$priceInText";
        }
      }
      return priceInText.trim();
    }

    return Text(
      formatAmount(),
      style: TextStyle(fontSize: size, color: color, fontWeight: weight),
    );
  }

  String dateTypeDDMMYYYY(String? text) {
    String changeDateTypeOne() {
      // แปลง String เป็น DateTime
      var dateTime = DateFormat('yyyy-MM-dd').parse(text!);
      // รูปแบบวันที่ใหม่
      var formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

      return formattedDate;
    }

    return changeDateTypeOne();
  }

  String dateTypeYYYYMMDD(String? text) {
    String changeDateTypeOne() {
      // แปลง String เป็น DateTime
      var dateTime = DateFormat('yyyy-MM-dd').parse(text!);
      // รูปแบบวันที่ใหม่
      var formattedDate = DateFormat('yyyyMMdd').format(dateTime);

      return formattedDate;
    }

    return changeDateTypeOne();
  }

  String dateTypeddmmyyyy(String? text) {
    String changeDateTypeOne() {
      // แปลง String เป็น DateTime
      var dateTime = DateFormat('yyyyMMdd').parse(text!);
      // รูปแบบวันที่ใหม่
      var formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

      return formattedDate;
    }

    return changeDateTypeOne();
  }

  Color color1 = Color.fromARGB(255, 37, 63, 96);
  Color color2 = Color.fromARGB(255, 81, 101, 128);
  Color color3 = Color.fromARGB(255, 124, 140, 160);
  Color color4 = Color.fromARGB(255, 168, 178, 191);
  Color color5 = Color.fromARGB(255, 211, 217, 223);
  Color color6 = Color.fromARGB(255, 255, 255, 255);

  MyStyle();
}
