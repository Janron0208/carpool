import 'package:carpool/checklogin.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:carpool/authen/account_add.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MaterialColor mycolor = MaterialColor(
    0xFFA5E28D,
    <int, Color>{50: MyStyle().color1},
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Itim',
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBarTheme: AppBarTheme(
          titleTextStyle:
              TextStyle(color: Colors.white, fontFamily: 'Itim', fontSize: 24),
          color: Colors.grey, //<-- SEE HERE
        ),
      ),
      title: 'Carpool',
      home:
          Checklogin(),
    );
  }
}
