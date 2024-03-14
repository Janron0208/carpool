import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpool/sharedscreen/car_detail.dart';
import 'package:carpool/sharedscreen/reserve_add.dart';
import 'package:carpool/unity/my_api.dart';
import 'package:http/http.dart' as http;
import 'package:carpool/models/car_model.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class ReserveMenu extends StatefulWidget {
  const ReserveMenu({super.key});

  @override
  State<ReserveMenu> createState() => _ReserveMenuState();
}

class _ReserveMenuState extends State<ReserveMenu> {
  String? loaddata = 'yes';
  String? headBarText = 'ใช้งานวันนี้';
  List<CarModel> carModels = [];
  List<String> chooseDay = [];

  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  @override
  void initState() {
    checkheadBarText();
    super.initState();
  }

  void checkheadBarText() async {
    if (headBarText == 'ใช้งานวันนี้') {
      loadCarStatusByReady();
    } else {}
  }

  void loadCarStatusByReady() async {
    final url = await Uri.parse(
        '${MyConstant().domain}/carpool/car/getCarLikeStatus.php?Car_Status=Ready');

    http.Response response = await http.get(url);

    var data = json.decode(response.body);

    for (var item in data) {
      CarModel carModel = CarModel.fromJson(item);
      setState(() {
        carModels.add(carModel);

        print(carModels.length);
      });

      setState(() {
        loaddata = 'no';
      });
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MyStyle().BG_Image(context, 'bg2.jpg'),
          SafeArea(
            child: Stack(
              children: [
                loaddata == 'yes'
                    ? MyPopup().showLoadData()
                    : Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: MediaQuery.of(context).size.height * 1,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 60, left: 15, right: 15, bottom: 1),
                            child: SingleChildScrollView(
                              child: headBarText != 'ใช้งานวันนี้'
                                  ? Column(
                                      children: [
                                        // Container(
                                        //   width: MediaQuery.of(context)
                                        //           .size
                                        //           .width *
                                        //       1,
                                        //   height: 50,
                                        //   child: Material(
                                        //       borderRadius:
                                        //           BorderRadius.circular(15),
                                        //       child: Center(
                                        //         child: MyStyle().showTextSCW(
                                        //             chooseDay[1] == 'null'
                                        //                 ? 'เลือกวันที่ : ${chooseDay[0]}'
                                        //                 : '${chooseDay[0]} - ${chooseDay[1]}',
                                        //             14,
                                        //             FontWeight.normal,
                                        //             MyStyle().color2),
                                        //       )),
                                        // ),
                                        SizedBox(height: 10),
                                        Material(
                                          color: Colors.white,
                                          shadowColor: Colors.white,
                                          elevation: 3,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child:
                                              _buildDefaultRangeDatePickerWithValue(),
                                        ),
                                        SizedBox(height: 30),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          height: 50,
                                          child: ElevatedButton.icon(
                                            label: Text(
                                              'ค้นหารถที่ว่าง',
                                              style: TextStyle(
                                                  color: MyStyle().color1,
                                                  fontSize: 20),
                                            ),
                                            icon: Icon(Icons.search_rounded,
                                                color: MyStyle().color1),
                                            onPressed: () {
                                              checkCountDay();
                                              MyApi().NavigatorPushAnim(
                                                  context,
                                                  PageTransitionType.fade,
                                                  ReserveAdd());

                                              // print('$code , $password');
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : showContentUseToday(),
                            )),
                      ),
                showheadBar(context),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 3,
        selectedFontSize: 15,
        iconSize: 20,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.car_crash),
            label: 'จองด่วน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'จองรถล่วงหน้า',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyStyle().color1,
        onTap: (value) {
          _onItemTapped(value);
          print(value);
          setState(() {
            if (value == 0) {
              headBarText = 'ใช้งานวันนี้';
              carModels.clear();
              checkheadBarText();
              loaddata = 'yes';
            } else {
              headBarText = 'จองรถล่วงหน้า';
            }
          });
        },
      ),
    );
  }

  Widget _buildDefaultRangeDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: MyStyle().color1,
      weekdayLabelTextStyle: TextStyle(
        color: MyStyle().color1,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: TextStyle(
        color: MyStyle().color1,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        CalendarDatePicker2(
          config: config,
          value: _rangeDatePickerValueWithDefaultValue,
          onValueChanged: (dates) {
            setState(() {
              _rangeDatePickerValueWithDefaultValue = dates;
            });
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(width: 10),
            Text(
              _getValueText(
                config.calendarType,
                _rangeDatePickerValueWithDefaultValue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String formatDate(String? string) {
    // แปลง String เป็น DateTime
    DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse('$string!');

    // แปลง DateTime เป็น String รูปแบบ dd-MM-yyyy
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    // แสดงผลลัพธ์
    return formattedDate; // 12-03-2024
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        String startDate = values[0].toString().split(
              ' ',
            )[0];
        String endDate =
            values.length > 1 ? values[1].toString().split(' ')[0] : 'null';
        valueText = '';
        setState(() {
          chooseDay.clear();
          chooseDay.add(startDate);
          chooseDay.add(endDate);
        });
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  ListView showContentUseToday() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: carModels.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Material(
                color: Color.fromARGB(125, 255, 255, 255),
                borderRadius: BorderRadius.circular(15),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: () {
                    print('${carModels[index].carID!}');

                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => CarDetail(
                              carID: '${carModels[index].carID}',
                              carNumber: '${carModels[index].carNumber}',
                              day: 'today',
                            ));
                    Navigator.push(context, route).then((value) {
                      // carModels.clear();
                      // CarsLoadData();
                      setState(() {
                        // loaddata = 'yes';
                      });
                    });
                  },
                  child: SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AspectRatio(
                              aspectRatio: 487 / 451,
                              child: Container(
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        alignment: FractionalOffset.center,
                                        image: AssetImage(
                                            carModels[index].carBrand! ==
                                                    'TOYOTA'
                                                ? 'images/logo_toyota.png'
                                                : 'images/logo_isuzu.png'))),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, top: 3, bottom: 5),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text('${carModels[index].carBrand!}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text('${carModels[index].carModel!}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 151, 151, 151))),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.23,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          color: const Color.fromARGB(
                                              255, 167, 216, 255),
                                          child: Center(
                                            child: Text('ป้ายทะเบียน',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text('${carModels[index].carNumber!}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: const Color.fromARGB(
                                                    255, 68, 68, 68))),
                                      ],
                                    ),
                                  ),

                                  // Spacer(),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 20),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.end,
                                  //     children: [
                                  //       Text('สถานะรถวันนี้ : ',
                                  //           style: TextStyle(
                                  //               fontSize: 15,
                                  //               color: Color.fromARGB(
                                  //                   255, 151, 151, 151))),
                                  //       Text('ไม่ว่าง',
                                  //           style: TextStyle(
                                  //               fontSize: 16,
                                  //               color:  Colors.red[900])),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.wifi,
                                  size: 25,
                                  color: Color.fromARGB(255, 52, 241, 67),
                                ),
                              ),
                              // IconButton(
                              //     onPressed: () {
                              //       print(
                              //           '${carModels[index].carID!}');
                              //     },
                              //     icon: Icon(
                              //       Icons
                              //           .delete_forever,
                              //       color: Color
                              //           .fromARGB(
                              //               255,
                              //               218,
                              //               107,
                              //               99),
                              //       size: 35,
                              //     ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Container showheadBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 50,
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
              child: Text(
                headBarText!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              )),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }

  Future<Null> checkCountDay() async {
    // String startDate = chooseDay[0].substring(0, 4) +
    //     chooseDay[0].substring(5, 7) +
    //     chooseDay[0].substring(8, 10);
    // String endDate = chooseDay[1].substring(0, 4) +
    //     chooseDay[1].substring(5, 7) +
    //     chooseDay[1].substring(8, 10);

    if (chooseDay[1] == 'null') {
      print('เลือก 1 วัน');
    } else {
      print('เลือกหลายวัน');

      // DateTime startDateTime = DateTime.parse(startDate);
      // DateTime endDateTime = DateTime.parse(endDate);

// // คำนวณจำนวนวัน
//       int totalDays = endDateTime.difference(startDateTime).inDays + 1;

// // สร้าง List เก็บวันที่
//       dayReserve.clear();
//       for (int i = 0; i < totalDays; i++) {
//         setState(() {
//           dayReserve.add(startDateTime.add(Duration(days: i)));
//         });
//       }

// // แสดงรายการวันที่
//       for (DateTime dayA in dayReserve) {
//         print(dayA.toIso8601String().toString().split('T00:00:00.000')[0]);
//       }
//       print(dayReserve);
//     }

      // String startDate = '13032024' //คือวันที่ 13/03/2024
      //   String endDate = '20032024'  // คือวันที่ 20/03/2024

      //  Dart ทำการนับวันที่  startDate ถึง endDate ว่ามีกี่วัน และนำมา for และนำมาใส่ใน List ชื่อว่า dayReserve
    }
  }
}
