import 'dart:convert';
import 'package:carpool/adminscreen/main_page.dart';
import 'package:carpool/authen/register_page.dart';
import 'package:carpool/unity/my_api.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:carpool/userscreen/main_user.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? accCode, password;
  String obscureText = 'hide';
  String processing = 'no';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          showContent(context),
          processing == 'no'
              ? Container()
              : Container(
                  height: MediaQuery.of(context).size.height * 1,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Color.fromARGB(132, 255, 255, 255),
                  child: MyPopup().showProcessing(),
                )
        ],
      ),
    );
  }

  Container showContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg2.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   child: ClipRRect(
              //     // borderRadius: BorderRadius.circular(20), // Image border
              //     child: SizedBox.fromSize(
              //         size: Size.fromRadius(100), // Image radius
              //         child: Container(
              //           width: 400,
              //           height: 400,
              //           child: Image.asset('images/svoa_logo.jpg'),
              //         )),
              //   ),
              // ),
              showLogoSVOA(context),
              SizedBox(height: 1),
              MyStyle().showTextSCW(
                  'Carpool', 70, FontWeight.bold, MyStyle().color1),
              MyStyle().showTextSC(
                  'แอปพลิเคชันการจองรถยนต์บริษัท', 15, MyStyle().color1),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  // width: MediaQuery.of(context).size.width * 0.9,
                  // height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width > 390
                      ? 390
                      : MediaQuery.of(context).size.width,
                  height: 390,
                  decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Color.fromARGB(255, 224, 224, 224),
                    //     blurRadius: 1,
                    //     offset: Offset(3, 5), // Shadow position
                    //   ),
                    // ],
                    color: Color.fromARGB(92, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'รหัสพนักงาน',
                              style: TextStyle(
                                color: MyStyle().color1,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        showInputCode(),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'รหัสผ่าน',
                              style: TextStyle(
                                  color: MyStyle().color1, fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        showInputPassword(),
                        SizedBox(height: 40),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  MyStyle().color1),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Adjust corner radius
                                ),
                              ),
                            ),
                            onPressed: () {
                              CheckNullText();

                              // print('$code , $password');
                            },
                            child: Text(
                              'เข้าสู่ระบบ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            MyApi().NavigatorPushAnim(context,
                                PageTransitionType.fade, RegisterPage());
                          },
                          child: MyStyle()
                              .showTextSC('สมัครสมาชิก', 18, MyStyle().color1),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField showInputPassword() {
    return TextFormField(
      obscureText: obscureText == 'show' ? false : true,
      onChanged: (value) {
        setState(() {
          password = value.trim();
        });
      },
      onSaved: (val) => password = val,
      // obscureText: _obscureText,
      style: TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
      decoration: InputDecoration(
        suffixIcon: IconButton(
            icon: Icon(obscureText == 'show'
                ? Icons.visibility_off
                : Icons.visibility),
            onPressed: () {
              if (obscureText == 'show') {
                setState(() {
                  obscureText = 'hide';
                  print(obscureText);
                });
              } else {
                setState(() {
                  obscureText = 'show';
                  print(obscureText);
                });
              }
            }),
        hintText: 'รหัสผ่าน',
        hintStyle: TextStyle(
            fontSize: 18.0, color: Color.fromARGB(255, 184, 184, 184)),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  TextFormField showInputCode() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          accCode = value.trim();
        });
      },
      style: TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
      decoration: InputDecoration(
        hintText: 'รหัสพนักงาน',
        hintStyle: TextStyle(
            fontSize: 18.0, color: Color.fromARGB(255, 184, 184, 184)),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Container showLogoSVOA(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Image.asset('images/svoa_logo_nobg.png'),
    );
  }

  Future<Null> CheckNullText() async {
    print(accCode);
    print(password);
    if (accCode == null ||
        accCode!.isEmpty ||
        password == null ||
        password!.isEmpty) {
      MyPopup()
          .showError(context, 'กรุณากรอกข้อมูลให้ครบถ้วนก่อนทำการเข้าสู่ระบบ');
    } else {
      setState(() {
        processing = 'yes';
      });
      checknullCode();
    }
  }

  List<dynamic> data = [];

  void checknullCode() async {
    final url = await Uri.parse(
      '${MyConstant().domain}/carpool/authen/getUserByCode.php?Acc_Code=$accCode',
    );

    http.Response response = await http.get(url);

    var data = json.decode(response.body);
    // print(response.body);

    if (response.body == '[]') {
      setState(() {
        processing = 'no';
        MyPopup().showToastError(context, 'ไม่มีรหัสพนักงานนี้ในระบบ');
      });
    } else {
      checkPass();
    }
  }

  void checkPass() async {
    // เตรียม URL สำหรับการส่งค่าไปยัง PHP
    var url =
        Uri.parse('${MyConstant().domain}/carpool/authen/loginAction.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url,
      body: {'accCode': accCode, 'inputPassword': password},
    );

    // ตรวจสอบสถานะการตอบกลับ
    if (response.statusCode == 200) {
      // การส่งข้อมูลสำเร็จ
      // ตรวจสอบค่า response.body ว่า true หรือ false
      if (response.body == 'true') {
        // ตรงกัน
        print('Login successful!');
        checkType();
      } else {
        // ไม่ตรงกัน
        setState(() {
          processing = 'no';
          print('Login failed!');
          MyPopup().showToastError(context, 'รหัสผ่านผิดพลาด');
        });
      }
    } else {
      // เกิดข้อผิดพลาด
      // แสดงข้อความแจ้งเตือน
    }
  }

  void checkType() async {
    final url = await Uri.parse(
      '${MyConstant().domain}/carpool/authen/getUserByCode.php?Acc_Code=$accCode',
    );

    http.Response response = await http.get(url);

    var data = json.decode(response.body);

    if (data[0]['Acc_Status'] == 'Actived') {
      if (data[0]['Acc_Type'] == 'user') {
        print('สวัสดีผู้ใช้งานทั่วไป ');
        routeTuService(MainPage(), data);
        MyPopup().showToast(context, 'เข้าสู่ระบบสำเร็จ');
        setState(() {
          processing = 'no';
        });
      } else {
        routeTuService(MainPage(), data);
        print('สวัสดีแอดมิน ');
        MyPopup().showToast(context, 'เข้าสู่ระบบสำเร็จ');
        setState(() {
          processing = 'no';
        });
      }
    } else if (data[0]['Acc_Status'] == 'Pending') {
      setState(() {
        processing = 'no';
        MyPopup().showToast(context, 'กรุณารอผลการอนุมัติ');
      });
    } else {
      setState(() {
        processing = 'no';
        MyPopup().showError(context, 'คุณไม่ผ่านการอนุมัติกรุณาติดต่อแอดมิน');
      });
    }
  }

  Future<Null> routeTuService(Widget myWidget, dynamic data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(MyConstant().keyId, data[0]['Acc_ID']);
    preferences.setString(MyConstant().keyType, data[0]['Acc_Type']);
    preferences.setString(MyConstant().keyCode, data[0]['Acc_Code']);
    preferences.setString(MyConstant().keyFullname, data[0]['Acc_Fullname']);
    preferences.setString(MyConstant().keyNickname, data[0]['Acc_Nickname']);
    preferences.setString(MyConstant().keyTel, data[0]['Acc_Tel']);
    preferences.setString(MyConstant().keyLine, data[0]['Acc_Line']);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
