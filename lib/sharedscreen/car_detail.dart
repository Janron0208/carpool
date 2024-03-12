import 'dart:convert';

import 'package:carpool/models/car_model.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CarDetail extends StatefulWidget {
  final String carID, carNumber, day;
  const CarDetail(
      {super.key,
      required this.carID,
      required this.carNumber,
      required this.day});

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  String? loaddata = 'yes';
  List<CarModel> carModels = [];

  @override
  void initState() {
    loadAllCar();
    super.initState();
  }

  void loadAllCar() async {
    print(widget.carID);
    final url = await Uri.parse(
        '${MyConstant().domain}/carpool/car/getCarLikeCarID.php?Car_ID=${widget.carID}');

    http.Response response = await http.get(url);

    var data = json.decode(response.body);

    for (var item in data) {
      CarModel carModel = CarModel.fromJson(item);
      setState(() {
        carModels.add(carModel);

        // print(carModels[0]);
      });

      setState(() {
        loaddata = 'no';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 80,
          height: 70,
          child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: MyStyle().color1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.post_add_rounded,
                    color: MyStyle().color6,
                  ),
                  MyStyle().showTextSC('จองเลย', 18, MyStyle().color6),
                ],
              )),
        ),
      ),
      body: Stack(
        children: [
          MyStyle().BG_Color(context, MyStyle().color1),
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
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: MyStyle().showTextSCW(
                                                'ยี่ห้อ :',
                                                18,
                                                FontWeight.bold,
                                                MyStyle().color1)),
                                        Expanded(
                                            flex: 4,
                                            child: MyStyle().showTextSCW(
                                                '${carModels[0].carBrand}',
                                                16,
                                                FontWeight.normal,
                                                MyStyle().color3))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: MyStyle().showTextSCW(
                                                'รุ่น/โมเดล :',
                                                18,
                                                FontWeight.bold,
                                                MyStyle().color1)),
                                        Expanded(
                                            flex: 4,
                                            child: MyStyle().showTextSCW(
                                                '${carModels[0].carModel}',
                                                16,
                                                FontWeight.normal,
                                                MyStyle().color3))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: MyStyle().showTextSCW(
                                                'เลขทะเบียน :',
                                                18,
                                                FontWeight.bold,
                                                MyStyle().color1)),
                                        Expanded(
                                            flex: 4,
                                            child: MyStyle().showTextSCW(
                                                '${carModels[0].carNumber}',
                                                16,
                                                FontWeight.normal,
                                                MyStyle().color3))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: MyStyle().showTextSCW(
                                                'เลขไมล์ล่าสุด :',
                                                18,
                                                FontWeight.bold,
                                                MyStyle().color1)),
                                        Expanded(
                                            flex: 4,
                                            child: MyStyle().showTextSCW(
                                                '${carModels[0]}',
                                                16,
                                                FontWeight.normal,
                                                MyStyle().color3))
                                      ],
                                    ),
                                    Divider()
                                  ],
                                ),
                              ),
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
                '${widget.carNumber}',
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
