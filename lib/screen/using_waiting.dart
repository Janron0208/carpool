import 'dart:convert';
import 'package:carpool/models/reserve_car_model.dart';
import 'package:carpool/screen/using_checkin_mobile.dart';
import 'package:carpool/screen/using_checkin_web.dart';
import 'package:carpool/unity/my_api.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UsingWaiting extends StatefulWidget {
  const UsingWaiting({super.key});

  @override
  State<UsingWaiting> createState() => _UsingWaitingState();
}

class _UsingWaitingState extends State<UsingWaiting> {
  String? loaddata = 'yes';
  String? accID;
  List<ReserveCarModel> reservecarModels = [];

  String nodata = 'no';
  String h_status = 'no';

  @override
  void initState() {
    checkStatusUsing();

    super.initState();
  }

  Future<Null> checkStatusUsing() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    accID = preferences.getString('Acc_ID')!;
    var url = Uri.parse(
        '${MyConstant().domain}/carpool/history/getHistoryByAccIDAndStatus.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url,
      body: {'Acc_ID': accID, 'H_Status': "started"},
    );

    if (response.body == '[]') {
      checkReserveByAccID();
    } else {
      setState(() {
        h_status = 'yes';
        loaddata = 'no';
      });
    }
  }

  Future<Null> checkReserveByAccID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    accID = preferences.getString('Acc_ID')!;
    print(accID);

    var url = Uri.parse(
        '${MyConstant().domain}/carpool/reserve/getAllReserveSyncCarByAccID.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url,
      body: {'Acc_ID': accID},
    );

    // print(response.body);

    if (response.body == '[]') {
      setState(() {
        loaddata = 'no';
        nodata = 'yes';
      });
    } else {
      setState(() {
        var data = json.decode(response.body);

        try {
          for (var item in data) {
            ReserveCarModel reservecarModel = ReserveCarModel.fromJson(item);
            setState(() {
              reservecarModels.add(reservecarModel);
              print(reservecarModel.resID);
              // print(reservecarModels.length);
              nodata = 'no';
            });
            setState(() {
              loaddata = 'no';
            });
          }
        } catch (e) {}
      });
    }
    print('h_status = $h_status');
  }

  @override
  Widget build(BuildContext context) {
    return h_status == 'yes'
        ? kIsWeb
            ? UsingCheckInWeb()
            : UsingCheckInMobile()
        : Scaffold(
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
                                      top: 70, left: 10, right: 10, bottom: 10),
                                  child: Material(
                                    color: const Color.fromARGB(
                                        139, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(15),
                                    child: nodata == 'yes'
                                        ? Center(
                                            child: MyStyle().showSizeTextSC(
                                                context,
                                                'ยังไม่มีการจอง',
                                                16,
                                                MyStyle().color1),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 13, right: 13, top: 10),
                                            child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    reservecarModels.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Column(
                                                    children: [
                                                      reservecarModels[0]
                                                                  .resID ==
                                                              reservecarModels[
                                                                      index]
                                                                  .resID
                                                          ? Column(
                                                              children: [
                                                                MyStyle()
                                                                    .showSizeTextS(
                                                                        context,
                                                                        'รถยนต์ที่จองไว้',
                                                                        20),
                                                                MyStyle()
                                                                    .showSizeTextS(
                                                                        context,
                                                                        '( Check In รถที่ใช้งานเร็วๆนี้ก่อนเท่านั้น )',
                                                                        28),
                                                                SizedBox(
                                                                    height: 5),
                                                              ],
                                                            )
                                                          : Container(),
                                                      SizedBox(height: 5),
                                                      Stack(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              reservecarModels[0]
                                                                          .resID ==
                                                                      reservecarModels[
                                                                              index]
                                                                          .resID
                                                                  ? showDialog<
                                                                      String>(
                                                                      context:
                                                                          context,
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          AlertDialog(
                                                                        title: Text(
                                                                            'เริ่มใช้งาน?'),
                                                                        content: MyStyle().showSizeTextSC(
                                                                            context,
                                                                            'คุณพร้อมใช้งานรถยนต์ทะเบียน ${reservecarModels[index].carNumber} แล้วหรือไม่',
                                                                            21,
                                                                            MyStyle().color3),
                                                                        actions: <Widget>[
                                                                          TextButton(
                                                                              onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                              child: MyStyle().showSizeTextSC(context, 'ปิด', 20, Color.fromARGB(255, 244, 54, 54))),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              checkValue(index);
                                                                            },
                                                                            child: MyStyle().showSizeTextSC(
                                                                                context,
                                                                                'CheckIn Now',
                                                                                20,
                                                                                Color.fromARGB(255, 46, 226, 76)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : MyPopup()
                                                                      .showToastError(
                                                                          context,
                                                                          'Check In คิวแรกเท่านั้น');
                                                            },
                                                            child: Material(
                                                              color: reservecarModels[
                                                                              0]
                                                                          .resID ==
                                                                      reservecarModels[
                                                                              index]
                                                                          .resID
                                                                  ? Color
                                                                      .fromARGB(
                                                                          206,
                                                                          226,
                                                                          239,
                                                                          255)
                                                                  : Color
                                                                      .fromARGB(
                                                                          68,
                                                                          189,
                                                                          189,
                                                                          189),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8),
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            15),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: MyStyle().showSizeTextSC(
                                                                              context,
                                                                              reservecarModels[index].resStartDate == reservecarModels[index].resEndDate ? 'วันที่ ${MyStyle().dateTypeddmmyyyy('${reservecarModels[index].resStartDate}')}' : 'วันที่ ${MyStyle().dateTypeddmmyyyy('${reservecarModels[index].resStartDate}')} - ${MyStyle().dateTypeddmmyyyy('${reservecarModels[index].resEndDate}')}',
                                                                              22,
                                                                              MyStyle().color1),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: MyStyle().showSizeTextSC(
                                                                              context,
                                                                              'ทะเบียนรถ : ${reservecarModels[index].carNumber}',
                                                                              23,
                                                                              MyStyle().color3),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child: MyStyle().showSizeTextSC(
                                                                              context,
                                                                              'โปรเจค/สถานที่ : ${reservecarModels[index].resProject}',
                                                                              23,
                                                                              MyStyle().color3),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            15),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    showDialog<
                                                                        String>(
                                                                      context:
                                                                          context,
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          AlertDialog(
                                                                        title: const Text(
                                                                            'ยกเลิกการจองรถ?'),
                                                                        content:
                                                                            const Text('คุณต้องการยกเลิกการจองรถใช่หรือไม่'),
                                                                        actions: <Widget>[
                                                                          TextButton(
                                                                              onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                              child: MyStyle().showSizeTextSC(context, 'ปิด', 20, const Color.fromARGB(255, 54, 130, 244))),
                                                                          TextButton(
                                                                              onPressed: () => deleteReserve(index),
                                                                              child: MyStyle().showSizeTextSC(context, 'ยกเลิกการจอง', 20, Colors.red)),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                  icon: Icon(
                                                                    Icons
                                                                        .cancel_rounded,
                                                                    size: 20,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            175,
                                                                            63,
                                                                            55),
                                                                  )),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          ),
                                  ))),
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
              child: Text(
                'คิวที่จอง',
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

  Future<Null> deleteReserve(index) async {
    var url =
        Uri.parse('${MyConstant().domain}/carpool/reserve/deleteReserve.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url,
      body: {
        'Res_ID': '${reservecarModels[index].resID}',
      },
    );
    print(reservecarModels[index].resID);
    setState(() {
      Navigator.pop(context);
      MyApi().insertLogEvent(
          'ยกเลิกการจองรถทะเบียน ${reservecarModels[index].carNumber}');
      reservecarModels.clear();
      loaddata = 'yes';
      checkReserveByAccID();

      MyPopup().showToast(context, 'ยกเลิกการจองสำเร็จ');
    });
  }

  Future<Null> checkValue(index) async {
    print('Acc ID : ${reservecarModels[index].accID}');
    print('รหัสการจอง : ${reservecarModels[index].resID}');
    print('CAR ID : ${reservecarModels[index].carID}');
    var now = DateTime.now();
    var formatterDate = DateFormat('yyyyMMddHHmmss').format(now);
    String h_id = 'H${formatterDate}';

    print('History : $h_id');

    var url =
        Uri.parse('${MyConstant().domain}/carpool/history/insertHistory.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url,
      body: {
        'H_ID': '$h_id',
        'Acc_ID': '$accID',
        'Car_ID': '${reservecarModels[index].carID}',
        'H_StartDate': '${reservecarModels[index].resStartDate}',
        'H_EndDate': '${reservecarModels[index].resEndDate}',
        'H_Project': '${reservecarModels[index].resProject}',
        'H_MileageStart': '${reservecarModels[index].carMileage}',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        Navigator.pop(context);
        loaddata = 'yes';
        checkStatusUsing();
        MyApi().insertLogEvent(
            'ทำการ Check In ทะเบียน ${reservecarModels[index].carNumber}');
        MyPopup().showToast(context, 'Check In');
      });
    } else {
      // Error
      print('Error');
    }
  }
}
