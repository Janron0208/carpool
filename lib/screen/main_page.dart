import 'dart:convert';
import 'package:carpool/models/car_model.dart';
import 'package:carpool/models/history_model.dart';
import 'package:carpool/screen/Speed_Ticked.dart';
import 'package:carpool/screen/account_detail.dart';
import 'package:carpool/screen/account_list.dart';
import 'package:carpool/screen/account_verify.dart';
import 'package:carpool/screen/car_list.dart';
import 'package:carpool/screen/reserve_chooseday.dart';
import 'package:carpool/screen/reserve_showtable.dart';
import 'package:carpool/screen/return_car.dart';
import 'package:carpool/screen/using_waiting.dart';
import 'package:carpool/unity/my_api.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  String reloadChartAndData = 'yes';
  int? waitCar, runCar, reserveCar;
  double? perCar;

  Future<Null> getDatareloadChartAndData() async {
    var url = Uri.parse(
        '${MyConstant().domain}/carpool/system/getHistoryByStatus.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(url);
    var data = json.decode(response.body);
    List<HistoryModel> historyModels = [];
    for (var item in data) {
      HistoryModel historyModel = HistoryModel.fromJson(item);
      setState(() {
        historyModels.add(historyModel);
        runCar = historyModels.length;
      });
    }

    getCarChooseDay();
  }

  void getCarChooseDay() async {
    List<CarModel> carModels = [];
    List<CarModel> allcarModels = [];
    List<String> chooseDay = [];
    var now = DateTime.now();
    var today = DateFormat('yyyyMMdd').format(now);

    // เตรียม URL สำหรับการส่งค่าไปยัง PHP
    var url =
        Uri.parse('${MyConstant().domain}/carpool/car/getCarChooseDay.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url,
      body: {'start': today, 'end': today},
    );

    // print(response.body);

    if (response.body == '[]') {
      setState(() {});
    } else {
      var data = json.decode(response.body);

      try {
        for (var item in data) {
          CarModel carModel = CarModel.fromJson(item);
          setState(() {
            carModels.add(carModel);
            waitCar = carModels.length;
          });
          setState(() {});
        }
      } catch (e) {}

      final url1 =
          await Uri.parse('${MyConstant().domain}/carpool/car/getAllCar.php');

      http.Response response1 = await http.get(url1);

      var data1 = json.decode(response1.body);

      for (var item in data1) {
        CarModel carModel = CarModel.fromJson(item);
        setState(() {
          allcarModels.add(carModel);
        });
      }

      setState(() {
        reserveCar = (allcarModels.length - (runCar! + waitCar!));
        perCar = (100 / allcarModels.length);
        reloadChartAndData = 'no';
      });
    }
  }

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
  int touchedIndex = -1;
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
    getDatareloadChartAndData();
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 40.0 : 20.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.white, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red[200],
            value: runCar == null ? 0 : perCar! * runCar!,
            title: runCar == null ? '0' : '$runCar',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.red,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green[200],
            value: waitCar == null ? 0 : perCar! * waitCar!,
            title: waitCar == null ? '0' : '$waitCar',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Color.fromARGB(255, 253, 222, 118),
            value: reserveCar == null ? 0 : perCar! * reserveCar!,
            title: reserveCar == null ? '0' : '$reserveCar',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 192, 135, 51),
              shadows: shadows,
            ),
          );

        default:
          throw Error();
      }
    });
  }

  Future<Null> loadDashBoard() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(214, 94, 134, 243),
        actions: [
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          slideMenu = slideMenu == 'show' ? 'hide' : 'show';
                        });
                      },
                      icon: Icon(
                        slideMenu == 'show' ? Icons.arrow_back : Icons.menu,
                        size: 30,
                        color: Colors.white,
                      )),
                ],
              )),
          Expanded(
              flex: 3,
              child: Text(
                type == 'user' ? '$fullname' : 'Admin System ($nickname)',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontWeight: FontWeight.bold),
              )),
          Expanded(flex: 1, child: Container()),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              showBlackground(context),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 1,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 25, right: 25, bottom: 0),
                  child: Column(
                    children: [
                      type == 'admin'
                          ? Column(
                              children: [
                                showChart(),
                                SizedBox(height: 10),
                                // Row(
                                //   children: [
                                //     Expanded(
                                //         child: Material(
                                //       color: Color.fromARGB(71, 255, 255, 255),
                                //       borderRadius: BorderRadius.circular(10),
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(10),
                                //         child: Row(
                                //           children: [
                                //             MyStyle().showSizeTextSC(
                                //                 context,
                                //                 reloadChartAndData == 'yes'
                                //                     ? '-'
                                //                     : 'เกินเวลาคืน 8 คัน',
                                //                 28,
                                //                 Colors.white),
                                //             Spacer(),
                                //             IconButton(
                                //                 onPressed: () {},
                                //                 icon: Icon(
                                //                   Icons
                                //                       .arrow_forward_ios_rounded,
                                //                   color: Colors.white,
                                //                 ))
                                //           ],
                                //         ),
                                //       ),
                                //     )),
                                //     SizedBox(width: 10),
                                //     Expanded(
                                //       child: Expanded(
                                //           child: Material(
                                //         color:
                                //             Color.fromARGB(71, 255, 255, 255),
                                //         borderRadius: BorderRadius.circular(10),
                                //         child: Padding(
                                //           padding: const EdgeInsets.all(10),
                                //           child: Row(
                                //             children: [
                                //               MyStyle().showSizeTextSC(context,
                                //                   '-', 26, Colors.white),
                                //               Spacer(),
                                //               IconButton(
                                //                   onPressed: () {},
                                //                   icon: Icon(
                                //                     Icons
                                //                         .arrow_forward_ios_rounded,
                                //                     color: Colors.white,
                                //                   ))
                                //             ],
                                //           ),
                                //         ),
                                //       )),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(height: 10),
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
              slideMenu == 'hide' ? Container() : showSlideMenu(context)
            ],
          ),
        ),
      ),
    );
  }

  Stack showChart() {
    return Stack(
      children: [
        reloadChartAndData == 'yes'
            ? Container()
            : Material(
                color: Color.fromARGB(71, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: AspectRatio(
                        aspectRatio: 2,
                        child: Row(
                          children: <Widget>[
                            const SizedBox(
                              height: 18,
                            ),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 0.5,
                                child: PieChart(
                                  PieChartData(
                                    pieTouchData: PieTouchData(
                                      touchCallback: (FlTouchEvent event,
                                          pieTouchResponse) {
                                        setState(() {
                                          if (!event
                                                  .isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection ==
                                                  null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                        });
                                      },
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40,
                                    sections: showingSections(),
                                  ),
                                ),
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Icon(Icons.square,
                                        color:
                                            Color.fromARGB(255, 221, 129, 122),
                                        size: 16),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'กำลังใช้',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 221, 129, 122),
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.square,
                                        color:
                                            Color.fromARGB(255, 221, 186, 122),
                                        size: 16),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'จองวันนี้',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 196, 160, 94),
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.square,
                                        color:
                                            Color.fromARGB(255, 113, 194, 125),
                                        size: 16),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'ว่างวันนี้',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 73, 133, 82),
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                reloadChartAndData = 'yes';
                                getDatareloadChartAndData();
                              });
                            },
                            icon: Icon(Icons.replay_outlined)),
                      ],
                    )
                  ],
                ),
              ),
        reloadChartAndData == 'no'
            ? Container()
            : Material(
                color: Color.fromARGB(115, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: AspectRatio(
                    aspectRatio: 1.9,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: const Color.fromARGB(255, 33, 89, 243),
                      ),
                    ),
                  ),
                ))
      ],
    );
  }

  Row showSlideMenu(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 1,
          color: Color.fromARGB(214, 94, 134, 243),
          child: Column(
            children: [
              SizedBox(height: 15),
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
              // Spacer(),
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
          width: MediaQuery.of(context).size.width * 0.55,
          height: MediaQuery.of(context).size.height * 1,
        )
      ],
    );
  }

  Container showMenu(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.55,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            width: 100,
                            height: 100,
                            child: Image.asset('images/car_running.gif')),
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
                          'ไม่ควรเกินวันที่ ${MyStyle().dateTypeddmmyyyy(endDate)} ',
                          30,
                          Color.fromARGB(255, 139, 139, 139)),
                      Icon(
                        Icons.timelapse_rounded,
                        size: 30,
                        color: Color.fromARGB(255, 241, 165, 162),
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

  Material btnTickedSpeed(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Color.fromARGB(71, 255, 255, 255),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          MyApi().NavigatorPushAnim(
              context, PageTransitionType.fade, SpeedTicked());
        },
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

  Material btnVerify(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Color.fromARGB(71, 255, 255, 255),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          MyApi().NavigatorPushAnim(
              context, PageTransitionType.fade, AccountVerify());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified,
              size: type == 'admin' ? 30 : 45,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showSizeTextSC(context, 'อนุมัติสิทธิ์',
                type == 'admin' ? 25 : 19, Colors.white)
          ],
        ),
      ),
    );
  }

  Material btnCarList(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Color.fromARGB(71, 255, 255, 255),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          MyApi()
              .NavigatorPushAnim(context, PageTransitionType.fade, CarList());
        },
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

  Material btnTable(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Color.fromARGB(71, 255, 255, 255),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          MyApi().NavigatorPushAnim(
              context, PageTransitionType.fade, ReserveShowTable());
        },
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

  Material btnAccountList(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Color.fromARGB(71, 255, 255, 255),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          MyApi().NavigatorPushAnim(
              context, PageTransitionType.fade, AccountList());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people,
              size: type == 'admin' ? 30 : 45,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            MyStyle().showSizeTextSC(
                context, 'รายชื่อ', type == 'admin' ? 24 : 18, Colors.white)
          ],
        ),
      ),
    );
  }

  Material btnCheckIn(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: showReturnCar == 'yes'
          ? Color.fromARGB(47, 116, 116, 116)
          : Color.fromARGB(71, 255, 255, 255),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
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

  Material btnReserveCar(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Color.fromARGB(71, 255, 255, 255),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (context) => ReserveChooseDay());
          Navigator.push(context, route).then((value) {
            setState(() {
              getData();
            });
          });
        },
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
      height: 0,
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
