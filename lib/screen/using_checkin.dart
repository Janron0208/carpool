import 'dart:convert';

import 'package:carpool/models/reserve_model.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UsingCheckIn extends StatefulWidget {
  const UsingCheckIn({super.key});

  @override
  State<UsingCheckIn> createState() => _UsingCheckInState();
}

class _UsingCheckInState extends State<UsingCheckIn> {
  String? loaddata = 'yes';
  String? accID;
  List<ReserveModel> reserveModels = [];

  @override
  void initState() {
    checkReserveByAccID();
    super.initState();
  }

  Future<Null> checkReserveByAccID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    accID = preferences.getString('Acc_ID')!;
    print(accID);

    var url = Uri.parse(
        '${MyConstant().domain}/carpool/reserve/getReserveByAccID.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url,
      body: {'Acc_ID': accID},
    );

    print(response.body);

    if (response.body == '[]') {
      setState(() {
        loaddata = 'no';
        // nodata = 'yes';
      });
    } else {
      setState(() {
        var data = json.decode(response.body);

        try {
          for (var item in data) {
            ReserveModel reserveModel = ReserveModel.fromJson(item);
            setState(() {
              reserveModels.add(reserveModel);
              print(reserveModel.resID);
            });
            setState(() {
              loaddata = 'no';
            });
          }
        } catch (e) {}
      });
    }
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
                                top: 60, left: 10, right: 10, bottom: 10),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: reserveModels.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          SizedBox(height: 5),
                                          Stack(
                                            children: [
                                              Material(
                                                color: reserveModels[0].resID ==
                                                        reserveModels[index]
                                                            .resID
                                                    ? Color.fromARGB(
                                                        255, 226, 231, 255)
                                                    : Color.fromARGB(
                                                        255, 189, 189, 189),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: InkWell(
                                                  onTap: () {
                                                    reserveModels[0].resID ==
                                                            reserveModels[index]
                                                                .resID
                                                        ? print([index])
                                                        : MyPopup().showToastError(
                                                            context,
                                                            'Check In คิวแรกเท่านั้น');
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 15),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: MyStyle().showTextSC(
                                                                  context,
                                                                  reserveModels[index]
                                                                              .resStartDate ==
                                                                          reserveModels[index]
                                                                              .resEndDate
                                                                      ? 'วันที่ ${MyStyle().dateTypeddmmyyyy('${reserveModels[index].resStartDate}')}'
                                                                      : 'วันที่ ${MyStyle().dateTypeddmmyyyy('${reserveModels[index].resStartDate}')} - ${MyStyle().dateTypeddmmyyyy('${reserveModels[index].resEndDate}')}',
                                                                  22,
                                                                  MyStyle()
                                                                      .color1),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: MyStyle()
                                                                  .showTextSC(
                                                                      context,
                                                                      'โปรเจค/สถานที่ : ${reserveModels[index].resProject}',
                                                                      23,
                                                                      MyStyle()
                                                                          .color3),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 15),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.cancel_rounded,
                                                        size: 20,
                                                        color: Color.fromARGB(
                                                            255, 175, 63, 55),
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                              height: reserveModels[0].resID ==
                                                      reserveModels[index].resID
                                                  ? 20
                                                  : 5),
                                          reserveModels[0].resID ==
                                                  reserveModels[index].resID
                                              ? Column(
                                                  children: [
                                                    MyStyle().showTextS(
                                                        context,
                                                        'Check In คิวแรกเท่านั้น',
                                                        20),
                                                    SizedBox(height: 20),
                                                  ],
                                                )
                                              : Container()
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
                'กำลังใช้งาน',
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
