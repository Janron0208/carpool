import 'dart:convert';

import 'package:carpool/unity/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? code, fullname, nickname, tel, line, password, type;
  String obscureText = 'hide';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      appBar: AppBar(
        title: Text('สมัครสมาชิก'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            elevation: 8,
            shadowColor: const Color.fromARGB(255, 163, 163, 163),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('รหัสพนักงาน', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 3),
                      buildCode(context),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text('ชื่อ-นามสกุล', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 3),
                      buildFullname(),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text('ชื่อเล่น', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 3),
                      buildNickname(context),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text('เบอร์โทรศัพท์', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 3),
                      buildTel(),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text('Line ID', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 3),
                      buildLine(),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text('รหัสผ่าน', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 3),
                      buildPassword(),
                      SizedBox(height: 15),
                      buildType(),
                      Spacer(),
                      buildAddAccBTN(context),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildType() {
    return Row(
      children: [
        Radio(
          value: 'user',
          groupValue: type,
          onChanged: (val) {
            setState(() {
              type = 'user';
            });
          },
        ),
        Text('ผู้ใช้', style: TextStyle(fontSize: 18)),
        SizedBox(width: 20),
        Radio(
          value: 'admin',
          groupValue: type,
          onChanged: (val) {
            setState(() {
              type = 'admin';
            });
          },
        ),
        Text('แอดมิน', style: TextStyle(fontSize: 18)),
      ],
    );
  }

  Container buildPassword() {
    return Container(
      height: 50,
      child: TextFormField(
        obscureText: obscureText == 'show' ? false : true,
        onChanged: (value) {
          setState(() {
            password = value.trim();
          });
        },
        style:
            TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
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
          fillColor: Color.fromARGB(255, 241, 241, 241),
        ),
      ),
    );
  }

  Container buildAddAccBTN(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // Adjust corner radius
            ),
          ),
        ),
        onPressed: () {
          // addAccountToDatabase(context);
          checkNullText();
        },
        child: Text(
          'เพิ่มรายชื่อ',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  Container buildLine() {
    return Container(
      height: 50,
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            line = value.trim();
          });
        },
        style:
            TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
        decoration: InputDecoration(
          hintText: 'Line ID',
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
          fillColor: Color.fromARGB(255, 241, 241, 241),
        ),
      ),
    );
  }

  Container buildTel() {
    return Container(
      height: 50,
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            tel = value.trim();
          });
        },
        style:
            TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'เบอร์โทรศัพท์',
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
          fillColor: Color.fromARGB(255, 241, 241, 241),
        ),
      ),
    );
  }

  Row buildNickname(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50,
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                nickname = value.trim();
              });
            },
            style: TextStyle(
                color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
            decoration: InputDecoration(
              hintText: 'ชื่อเล่น',
              hintStyle: TextStyle(
                  fontSize: 18.0, color: Color.fromARGB(255, 184, 184, 184)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
              fillColor: Color.fromARGB(255, 241, 241, 241),
            ),
          ),
        ),
      ],
    );
  }

  Container buildFullname() {
    return Container(
      height: 50,
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            fullname = value.trim();
          });
        },
        style:
            TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
        decoration: InputDecoration(
          hintText: 'ชื่อ - นามสกุล',
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
          fillColor: Color.fromARGB(255, 241, 241, 241),
        ),
      ),
    );
  }

  Row buildCode(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50,
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                code = value.trim();
              });
            },
            style: TextStyle(
                color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'รหัสพนักงาน',
              hintStyle: TextStyle(
                  fontSize: 18.0, color: Color.fromARGB(255, 184, 184, 184)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
              fillColor: Color.fromARGB(255, 241, 241, 241),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> checkNullText() async {
    if (type == null ||
        type!.isEmpty ||
        code == null ||
        code!.isEmpty ||
        fullname == null ||
        fullname!.isEmpty ||
        nickname == null ||
        nickname!.isEmpty ||
        tel == null ||
        tel!.isEmpty ||
        line == null ||
        line!.isEmpty ||
        password == null ||
        password!.isEmpty) {
      MyPopup().showError(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
    } else {
      checkNullCode();
    }
  }

  Future<void> checkNullCode() async {
    // final url = await Uri.parse(
    //     '${MyConstant().domain}/carpool/authen/getDataByCode.php?accType=$code');
    var response = await http.post(
      Uri.parse('${MyConstant().domain}/carpool/authen/getDataByCode.php'),
      body: {
        'Acc_Code': code,
      },
    );

    print(response.contentLength);

    try {
      if (response.contentLength == 2) {
        print('ใช้รหัสพนักงานนี้ได้ ');
        askToConfirm();
      } else {
        MyPopup().showToastError(context, 'มีรหัสพนักงานในระบบแล้ว');
        print('มีบัญนี้ในระบบแล้ว');
      }
    } catch (e) {}
  }

  Future<Null> askToConfirm() async {
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
                    height: 130,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(220, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        )),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: MyStyle().showTextSC('ยืนยันการลงทะเบียน',
                                  22, Color.fromARGB(255, 29, 29, 29))),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyStyle().showTextSC(
                                    'เมื่อทำการลงทะเบียนแล้วกรุณารอทางแอดมินอนุมัติสิทธิการเข้าใช้งาน',
                                    14,
                                    const Color.fromARGB(255, 66, 66, 66)),
                              ],
                            ),
                          )),
                          SizedBox(height: 10),
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
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Center(
                                child: Text('ยืนยัน',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 72, 209, 72),
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

  Map<String?, String> data = {};

  Future<void> insertData() async {
    print('$type , $code ,$fullname ,$nickname ,$tel ,$line , $password');

    var response = await http.post(
      Uri.parse('${MyConstant().domain}/carpool/authen/insertAccount.php'),
      body: data = {
        'Acc_Type': type!,
        'Acc_Code': code!,
        'Acc_Fullname': fullname!,
        'Acc_Nickname': nickname!,
        'Acc_Tel': tel!,
        'Acc_Line': line!,
        'Acc_Password': password!,
      },
    );

    if (response.statusCode == 200) {
      // Success
      print('Success');
    } else {
      // Error
      print('Error');
    }
  }
}