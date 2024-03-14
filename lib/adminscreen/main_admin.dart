import 'package:carpool/adminscreen/Speed_Ticked.dart';
import 'package:carpool/adminscreen/account_list.dart';
import 'package:carpool/adminscreen/account_verify.dart';
import 'package:carpool/adminscreen/car_list.dart';
import 'package:carpool/sharedscreen/reserve_menu.dart';
import 'package:carpool/unity/my_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainAdmin extends StatefulWidget {
  const MainAdmin({super.key});

  @override
  State<MainAdmin> createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin> {
  
  @override
  void initState() {
    getData();
    super.initState();
  }
  String nickname = ' ';
  Future<Null> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nickname = preferences.getString('Acc_Nickname')!;
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
                                    fontSize: 30,
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
                                          size: 60,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'รายชื่อผู้ใช้ระบบ',
                                          style: TextStyle(
                                              fontSize: 18,
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
                                          size: 60,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'รถยนต์',
                                          style: TextStyle(
                                              fontSize: 20,
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
                                          size: 60,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'อนุมัติสิทธิ',
                                          style: TextStyle(
                                              fontSize: 20,
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
                                          size: 60,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'ใบสั่ง',
                                          style: TextStyle(
                                              fontSize: 20,
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
                                        PageTransitionType.fade, ReserveMenu());
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
                                          size: 60,
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'จองรถ',
                                          style: TextStyle(
                                              fontSize: 20,
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
                'Admin System',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
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
