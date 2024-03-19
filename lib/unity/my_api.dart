import 'dart:convert';

import 'package:carpool/checklogin.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

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

  Future<Null> askToLogout(context) async {
    showDialog(
      context: context,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.all(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(218, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        )),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: Image.asset('images/error.gif'),
                          ),
                          Text("ออกจากระบบ ?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 223, 65, 65),
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.2),
                child: Container(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(220, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              signOutProcess(context);

                              MyPopup().showToast(context, 'ออกจากระบบสำเร็จ');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Center(
                                child: Text('ยืนยัน',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 72, 154, 209),
                                      fontSize: 18,
                                    )),
                              ),
                            ),
                          ),
                          VerticalDivider(),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Center(
                                child: Text('ปิด',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 216, 71, 71),
                                      fontSize: 18,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> signOutProcess(BuildContext context) async {
    insertLogEvent('ออกจากระบบ');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    // exit(0);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => Checklogin(),
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  void insertLogEvent(String? text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String accCode = preferences.getString('Acc_Code')!;

    final url2 = await Uri.parse(
      '${MyConstant().domain}/carpool/authen/getUserByCode.php?Acc_Code=$accCode',
    );

    http.Response response = await http.get(url2);

    var data = json.decode(response.body);

    var now = DateTime.now();
    var formatterDate = DateFormat('yyyyMMdd').format(now);
    var formatterTime = DateFormat('HH:mm').format(now);
    var formattershowTime = DateFormat('dd/MM/yyyy').format(now);

    // print(data[0]['Acc_ID']);
    // print(formatterDate);
    // print('${data[0]['Acc_Fullname']} ได้เข้าสู่ระบบ เมื่อ $formatterTime น.');
    // print(formatterDate);

    // เตรียม URL สำหรับการส่งค่าไปยัง PHP
    var url1 =
        Uri.parse('${MyConstant().domain}/carpool/log/insertLogevent.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response1 = await http.post(
      url1,
      body: {
        'accID': data[0]['Acc_ID'],
        'logDate': formatterDate,
        'logEvent':
            'คุณ ${data[0]['Acc_Fullname']}(${data[0]['Acc_Nickname']}) ${text!} เมื่อวันที่ $formattershowTime เวลา $formatterTime น.'
      },
    );

    if (response1.statusCode == 200) {
      // Success
      print('Success');
    } else {
      // Error
      print('Error');
    }
  }

  MyApi();
}
