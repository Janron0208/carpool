import 'dart:convert';

import 'package:carpool/models/history_model.dart';
import 'package:carpool/screen/Speed_Ticked.dart';
import 'package:carpool/screen/account_detail.dart';
import 'package:carpool/screen/account_list.dart';
import 'package:carpool/screen/account_verify.dart';
import 'package:carpool/screen/car_list.dart';
import 'package:carpool/screen/reserve_chooseday.dart';
import 'package:carpool/screen/reserve_showtable.dart';
import 'package:carpool/screen/return_car.dart';
import 'package:carpool/screen/savePic.dart';
import 'package:carpool/screen/using_waiting.dart';
import 'package:carpool/unity/my_api.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  String fullname = ' ';
  String nickname = ' ';
  String? type, accID;
  String checkstatus = 'yes';
  String checkined = 'no';
  String showReturnCar = 'no';
  String slideMenu = 'hide';

  Future<Null> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      accID = preferences.getString('Acc_ID')!;
      fullname = preferences.getString('Acc_Fullname')!;
      nickname = preferences.getString('Acc_Nickname')!;
      type = preferences.getString('Acc_Type')!;
    });
    checkstatusHistory();
  }

  Future<Null> checkstatusHistory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    accID = preferences.getString('Acc_ID')!;
    var url = Uri.parse(
        '${MyConstant().domain}/carpool/history/getHistoryByAccIDAndStatus.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url,
      body: {'Acc_ID': accID},
    );

    if (response.body == '[]') {
      setState(() {
        checkstatus = 'no';
      });
    } else {
      setState(() {
        checkined = 'yes';
        checkstatus = 'no';
      });
    }
    checkStatusDriving();
  }

  String? endDate;
  Future<Null> checkStatusDriving() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    accID = preferences.getString('Acc_ID')!;
    var url1 = Uri.parse(
        '${MyConstant().domain}/carpool/history/getHistoryByAccIDAndStatus.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url1,
      body: {'Acc_ID': accID, 'H_Status': 'driving'},
    );
    var data = json.decode(response.body);
    // print(response.body);
    // print(response.body.length);
    if (response.body.length > 2) {
      setState(() {
        showReturnCar = 'yes';
        endDate = data[0]['H_EndDate'];
      });
    } else {
      setState(() {
        showReturnCar = 'no';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          showBlackground(context),
          SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    // height: MediaQuery.of(context).size.height * 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 70, left: 25, right: 25, bottom: 10),
                      child: Column(
                        children: [
                          type == 'admin'
                              ? Column(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: Material(
                                        color:
                                            Color.fromARGB(71, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(10),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.pause_circle,
                                                color: Color.fromARGB(
                                                    255, 224, 164, 74),
                                                shadows: [
                                                  BoxShadow(blurRadius: 2)
                                                ],
                                              ),
                                              MyStyle().showSizeTextSC(
                                                  context,
                                                  ' กำลังใช้งาน ',
                                                  22,
                                                  MyStyle().color2),
                                              MyStyle().showSizeTextSC(context,
                                                  '5', 22, MyStyle().color2),
                                              MyStyle().showSizeTextSC(context,
                                                  ' คัน', 22, MyStyle().color2),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    MyApi().NavigatorPushAnim(
                                                        context,
                                                        PageTransitionType.fade,
                                                        SavePic());
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: Material(
                                        color:
                                            Color.fromARGB(71, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(10),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.play_circle,
                                                color: Color.fromARGB(
                                                    255, 74, 224, 74),
                                                shadows: [
                                                  BoxShadow(blurRadius: 2)
                                                ],
                                              ),
                                              MyStyle().showSizeTextSC(
                                                  context,
                                                  ' ว่างวันนี้ทั้งหมด ',
                                                  22,
                                                  MyStyle().color2),
                                              MyStyle().showSizeTextSC(context,
                                                  '5', 22, MyStyle().color2),
                                              MyStyle().showSizeTextSC(context,
                                                  ' คัน', 22, MyStyle().color2),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.white))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: Material(
                                        color:
                                            Color.fromARGB(71, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(10),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .notification_important_sharp,
                                                color: Color.fromARGB(
                                                    255, 224, 84, 74),
                                                shadows: [
                                                  BoxShadow(blurRadius: 2)
                                                ],
                                              ),
                                              MyStyle().showSizeTextSC(
                                                  context,
                                                  ' เกินกำหนดคืนรถ ',
                                                  22,
                                                  MyStyle().color2),
                                              MyStyle().showSizeTextSC(context,
                                                  '5', 22, MyStyle().color2),
                                              MyStyle().showSizeTextSC(context,
                                                  ' คัน', 22, MyStyle().color2),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.white))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                )
                              : Container(),
                          showReturnCar == 'no'
                              ? Container()
                              : showReturnCarBTN(context),
                          showMenu(context),
                        ],
                      ),
                    ),
                  ),
                ),
                showheadBar(context),
              ],
            ),
          ),
          slideMenu == 'hide' ? Container() : showSlideMenu(context)
        ],
      ),
    );
  }

  Row showSlideMenu(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 1,
          color: Color.fromARGB(218, 131, 131, 131),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          slideMenu = 'hide';
                        });
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        size: 30,
                        color: Colors.white,
                      )),
                ],
              ),
              Divider(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  MyApi().NavigatorPushAnim(
                      context,
                      PageTransitionType.fade,
                      AccountDetail(
                        accID: accID!,
                        formpage: 'Acclist',
                      ));
                  setState(() {
                    slideMenu = 'hide';
                  });
                },
                child: Row(
                  children: [
                    MyStyle().showSizeTextSC(
                        context, ' ข้อมูลส่วนตัว', 22, Colors.white),
                  ],
                ),
              ),
              Divider(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  MyApi().askToLogout(context);
                  setState(() {
                    slideMenu = 'hide';
                  });
                },
                child: Row(
                  children: [
                    MyStyle().showSizeTextSC(
                        context, ' ออกจากระบบ', 22, Colors.white),
                  ],
                ),
              ),
              Divider(
                height: 30,
              ),
            ],
          ),
        ),
        Container(
          color: Color.fromARGB(94, 51, 51, 51),
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 1,
        )
      ],
    );
  }

  Container showMenu(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: type == 'user'
          ? GridView.count(
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                  btnReserveCar(context),
                  btnCheckIn(context),
                  btnTable(context),
                  btnCarList(context),
                ])
          : GridView.count(
              primary: false,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 3,
              children: <Widget>[
                  btnTable(context),
                  btnReserveCar(context),
                  btnCheckIn(context),
                  btnAccountList(context),
                  btnCarList(context),
                  btnVerify(context),
                  btnTickedSpeed(context),
                ]),
    );
  }

  Column showReturnCarBTN(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => ReturnCar());
            Navigator.push(context, route).then((value) {
              setState(() {
                getData();
              });
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            child: Stack(
              children: [
                Material(
                  color: Color.fromARGB(255, 255, 255, 255),
                  shadowColor: Colors.grey,
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 100,
                            height: 100,
                            child: Image.asset('images/car_running.gif')),
                        SizedBox(width: 20),
                        MyStyle().showSizeTextSC(context, 'คืนรถยนต์', 15,
                            const Color.fromARGB(255, 73, 73, 73))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyStyle().showSizeTextSC(
                          context,
                          'ไม่ควรเกินวันที่ ${MyStyle().dateTypeddmmyyyy(endDate)}   ',
                          30,
                          Color.fromARGB(255, 139, 139, 139)),
                      Icon(
                        Icons.offline_bolt,
                        size: 30,
                        color: Color.fromARGB(255, 162, 241, 166),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        showReturnCar == 'no' ? Container() : SizedBox(height: 10),
      ],
    );
  }

  Row showTextWelcome(BuildContext context) {
    return Row(
      children: [
        Text('ยินดีต้อนรับ $nickname',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 15,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  InkWell btnMyProfile(BuildContext context) {
    return InkWell(
      splashColor: Color.fromARGB(255, 69, 153, 48).withAlpha(30),
      onTap: () {
        MyApi().NavigatorPushAnim(
            context,
            PageTransitionType.fade,
            AccountDetail(
              accID: accID!,
              formpage: 'Acclist',
            ));
      },
      child: Material(
        color: Color.fromARGB(71, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: type == 'admin' ? 30 : 45,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showSizeTextSC(
                context, 'ผู้ใช้', type == 'admin' ? 25 : 18, Colors.white)
          ],
        ),
      ),
    );
  }

  InkWell btnTickedSpeed(BuildContext context) {
    return InkWell(
      splashColor: Color.fromARGB(255, 69, 153, 48).withAlpha(30),
      onTap: () {
        MyApi()
            .NavigatorPushAnim(context, PageTransitionType.fade, SpeedTicked());
      },
      child: Material(
        color: Color.fromARGB(71, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_copy,
              size: type == 'admin' ? 30 : 45,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showSizeTextSC(
                context, 'ใบสั่ง', type == 'admin' ? 25 : 18, Colors.white)
          ],
        ),
      ),
    );
  }

  InkWell btnVerify(BuildContext context) {
    return InkWell(
      splashColor: Color.fromARGB(255, 69, 153, 48).withAlpha(30),
      onTap: () {
        MyApi().NavigatorPushAnim(
            context, PageTransitionType.fade, AccountVerify());
      },
      child: Material(
        color: Color.fromARGB(71, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified,
              size: type == 'admin' ? 30 : 45,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showSizeTextSC(context, 'อนุมัติสิทธิ',
                type == 'admin' ? 25 : 19, Colors.white)
          ],
        ),
      ),
    );
  }

  InkWell btnCarList(BuildContext context) {
    return InkWell(
      splashColor: Color.fromARGB(255, 69, 153, 48).withAlpha(30),
      onTap: () {
        MyApi().NavigatorPushAnim(context, PageTransitionType.fade, CarList());
      },
      child: Material(
        color: Color.fromARGB(71, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.drive_eta,
              size: type == 'admin' ? 30 : 45,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showSizeTextSC(
                context, 'รถยนต์', type == 'admin' ? 25 : 18, Colors.white)
          ],
        ),
      ),
    );
  }

  InkWell btnTable(BuildContext context) {
    return InkWell(
      splashColor: Color.fromARGB(255, 69, 153, 48).withAlpha(30),
      onTap: () {
        MyApi().NavigatorPushAnim(
            context, PageTransitionType.fade, ReserveShowTable());
      },
      child: Material(
        color: Color.fromARGB(71, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month_rounded,
              size: type == 'admin' ? 30 : 45,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showSizeTextSC(
                context, 'ดูตารางจอง', type == 'admin' ? 25 : 18, Colors.white)
          ],
        ),
      ),
    );
  }

  InkWell btnAccountList(BuildContext context) {
    return InkWell(
      splashColor: Color.fromARGB(255, 69, 153, 48).withAlpha(30),
      onTap: () {
        MyApi()
            .NavigatorPushAnim(context, PageTransitionType.fade, AccountList());
      },
      child: Material(
        color: Color.fromARGB(71, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people,
              size: type == 'admin' ? 30 : 45,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showSizeTextSC(context, 'รายชื่อพนักงาน',
                type == 'admin' ? 25 : 18, Colors.white)
          ],
        ),
      ),
    );
  }

  InkWell btnCheckIn(BuildContext context) {
    return InkWell(
      splashColor: Color.fromARGB(255, 69, 153, 48).withAlpha(30),
      onTap: () {
        MaterialPageRoute route = showReturnCar == 'yes'
            ? MyPopup()
                .showError(context, 'กรุณากดคืนรถยนต์ที่กำลังใช้งานอยู่ก่อน')
            : MaterialPageRoute(builder: (context) => UsingWaiting());
        Navigator.push(context, route).then((value) {
          setState(() {
            getData();
          });
        });
      },
      child: Material(
        color: showReturnCar == 'yes'
            ? Color.fromARGB(47, 116, 116, 116)
            : Color.fromARGB(71, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.car_rental_rounded,
                    size: type == 'admin' ? 30 : 45,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  MyStyle().showSizeTextSC(
                      context,
                      checkstatus == 'yes'
                          ? '---'
                          : checkined == 'yes'
                              ? 'กำลังเช็คอิน'
                              : 'เช็คอิน',
                      type == 'admin' ? 25 : 18,
                      Colors.white)
                ],
              ),
            ),
            checkined == 'no'
                ? Container()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.offline_bolt,
                            size: 30,
                            color: Color.fromARGB(255, 162, 241, 166),
                          ),
                        )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  InkWell btnReserveCar(BuildContext context) {
    return InkWell(
      splashColor: Color.fromARGB(255, 69, 153, 48).withAlpha(30),
      onTap: () {
        MyApi().NavigatorPushAnim(
            context, PageTransitionType.fade, ReserveChooseDay());
      },
      child: Material(
        color: Color.fromARGB(71, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.car_crash_sharp,
              size: type == 'admin' ? 30 : 45,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showSizeTextSC(
                context, 'จองรถ', type == 'admin' ? 25 : 18, Colors.white)
          ],
        ),
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
                    setState(() {
                      slideMenu = 'show';
                    });
                  },
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.white,
                  ))),
          Expanded(
              flex: 3,
              child: Text(
                type == 'user' ? '$fullname' : 'Admin System',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontWeight: FontWeight.bold),
              )),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }

  Container showBlackground(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: Image.asset(
        'images/bg2.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
