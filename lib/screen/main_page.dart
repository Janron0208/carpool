import 'package:carpool/screen/Speed_Ticked.dart';
import 'package:carpool/screen/account_detail.dart';
import 'package:carpool/screen/account_list.dart';
import 'package:carpool/screen/account_verify.dart';
import 'package:carpool/screen/car_list.dart';
import 'package:carpool/screen/reserve_chooseday.dart';
import 'package:carpool/screen/using_waiting.dart';
import 'package:carpool/unity/my_api.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          showBlackground(context),
          SafeArea(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 60, left: 25, right: 25, bottom: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('ยินดีต้อนรับ $nickname',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.81,
                            child: type == 'user'
                                ? GridView.count(
                                    primary: false,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2,
                                    children: <Widget>[
                                        btnReserveCar(context),
                                        btnCheckIn(context),
                                        btnCarList(context),
                                        btnMyProfile(context),
                                      ])
                                : GridView.count(
                                    primary: false,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2,
                                    children: <Widget>[
                                        btnReserveCar(context),
                                        btnCheckIn(context),
                                        btnAccountList(context),
                                        btnCarList(context),
                                        btnVerify(context),
                                        btnTickedSpeed(context),
                                        btnMyProfile(context),
                                      ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                showheadBar(context),
              ],
            ),
          )
        ],
      ),
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
              size: MediaQuery.of(context).size.width / 8,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showTextSC(context, 'ผู้ใช้', 18, Colors.white)
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
              size: MediaQuery.of(context).size.width / 8,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showTextSC(context, 'ใบสั่ง', 18, Colors.white)
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
              size: MediaQuery.of(context).size.width / 8,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showTextSC(context, 'อนุมัติสิทธิ', 19, Colors.white)
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
              size: MediaQuery.of(context).size.width / 8,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showTextSC(context, 'รถยนต์', 18, Colors.white)
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
              size: MediaQuery.of(context).size.width / 8,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showTextSC(context, 'รายชื่อพนักงาน', 23, Colors.white)
          ],
        ),
      ),
    );
  }

  InkWell btnCheckIn(BuildContext context) {
    return InkWell(
      splashColor: Color.fromARGB(255, 69, 153, 48).withAlpha(30),
      onTap: () {
        MyApi().NavigatorPushAnim(
            context, PageTransitionType.fade, UsingWaiting());
      },
      child: Material(
        color: Color.fromARGB(71, 255, 255, 255),
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
                    size: MediaQuery.of(context).size.width / 8,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  MyStyle().showTextSC(
                      context,
                      checkstatus == 'yes'
                          ? '---'
                          : checkined == 'yes'
                              ? 'กำลังใช้งาน'
                              : 'Check In',
                      20,
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
              Icons.calendar_month_rounded,
              size: MediaQuery.of(context).size.width / 8,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showTextSC(context, 'จองรถ', 18, Colors.white)
          ],
        ),
      ),
    );
  }

  Container showheadBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 50,
      child: Row(
        children: [
          Expanded(flex: 1, child: Container()),
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
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    MyApi().askToLogout(context);
                  },
                  icon: Icon(
                    Icons.power_settings_new_rounded,
                    size: 30,
                    color: Colors.red,
                  ))),
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
