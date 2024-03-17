import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:carpool/screen/reserve_add.dart';
import 'package:carpool/screen/reserve_result_search.dart';
import 'package:carpool/unity/my_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:carpool/models/car_model.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReserveChooseDay extends StatefulWidget {
  const ReserveChooseDay({super.key});

  @override
  State<ReserveChooseDay> createState() => _ReserveChooseDayState();
}

class _ReserveChooseDayState extends State<ReserveChooseDay> {
  String? fullname;
  String? loaddata = 'no';
  List<CarModel> carModels = [];
  List<String> chooseDay = [];
  String? today;
  String nodata = 'no';

  bool _visible = true;
  bool _isAnimated = false;

  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  Future<Null> getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      fullname = preferences.getString('Acc_Fullname')!;
    });
  }

  @override
  void initState() {
    checkToDay();
    getUserData();
    super.initState();
  }

  void checkToDay() async {
    var now = DateTime.now();
    var formatterDate = DateFormat('yyyy-MM-dd').format(now);
    setState(() {
      chooseDay.add(formatterDate);
    });
    print(chooseDay);
    print(chooseDay.length);
  }

  String? start, end;

  void getCarChooseDay() async {
    loaddata = 'yes';
    if (chooseDay.length == 1 ||
        chooseDay[1] == 'null' ||
        chooseDay[0] == chooseDay[1]) {
      setState(() {
        start = MyStyle().dateTypeYYYYMMDD(chooseDay[0]);
        end = MyStyle().dateTypeYYYYMMDD(chooseDay[0]);
      });
    } else {
      setState(() {
        start = MyStyle().dateTypeYYYYMMDD(chooseDay[0]);
        end = MyStyle().dateTypeYYYYMMDD(chooseDay[1]);
      });
    }

    print('เริ่ม : $start');
    print('สิ้นสุด : $end');

    // เตรียม URL สำหรับการส่งค่าไปยัง PHP
    var url =
        Uri.parse('${MyConstant().domain}/carpool/car/getCarChooseDay.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url,
      body: {'start': start, 'end': end},
    );

    print(response.body);

    if (response.body == 'ไม่พบรถที่ว่าง') {
      setState(() {
        loaddata = 'no';
        nodata = 'yes';
      });
    } else {
      var data = json.decode(response.body);

      try {
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
      } catch (e) {}
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
                Stack(
                  children: [
                    nodata == 'yes'
                        ? AnimatedOpacity(
                            opacity: !_visible ? 1.0 : 0.0,
                            duration: const Duration(seconds: 1),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('images/error.gif'),
                                  SizedBox(height: 30),
                                  MyStyle().showTextSCW(
                                      'ไม่มีรถพร้อมใช้ในวันนี้',
                                      25,
                                      FontWeight.bold,
                                      MyStyle().color1)
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 1,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 60, left: 15, right: 15, bottom: 1),
                          child: loaddata == 'yes'
                              ? MyPopup().showLoadData()
                              : AnimatedOpacity(
                                  opacity: _visible ? 1.0 : 0.0,
                                  duration: const Duration(seconds: 1),
                                  child: showcalendarchooseday(context))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: AnimatedPadding(
                          padding: EdgeInsets.only(
                              top: _isAnimated == true ? 0 : 1000),
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut,
                          child: showResultSearch()),
                    ),
                  ],
                ),
                showheadBar(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  SingleChildScrollView showResultSearch() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: carModels.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  // height: MediaQuery.of(context).size.height * 0.13,
                  child: Material(
                    color: Color.fromARGB(125, 255, 255, 255),
                    borderRadius: BorderRadius.circular(15),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () {
                        AddReserve().showFormReserve(
                            context,
                            '${carModels[index].carNumber}',
                            start == end ? '$start' : '$start - $end',
                            '$fullname');
                        print('${carModels[index].carID!}');
                        // MaterialPageRoute route = MaterialPageRoute(
                        //     builder: (context) => ReserveAdd(
                        //         // carID: '${carModels[index].carID}',
                        //         // carNumber: '${carModels[index].carNumber}',
                        //         // day: 'today',
                        //         ));
                        // Navigator.push(context, route).then((value) {
                        //   // carModels.clear();
                        //   // CarsLoadData();
                        //   setState(() {
                        //     // loaddata = 'yes';
                        //   });
                        // });
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
                                            image: AssetImage(carModels[index]
                                                        .carBrand! ==
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.43,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
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
                                            color: MyStyle().color2,
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
                                      Row(
                                        children: [
                                          Text('${carModels[index].carNumber!}',
                                              style: TextStyle(
                                                  fontSize: 27,
                                                  color: const Color.fromARGB(
                                                      255, 68, 68, 68))),
                                        ],
                                      ),
                                      // Expanded(
                                      //   child: Row(
                                      //     children: [
                                      //       Text(
                                      //           '${carModels[index].carBrand!}',
                                      //           style: TextStyle(
                                      //               fontSize: 20,
                                      //               fontWeight:
                                      //                   FontWeight.bold)),
                                      //     ],
                                      //   ),
                                      // ),
                                      // Expanded(
                                      //   child: Row(
                                      //     children: [
                                      //       Text(
                                      //           '${carModels[index].carModel!}',
                                      //           style: TextStyle(
                                      //               fontSize: 16,
                                      //               color: Color.fromARGB(
                                      //                   255, 151, 151, 151))),
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
                                    child: IconButton(
                                      tooltip: 'ดูรายละเอียด',
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.manage_search,
                                        size: 35,
                                        color: MyStyle().color1,
                                      ),
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
            }),
      ),
    );
  }

  Column showcalendarchooseday(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Material(
          color: Colors.white,
          shadowColor: Colors.white,
          elevation: 3,
          borderRadius: BorderRadius.circular(20),
          child: _buildDefaultRangeDatePickerWithValue(),
        ),
        SizedBox(height: 30),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 50,
          child: ElevatedButton.icon(
            label: Text(
              'ค้นหารถที่ว่าง',
              style: TextStyle(color: MyStyle().color1, fontSize: 20),
            ),
            icon: Icon(Icons.search_rounded, color: MyStyle().color1),
            onPressed: () {
              setState(() {
                _visible = !_visible;
                _isAnimated = !_isAnimated;
                nodata = 'no';
              });
              getCarChooseDay();

              // print('$code , $password');
            },
          ),
        ),
      ],
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
              print(_rangeDatePickerValueWithDefaultValue);
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
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

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
        chooseDay.clear();
        setState(() {
          chooseDay.add(startDate);
          chooseDay.add(endDate);
          // print(chooseDay);
        });
      } else {
        return 'null';
      }
    }

    return valueText;
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
                    !_visible
                        ? setState(() {
                            _visible = !_visible;
                            _isAnimated = !_isAnimated;
                            carModels.clear();
                            checkToDay();
                          })
                        : Navigator.pop(context);
                  },
                  icon: Icon(!_visible ? Icons.search : Icons.arrow_back_ios,
                      size: 30, color: Colors.white))),
          Expanded(
            flex: 4,
            child: Center(
              child: Stack(
                children: [
                  AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      'เลือกวันที่ทำการจอง',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: !_visible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      'รถยนต์ที่พร้อมใช้',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: IconButton(
                  tooltip: 'ตารางคิวการจอง',
                  onPressed: () {},
                  icon: Icon(Icons.calendar_month,
                      size: 30, color: Colors.white))),
        ],
      ),
    );
  }
}
