import 'package:carpool/screen/main_page.dart';
import 'package:carpool/authen/login_page.dart';
import 'package:carpool/unity/my_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checklogin extends StatefulWidget {
  const Checklogin({super.key});

  @override
  State<Checklogin> createState() => _CheckloginState();
}

class _CheckloginState extends State<Checklogin> {
  String? idLogin;
  String? typeLogin;

  @override
  void initState() {
    checkPreferance();
    MyApi().checkEndToReserve();
    super.initState();
  }

  Future<void> checkPreferance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? typeLogin = preferences.getString('Acc_Type');
      String? idLogin = preferences.getString('Acc_ID');
      print('idLogin = $idLogin');
      print('chooseType = $typeLogin');

      if (idLogin != null && idLogin.isNotEmpty) {
        // String url =
        //     '${MyConstant().domain}/champshop/editTokenWhereId.php?isAdd=true&id=$idLogin&Token=$token';
        // await Dio()
        //     .get(url)
        //     .then((value) => print('###### Update Token Success #####'));
      } else {
        routeToService(LoginPage());
      }

      if (typeLogin != null && typeLogin.isNotEmpty) {
        if (typeLogin == 'user') {
          routeToService(MainPage());
        } else {
          routeToService(MainPage());
        }
      }
    } catch (e) {}
  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/bg2.jpg',
      fit: BoxFit.cover,
    );
  }
}
