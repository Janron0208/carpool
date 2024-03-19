import 'package:carpool/screen/Speed_Ticked.dart';
import 'package:carpool/screen/account_list.dart';
import 'package:carpool/screen/account_verify.dart';
import 'package:carpool/screen/car_list.dart';
import 'package:carpool/screen/reserve_chooseday.dart';
import 'package:carpool/screen/using_waiting.dart';
import 'package:carpool/unity/my_api.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? type;
  Future<Null> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      fullname = preferences.getString('Acc_Fullname')!;
      nickname = preferences.getString('Acc_Nickname')!;
      type = preferences.getString('Acc_Type')!;
    });
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('ยินดีต้อนรับ $nickname',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 15,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: GridView.count(
                              primary: false,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              children: <Widget>[
                                InkWell(
                                  splashColor: Color.fromARGB(255, 69, 153, 48)
                                      .withAlpha(30),
                                  onTap: () {
                                    MyApi().NavigatorPushAnim(
                                        context,
                                        PageTransitionType.fade,
                                        ReserveChooseDay());
                                  },
                                  child: Material(
                                    color: Color.fromARGB(71, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_month_rounded,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'จองรถ',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Color.fromARGB(255, 69, 153, 48)
                                      .withAlpha(30),
                                  onTap: () {
                                    MyApi().NavigatorPushAnim(
                                        context,
                                        PageTransitionType.fade,
                                        UsingWaiting());
                                  },
                                  child: Material(
                                    color: Color.fromARGB(71, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.car_rental_rounded,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'กำลังใช้งาน',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Color.fromARGB(255, 69, 153, 48)
                                      .withAlpha(30),
                                  onTap: () {
                                    MyApi().NavigatorPushAnim(context,
                                        PageTransitionType.fade, AccountList());
                                  },
                                  child: Material(
                                    color: Color.fromARGB(71, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.people,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'รายชื่อผู้ใช้ระบบ',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Color.fromARGB(255, 69, 153, 48)
                                      .withAlpha(30),
                                  onTap: () {
                                    MyApi().NavigatorPushAnim(context,
                                        PageTransitionType.fade, CarList());
                                  },
                                  child: Material(
                                    color: Color.fromARGB(71, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.drive_eta,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'รถยนต์',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Color.fromARGB(255, 69, 153, 48)
                                      .withAlpha(30),
                                  onTap: () {
                                    MyApi().NavigatorPushAnim(
                                        context,
                                        PageTransitionType.fade,
                                        AccountVerify());
                                  },
                                  child: Material(
                                    color: Color.fromARGB(71, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.verified,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'อนุมัติสิทธิ',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Color.fromARGB(255, 69, 153, 48)
                                      .withAlpha(30),
                                  onTap: () {
                                    MyApi().NavigatorPushAnim(context,
                                        PageTransitionType.fade, SpeedTicked());
                                  },
                                  child: Material(
                                    color: Color.fromARGB(71, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.file_copy,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'ใบสั่ง',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ],
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

  // Scaffold(
  //   backgroundColor: const Color.fromARGB(255, 233, 233, 233),
  //   appBar: AppBar(
  //     title: Text('Admin System'),
  //   ),
  //   body: GridView.count(
  //     primary: false,
  //     padding: const EdgeInsets.all(15),
  //     crossAxisSpacing: 4,
  //     mainAxisSpacing: 4,
  //     crossAxisCount: 3,
  //     children: <Widget>[
  //       InkWell(
  //         splashColor: Color.fromARGB(255, 69, 153, 48).withAlpha(30),
  //         onTap: () {
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => AccountList(),
  //               ));
  //         },
  //         child: Card(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(Icons.people, size: 40),
  //               SizedBox(height: 10),
  //               Text(
  //                 'บัญชีผู้ใช้',
  //                 style: TextStyle(fontSize: 18),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //       InkWell(
  //         splashColor: Color.fromARGB(255, 69, 153, 48).withAlpha(30),
  //         onTap: () {},
  //         child: Card(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(Icons.drive_eta, size: 40),
  //               SizedBox(height: 10),
  //               Text(
  //                 'รายการรถยนต์',
  //                 style: TextStyle(fontSize: 18),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //       InkWell(
  //         splashColor: Color.fromARGB(255, 69, 153, 48).withAlpha(30),
  //         onTap: () {},
  //         child: Card(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(Icons.document_scanner, size: 40),
  //               SizedBox(height: 10),
  //               Text(
  //                 'Event Log',
  //                 style: TextStyle(fontSize: 18),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   ),
  // );

  //   Stack(
  //     children: [
  //       // bgImage(context),
  //       Container(
  //         child: Row(
  //           children: [
  //             Text('Admin System')
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Scaffold bgImage(BuildContext context) {
  //   return Scaffold(
  //       body: new Container(width: MediaQuery.of(context).size.width * 1,height: MediaQuery.of(context).size.height * 1,
  //         child: Image.asset('images/bg2.jpg',fit: BoxFit.cover,),
  //       ),
  //     );
  // }
}
