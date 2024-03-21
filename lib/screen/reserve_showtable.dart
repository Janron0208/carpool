import 'dart:convert';

import 'package:carpool/models/car_model.dart';
import 'package:carpool/models/reserve_account_model.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ReserveShowTable extends StatefulWidget {
  const ReserveShowTable({super.key});

  @override
  State<ReserveShowTable> createState() => _ReserveShowTableState();
}

class _ReserveShowTableState extends State<ReserveShowTable> {
  String? loaddata = 'yes';
  List<ReserveAccountModel> reserveaccModels = [];
  List<CarModel> carModels = [];

  @override
  void initState() {
    loadAllCar();
    super.initState();
  }

  void loadAllCar() async {
    final url =
        await Uri.parse('${MyConstant().domain}/carpool/car/getAllCar.php');

    http.Response response = await http.get(url);

    var data = json.decode(response.body);

    for (var item in data) {
      CarModel carModel = CarModel.fromJson(item);
      setState(() {
        carModels.add(carModel);
      });
    }
    loadAllReserveAccount();
  }

  void loadAllReserveAccount() async {
    final url = await Uri.parse(
        '${MyConstant().domain}/carpool/reserve/getAllReserveSyncAccount.php');

    http.Response response = await http.get(url);

    var data = json.decode(response.body);

    for (var item in data) {
      ReserveAccountModel reseraccveModel = ReserveAccountModel.fromJson(item);
      setState(() {
        reserveaccModels.add(reseraccveModel);
      });
    }
    setState(() {
      loaddata = 'no';
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
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 60, left: 10, right: 10, bottom: 10),
                      child: loaddata == 'yes'
                          ? MyPopup().showLoadData()
                          : SingleChildScrollView(
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: carModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final carID = carModels[index].carID;
                                    return Column(
                                      children: [
                                        Material(
                                          color: Color.fromARGB(
                                              148, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    MyStyle().showTextSC(
                                                        context,
                                                        '${carModels[index].carNumber}',
                                                        12,
                                                        MyStyle().color1),
                                                    carModels[index]
                                                                .carStatus ==
                                                            'No'
                                                        ? Icon(
                                                            Icons
                                                                .not_interested,
                                                            color: Colors.red,
                                                          )
                                                        : Text(''),
                                                    Spacer(),
                                                    // MyStyle().showTextSC(
                                                    //     context,
                                                    //     'เลขไมล์ล่าสุด : ',
                                                    //     28,
                                                    //     MyStyle().color3),
                                                    MyStyle().showTextNumberSC(
                                                        context,
                                                        '${carModels[index].carMileage}',
                                                        23,
                                                        MyStyle().color1),
                                                    MyStyle().showTextSC(
                                                        context,
                                                        ' Km.',
                                                        23,
                                                        MyStyle().color1)
                                                  ],
                                                ),
                                                ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        reserveaccModels.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      int _currentIndex = 0;

                                                      return Column(children: [
                                                        reserveaccModels[index]
                                                                    .carID !=
                                                                carID
                                                            ? Container()
                                                            : Material(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    218,
                                                                    255,
                                                                    255,
                                                                    255),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          MyStyle().showTextSC(
                                                                              context,
                                                                              reserveaccModels[index].resStartDate == reserveaccModels[index].resEndDate ? '${MyStyle().dateTypeddmmyyyy('${reserveaccModels[index].resStartDate}')}' : '${MyStyle().dateTypeddmmyyyy('${reserveaccModels[index].resStartDate}')} - ${MyStyle().dateTypeddmmyyyy('${reserveaccModels[index].resEndDate}')}',
                                                                              20,
                                                                              MyStyle().color1),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          MyStyle().showTextSC(
                                                                              context,
                                                                              'ชื่อผู้จอง : ',
                                                                              25,
                                                                              Color.fromARGB(255, 102, 102, 102)),
                                                                          MyStyle().showTextSC(
                                                                              context,
                                                                              '${reserveaccModels[index].accFullname} (${reserveaccModels[index].accNickname})',
                                                                              25,
                                                                              MyStyle().color1),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child: MyStyle().showTextSC(
                                                                                context,
                                                                                'โครงการ/สถานที่ :',
                                                                                25,
                                                                                Color.fromARGB(255, 102, 102, 102)),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child: MyStyle().showTextSC(
                                                                                context,
                                                                                ' ${reserveaccModels[index].resProject}',
                                                                                25,
                                                                                MyStyle().color1),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                        reserveaccModels[index]
                                                                    .carID !=
                                                                carID
                                                            ? SizedBox()
                                                            : SizedBox(
                                                                height: 5)
                                                      ]);
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15)
                                      ],
                                    );
                                  }),
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
                'ตารางจองรถ',
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
}
