import 'dart:convert';
import 'package:carpool/models/car_model.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class CarDetail extends StatefulWidget {
  final String carID, carNumber;
  const CarDetail({super.key, required this.carID, required this.carNumber});

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
    var url =
        Uri.parse('${MyConstant().domain}/carpool/car/getCarLikeCarID.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url,
      body: {'Car_ID': widget.carID},
    );

    var data = json.decode(response.body);

    for (var item in data) {
      CarModel carModel = CarModel.fromJson(item);
      setState(() {
        carModels.add(carModel);
      });

      setState(() {
        loaddata = 'no';
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
                    : SafeArea(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 60, left: 15, right: 15),
                            child: Column(
                              children: [
                                Material(
                                  color:
                                      const Color.fromARGB(186, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            // height: 50,

                                            child: AspectRatio(
                                              aspectRatio: 487 / 451,
                                              child: Container(
                                                decoration: new BoxDecoration(
                                                    image: new DecorationImage(
                                                        fit: BoxFit.fitWidth,
                                                        alignment:
                                                            FractionalOffset
                                                                .center,
                                                        image: AssetImage(carModels[
                                                                        0]
                                                                    .carBrand! ==
                                                                'TOYOTA'
                                                            ? 'images/logo_toyota.png'
                                                            : 'images/logo_isuzu.png'))),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      MyStyle().showTextSCW(
                                                        context,
                                                        '${carModels[0].carBrand!}',
                                                        20,
                                                        FontWeight.bold,
                                                        Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      MyStyle().showTextSCW(
                                                        context,
                                                        '${carModels[0].carModel!}',
                                                        23,
                                                        FontWeight.normal,
                                                        Colors.grey,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.23,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.03,
                                                        color: MyStyle().color2,
                                                        child: Center(
                                                          child: Text(
                                                              'ป้ายทะเบียน',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255))),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      MyStyle().showTextSCW(
                                                        context,
                                                        '${carModels[0].carNumber!}',
                                                        18,
                                                        FontWeight.bold,
                                                        const Color.fromARGB(
                                                            255, 59, 59, 59),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Material(
                                  color:
                                      const Color.fromARGB(186, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        MyStyle().showTextSC(
                                          context,
                                          'เลขไมล์ล่าสุด : ',
                                          20,
                                          MyStyle().color2,
                                        ),
                                        MyStyle().showTextNumberSCW(
                                          context,
                                          '${carModels[0].carMileage!}',
                                          20,
                                          MyStyle().color1,
                                          FontWeight.bold,
                                        ),
                                        MyStyle().showTextSCW(
                                          context,
                                          ' Km.',
                                          20,
                                          FontWeight.bold,
                                          MyStyle().color1,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    MyStyle().showTextSC(context,
                                        'เมนูการจัดการ', 20, Colors.white),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(MyStyle().color2),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    15.0), // Adjust corner radius
                                              ),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: MyStyle().showTextSC(
                                              context,
                                              'แก้ไขรายละเอียดรถยนต์',
                                              20,
                                              Colors.white),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(MyStyle().color2),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    15.0), // Adjust corner radius
                                              ),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: MyStyle().showTextSC(
                                              context,
                                              'ตารางการตรวจเช็ตสภาพรถยนต์',
                                              22,
                                              Colors.white),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(MyStyle().color2),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    15.0), // Adjust corner radius
                                              ),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: MyStyle().showTextSC(
                                              context,
                                              'ประวัติการถูกใช้งาน',
                                              20,
                                              Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
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
