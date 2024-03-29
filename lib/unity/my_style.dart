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

  Text showSizeTextSCW(
      context, String text, double size, FontWeight weight, Color color) {
    return Text(
      text,
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.width / size,
          color: color,
          fontWeight: weight),
    );
  }

  Text showSizeTextS(context, String text, double size) {
    return Text(
      text,
      style: TextStyle(fontSize: MediaQuery.of(context).size.width / size),
    );
  }

  Text showSizeTextSC(context, String text, double size, Color color) {
    return Text(
      text,
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.width / size, color: color),
    );
  }

  Text showTextNumberS(context, String? text, double size) {
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
      style: TextStyle(fontSize: MediaQuery.of(context).size.width / size),
    );
  }

  Text showTextNumberSC(context, String? text, double size, Color color) {
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
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.width / size, color: color),
    );
  }

  Text showTextNumberSCW(
      context, String? text, double size, Color color, FontWeight weight) {
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
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.width / size,
          color: color,
          fontWeight: weight),
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
      String dateString = '$text';
      String year = dateString.substring(0, 4);
      int intyear = int.parse(year) + 543;
      String th_year = '$intyear';
      String month = dateString.substring(4, 6);
      String day = dateString.substring(6, 8);
      String formattedDate = '$day/$month/$th_year';

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
