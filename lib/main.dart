import 'package:carpool/adminscreen/main_admin.dart';
import 'package:carpool/authen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:carpool/authen/account_add.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Itim',
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBarTheme: AppBarTheme(
          titleTextStyle:
              TextStyle(color: Colors.white, fontFamily: 'Itim', fontSize: 24),
          color: Colors.grey, //<-- SEE HERE
        ),
      ),
      title: 'Carpool_PNut_3',
      home: MainAdmin(),
    );
  }
}
