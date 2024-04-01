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
import 'package:shared_preferences/shared_preferences.dart';

class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  List<CarModel> carModels = [];
  String? loaddata = 'yes';
  Map<String, String> data = {};
  String? type;
  @override
  void initState() {
    loadAllCar();
    super.initState();
  }

  void loadAllCar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      type = preferences.getString('Acc_Type')!;
    });

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
                                top: 55, left: 10, right: 10, bottom: 10),
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
                                            color: carModels[index].carStatus !=
                                                    'Ready'
                                                ? const Color.fromARGB(
                                                    38, 0, 0, 0)
                                                : Color.fromARGB(
                                                    99, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            clipBehavior: Clip.hardEdge,
                                            child: InkWell(
                                              onTap: () {
                                                print(
                                                    'CarID : ${carModels[index].carID!}');
                                                MaterialPageRoute route =
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CarDetail(
                                                              carID:
                                                                  '${carModels[index].carID!}',
                                                              carNumber:
                                                                  '${carModels[index].carNumber!}',
                                                            ));
                                                Navigator.push(context, route)
                                                    .then((value) {
                                                  setState(() {
                                                    loaddata = 'yes';
                                                    carModels.clear();
                                                    loadAllCar();
                                                  });
                                                });
                                              },
                                              child: SizedBox(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
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
                                                      flex: 4,
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
                                                                        .showSizeTextSCW(
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
                                                                        .showSizeTextSCW(
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
                                                                        .showSizeTextSCW(
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
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 8),
                                                            child: Icon(
                                                              carModels[index]
                                                                          .carStatus !=
                                                                      'Ready'
                                                                  ? Icons
                                                                      .do_not_disturb_alt
                                                                  : Icons.wifi,
                                                              size: 35,
                                                              color: carModels[
                                                                              index]
                                                                          .carStatus !=
                                                                      'Ready'
                                                                  ? Colors.red
                                                                  : Color
                                                                      .fromARGB(
                                                                          185,
                                                                          74,
                                                                          218,
                                                                          74),
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
                'รายการรถยนต์',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              )),
          Expanded(
              flex: 1,
              child: type == 'user'
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) => CarAdd());
                        Navigator.push(context, route).then((value) {
                          setState(() {
                            loaddata = 'yes';
                            carModels.clear();
                            loadAllCar();
                          });
                        });
                      },
                      icon: Icon(Icons.add_circle,
                          size: 30, color: Colors.white))),
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
