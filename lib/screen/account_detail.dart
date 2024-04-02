import 'dart:convert';

import 'package:carpool/screen/account_changepass.dart';
import 'package:carpool/screen/account_edit.dart';
import 'package:flutter/material.dart';
import 'package:carpool/models/user_model.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:http/http.dart' as http;

class AccountDetail extends StatefulWidget {
  final String accID, formpage;
  const AccountDetail({super.key, required this.accID, required this.formpage});

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  String? loaddata = 'yes';
  List<UserModel> userModels = [];
  String? status;

  @override
  void initState() {
    loadUserByAccID();
    super.initState();
  }

  void loadUserByAccID() async {
    final url = await Uri.parse(
      '${MyConstant().domain}/carpool/authen/getUserByAccID.php?Acc_ID=${widget.accID}',
    );

    http.Response response = await http.get(url);

    var data = json.decode(response.body);

    for (var item in data) {
      UserModel userModel = UserModel.fromJson(item);
      setState(() {
        userModels.add(userModel);
        print(userModels[0].accFullname);
      });

      setState(() {
        loaddata = 'no';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MyStyle().BG_Image(context, 'bg2.jpg'),
          loaddata == 'yes'
              ? MyPopup().showLoadData()
              : SafeArea(
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 1,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 70, left: 10, right: 10, bottom: 10),
                            child: Material(
                              color: Color.fromARGB(110, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                              // elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: MyStyle().showSizeTextS(
                                                context, 'รหัสพนักงาน :', 23)),
                                        Expanded(
                                            flex: 2,
                                            child: MyStyle().showSizeTextSC(
                                                context,
                                                '${userModels[0].accCode}',
                                                20,
                                                MyStyle().color1)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: MyStyle().showSizeTextS(
                                                context,
                                                'ชื่อ - นามสกุล :',
                                                23)),
                                        Expanded(
                                            flex: 2,
                                            child: MyStyle().showSizeTextSC(
                                                context,
                                                '${userModels[0].accFullname}',
                                                20,
                                                MyStyle().color1)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: MyStyle().showSizeTextS(
                                                context, 'ชื่อเล่น :', 23)),
                                        Expanded(
                                            flex: 2,
                                            child: MyStyle().showSizeTextSC(
                                                context,
                                                '${userModels[0].accNickname}',
                                                20,
                                                MyStyle().color1)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: MyStyle().showSizeTextS(
                                                context,
                                                'เบอร์โทรศัพท์ :',
                                                23)),
                                        Expanded(
                                            flex: 2,
                                            child: MyStyle().showSizeTextSC(
                                                context,
                                                '${userModels[0].accTel}',
                                                20,
                                                MyStyle().color1)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: MyStyle().showSizeTextS(
                                                context, 'Line ID :', 23)),
                                        Expanded(
                                            flex: 2,
                                            child: MyStyle().showSizeTextSC(
                                                context,
                                                '${userModels[0].accLine}',
                                                20,
                                                MyStyle().color1)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    widget.formpage != 'verify'
                                        ? Container()
                                        : Row(
                                            children: [
                                              Spacer(),
                                              MyStyle().showSizeTextS(context,
                                                  'ประเภทบัญชี : ', 22),
                                              MyStyle().showSizeTextSC(
                                                  context,
                                                  '${userModels[0].accType}',
                                                  18,
                                                  userModels[0].accType ==
                                                          'user'
                                                      ? Colors.green
                                                      : Colors.red),
                                            ],
                                          ),
                                    Spacer(),
                                    widget.formpage != 'verify'
                                        ? Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 50,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.white),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<
                                                                    Color>(
                                                                MyStyle()
                                                                    .color3),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20.0), // Adjust corner radius
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    MyPopup().showToast(context,
                                                        'ยังไม่เปิดใช้งาน');
                                                  },
                                                  child: Text(
                                                    'ประวัติการใช้รถยนต์',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 50,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.white),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<
                                                                    Color>(
                                                                MyStyle()
                                                                    .color2),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20.0), // Adjust corner radius
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    MaterialPageRoute route =
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AccountChangePass(
                                                                  accID:
                                                                      userModels[
                                                                              0]
                                                                          .accID!,
                                                                ));
                                                    Navigator.push(
                                                            context, route)
                                                        .then((value) {
                                                      setState(() {
                                                        loaddata = 'yes';
                                                        userModels.clear();
                                                        loadUserByAccID();
                                                      });
                                                    });
                                                  },
                                                  child: Text(
                                                    'เปลี่ยนรหัสผ่าน',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 50,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    foregroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.white),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<
                                                                    Color>(
                                                                MyStyle()
                                                                    .color1),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20.0), // Adjust corner radius
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    MaterialPageRoute route =
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    AccountEdit(
                                                                      accID: userModels[
                                                                              0]
                                                                          .accID!,
                                                                      accCode: userModels[
                                                                              0]
                                                                          .accCode!,
                                                                      accFullname:
                                                                          userModels[0]
                                                                              .accFullname!,
                                                                      accNickname:
                                                                          userModels[0]
                                                                              .accNickname!,
                                                                      accTel: userModels[
                                                                              0]
                                                                          .accTel!,
                                                                      accLine: userModels[
                                                                              0]
                                                                          .accLine!,
                                                                    ));
                                                    Navigator.push(
                                                            context, route)
                                                        .then((value) {
                                                      setState(() {
                                                        loaddata = 'yes';
                                                        userModels.clear();
                                                        loadUserByAccID();
                                                      });
                                                    });
                                                  },
                                                  child: Text(
                                                    'แก้ไขรายชื่อ',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<
                                                                      Color>(
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      125,
                                                                      223,
                                                                      128)),
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.zero,
                                                      ))),
                                                  onPressed: () {
                                                    setState(() {
                                                      status = 'Actived';
                                                      askToConfirmPass();
                                                    });
                                                  },
                                                  child: Text(
                                                    'อนุมัติ',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 53, 53, 53),
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(),
                                              ),
                                              userModels[0].accStatus ==
                                                      'Unauthorized'
                                                  ? Expanded(
                                                      flex: 4,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty.all<
                                                                        Color>(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        223,
                                                                        125,
                                                                        125)),
                                                            shape: MaterialStateProperty.all<
                                                                    RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .zero,
                                                            ))),
                                                        onPressed: () {},
                                                        child: Text(
                                                          'ลบบัญชี',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    53,
                                                                    53,
                                                                    53),
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Expanded(
                                                      flex: 4,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty.all<
                                                                        Color>(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        223,
                                                                        125,
                                                                        125)),
                                                            shape: MaterialStateProperty.all<
                                                                    RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .zero,
                                                            ))),
                                                        onPressed: () {
                                                          setState(() {
                                                            status =
                                                                'Unauthorized';
                                                            askToConfirmPass();
                                                          });
                                                        },
                                                        child: Text(
                                                          'ไม่ผ่าน',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    53,
                                                                    53,
                                                                    53),
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          )
                                  ],
                                ),
                              ),
                            )),
                      ),
                      showheadBar(context),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Container showheadBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 60,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios,
                      size: 30, color: Colors.white))),
          Expanded(
              flex: 3,
              child: Center(
                child: MyStyle().showSizeTextSC(
                    context, '${userModels[0].accFullname}', 17, Colors.white),
              )),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }

  Future<Null> askToConfirmPass() async {
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
                          Text(
                              status == 'Actived'
                                  ? "ยืนยันการอนุมัติ!!"
                                  : "ยืนยันไม่ผ่าน!!",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 117, 117, 117),
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
                              updatetData();
                              print(status);
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
  Future<void> updatetData() async {
    var response = await http.post(
      Uri.parse('${MyConstant().domain}/carpool/authen/updateStatus.php'),
      body: data = {
        'Acc_ID': widget.accID,
        'Acc_Status': status!,
      },
    );

    if (response.statusCode == 200) {
      // Success
      print('Success');
      Navigator.pop(context);
    } else {
      // Error
      print('Error');
    }
  }
}
