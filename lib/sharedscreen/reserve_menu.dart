import 'dart:convert';
import 'package:carpool/sharedscreen/car_detail.dart';
import 'package:http/http.dart' as http;
import 'package:carpool/models/car_model.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';

class ReserveMenu extends StatefulWidget {
  const ReserveMenu({super.key});

  @override
  State<ReserveMenu> createState() => _ReserveMenuState();
}

class _ReserveMenuState extends State<ReserveMenu> {
  String? loaddata = 'yes';
  String? headBarText = 'จองด่วนวันนี้';
  List<CarModel> carModels = [];

  @override
  void initState() {
    loadAllCar();
    super.initState();
  }

  void loadAllCar() async {
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
                                top: 60, left: 15, right: 15, bottom: 1),
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: carModels.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        child: Material(
                                          color: MyStyle().color6,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          clipBehavior: Clip.hardEdge,
                                          child: InkWell(
                                            onTap: () {
                                              print(
                                                  '${carModels[index].carID!}');

                                              MaterialPageRoute route =
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CarDetail(
                                                            carID:
                                                                '${carModels[index].carID}',
                                                            carNumber:
                                                                '${carModels[index].carNumber}',
                                                            day: 'today',
                                                          ));
                                              Navigator.push(context, route)
                                                  .then((value) {
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
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: AspectRatio(
                                                        aspectRatio: 487 / 451,
                                                        child: Container(
                                                          decoration: new BoxDecoration(
                                                              image: new DecorationImage(
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                  alignment:
                                                                      FractionalOffset
                                                                          .center,
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
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                                  Text(
                                                                      '${carModels[index].carBrand!}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      '${carModels[index].carModel!}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              151,
                                                                              151,
                                                                              151))),
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
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        167,
                                                                        216,
                                                                        255),
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          'ป้ายทะเบียน',
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: Color.fromARGB(255, 255, 255, 255))),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      '${carModels[index].carNumber!}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              68,
                                                                              68,
                                                                              68))),
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                            Icons.wifi,
                                                            size: 25,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    52,
                                                                    241,
                                                                    67),
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
            label: 'จองหลายวัน',
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
            } else {
              headBarText = 'จองล่วงหน้าหลายวัน';
            }
          });
        },
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
}
