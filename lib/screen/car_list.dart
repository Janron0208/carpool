import 'dart:convert';

import 'package:carpool/screen/car_detail.dart';
import 'package:carpool/unity/my_api.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:carpool/screen/car_add.dart';
import 'package:carpool/models/car_model.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:page_transition/page_transition.dart';

class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  List<CarModel> carModels = [];
  String? loaddata = 'yes';
  Map<String, String> data = {};

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

        print(carModels.length);
      });

      setState(() {
        loaddata = 'no';
      });

      // String passData = item['Car_Number'];

      // print(passData);

      // print('Password : ${item['Acc_Password']}');
      // if (item['Acc_Password'] == null) {
      //   print('ไม่มีข้อมูล');
      // } else {
      //   print('มีข้อมูล');
      // }
      // print('Acc_Code: ${item['Acc_Code']}');
      // print('Acc_Name: ${item['Acc_Fullame']}');
      // print('Acc_Email: ${item['Acc_Nickname']}');
      // print('--------------------');
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
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: carModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        child: IntrinsicHeight(
                                          child: Material(
                                            color: Color.fromARGB(
                                                99, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            clipBehavior: Clip.hardEdge,
                                            child: InkWell(
                                              onTap: () {
                                                print(
                                                    'CarID : ${carModels[index].carID!}');

                                                MyApi().NavigatorPushAnim(
                                                    context,
                                                    PageTransitionType.fade,
                                                    CarDetail(
                                                      carID:
                                                          '${carModels[index].carID!}',
                                                      carNumber:
                                                          '${carModels[index].carNumber!}',
                                                    ));
                                                // MaterialPageRoute route = MaterialPageRoute(
                                                //     builder: (context) => ShowDetailCar(
                                                //         Car_ID: '${carModels[index].carID}'));
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
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: AspectRatio(
                                                          aspectRatio:
                                                              487 / 451,
                                                          child: Container(
                                                            decoration: new BoxDecoration(
                                                                image: new DecorationImage(
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                    alignment:
                                                                        FractionalOffset
                                                                            .center,
                                                                    image: AssetImage(carModels[index].carBrand! ==
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
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 5,
                                                                top: 3,
                                                                bottom: 5),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.43,
                                                          child: Column(
                                                            children: [
                                                              Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    MyStyle()
                                                                        .showTextSCW(
                                                                      context,
                                                                      '${carModels[index].carBrand!}',
                                                                      20,
                                                                      FontWeight
                                                                          .bold,
                                                                      Colors
                                                                          .black,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    MyStyle()
                                                                        .showTextSCW(
                                                                      context,
                                                                      '${carModels[index].carModel!}',
                                                                      23,
                                                                      FontWeight
                                                                          .normal,
                                                                      Colors
                                                                          .grey,
                                                                    )
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
                                                                      color: MyStyle()
                                                                          .color2,
                                                                      child:
                                                                          Center(
                                                                        child: Text(
                                                                            'ป้ายทะเบียน',
                                                                            style:
                                                                                TextStyle(fontSize: 14, color: Color.fromARGB(255, 255, 255, 255))),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    MyStyle()
                                                                        .showTextSCW(
                                                                      context,
                                                                      '${carModels[index].carNumber!}',
                                                                      18,
                                                                      FontWeight
                                                                          .bold,
                                                                      const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          59,
                                                                          59,
                                                                          59),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                print(
                                                                    '${carModels[index].carID!}');
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .edit_document,
                                                                size: 25,
                                                                color: Color
                                                                    .fromARGB(
                                                                        108,
                                                                        77,
                                                                        77,
                                                                        77),
                                                              )),
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
                                      ),
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
                'รายการรถยนต์',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              )),
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    MaterialPageRoute route =
                        MaterialPageRoute(builder: (context) => CarAdd());
                    Navigator.push(context, route).then((value) {
                      carModels.clear();
                      loadAllCar();
                      setState(() {
                        loaddata = 'yes';
                      });
                    });
                  },
                  icon: Icon(Icons.add_circle, size: 30, color: Colors.white))),
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
