import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyApi {
  void NavigatorPushAnim(context, type, Widget) async {
    Navigator.push(
      context,
      PageTransition(
        type: type,
        alignment: Alignment.bottomCenter,
        duration: Duration(milliseconds: 300),
        child: Widget,
      ),
    );
  }

  MyApi();
}
