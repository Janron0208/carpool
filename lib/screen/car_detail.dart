import 'dart:convert';
import 'package:carpool/models/car_model.dart';
import 'package:carpool/screen/car_edit.dart';
import 'package:carpool/unity/my_api.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CarDetail extends StatefulWidget {
  final String carID, carNumber;
  const CarDetail({super.key, required this.carID, required this.carNumber});

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  String loaddata = 'yes';
  List<CarModel> carModels = [];
  bool status = true;
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
    }

    if (carModels[0].carStatus == 'Ready') {
      setState(() {
        status = true;
        loaddata = 'no';
      });
    } else {
      setState(() {
        status = false;
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
          loaddata == 'yes'
              ? MyPopup().showLoadData()
              : SafeArea(
                  child: Stack(
                    children: [
                      SafeArea(
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
                                                      MyStyle().showSizeTextSCW(
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
                                                      MyStyle().showSizeTextSCW(
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
                                                      MyStyle().showSizeTextSCW(
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
                                        MyStyle().showSizeTextSC(
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
                                        MyStyle().showSizeTextSCW(
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
                                    MyStyle().showSizeTextSC(context,
                                        'เมนูการจัดการ', 20, Colors.white),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      type == 'user'
                                          ? Container()
                                          : Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 50,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          MyStyle().color1),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0), // Adjust corner radius
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  MaterialPageRoute route = MaterialPageRoute(
                                                      builder: (context) => CarEdit(
                                                          carID:
                                                              '${carModels[0].carID!}',
                                                          carBrand:
                                                              '${carModels[0].carBrand!}',
                                                          carModel:
                                                              '${carModels[0].carModel!}',
                                                          carNumber:
                                                              '${carModels[0].carNumber!}',
                                                          carMileage:
                                                              '${carModels[0].carMileage!}'));
                                                  Navigator.push(context, route)
                                                      .then((value) {
                                                    setState(() {
                                                      loaddata = 'yes';
                                                      carModels.clear();
                                                      loadAllCar();
                                                    });
                                                  });
                                                },
                                                child: MyStyle().showSizeTextSC(
                                                    context,
                                                    'แก้ไขรายละเอียดรถยนต์',
                                                    20,
                                                    Colors.white),
                                              ),
                                            ),
                                      type == 'user'
                                          ? Container()
                                          : SizedBox(height: 10),
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
                                          child: MyStyle().showSizeTextSC(
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
                                                    Color>(MyStyle().color3),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    15.0), // Adjust corner radius
                                              ),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: MyStyle().showSizeTextSC(
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
                      type == 'user'
                          ? Container()
                          : Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: Container(
                                  width: 80,
                                  height: 70,
                                  child: FloatingActionButton(
                                      onPressed: () {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: MyStyle().showSizeTextSC(
                                                context,
                                                'ลบรถยนต์คันนี้',
                                                15,
                                                MyStyle().color1),
                                            content: MyStyle().showSizeTextSC(
                                                context,
                                                'คุณต้องการลบรถยนต์ทะเบียน ${widget.carNumber} ใช่หรือไม่',
                                                21,
                                                MyStyle().color2),
                                            actions: <Widget>[
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: MyStyle()
                                                      .showSizeTextSC(
                                                          context,
                                                          'ปิด',
                                                          20,
                                                          const Color.fromARGB(
                                                              255,
                                                              54,
                                                              130,
                                                              244))),
                                              TextButton(
                                                  onPressed: () => deleteCar(),
                                                  child: MyStyle()
                                                      .showSizeTextSC(
                                                          context,
                                                          'ลบ',
                                                          20,
                                                          Colors.red)),
                                            ],
                                          ),
                                        );
                                      },
                                      backgroundColor: const Color.fromARGB(
                                          255, 248, 114, 104),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.delete_forever,
                                            color: MyStyle().color6,
                                          ),
                                          MyStyle().showSizeTextSC(context,
                                              'ลบ', 18, MyStyle().color6),
                                        ],
                                      )),
                                ),
                              ),
                            ),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  final MaterialStateProperty<Color?> overlayColor =
      MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      // Material color when switch is selected.
      if (states.contains(MaterialState.selected)) {
        return Color.fromARGB(255, 71, 201, 67);
      }
      return const Color.fromARGB(255, 253, 94, 94);
    },
  );

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
                status == false ? 'ปิดการใช้งานอยู่' : '${widget.carNumber}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: status == false ? Colors.red[400] : Colors.white,
                  fontSize: 25,
                ),
              )),
          Expanded(
              flex: 1,
              child: type == 'user'
                  ? Container()
                  : Switch(
                      thumbIcon: thumbIcon,
                      thumbColor: overlayColor,
                      value: status,
                      activeColor: Color.fromARGB(255, 163, 255, 140),
                      onChanged: (bool value) {
                        if (status == true) {
                          setState(() {
                            status = false;
                            carstatus = 'No';
                          });
                        } else {
                          setState(() {
                            status = true;
                            carstatus = 'Ready';
                          });
                        }
                        UpdateStatusCar();
                      },
                    )),
        ],
      ),
    );
  }

  String? carstatus;

  void UpdateStatusCar() async {
    // loaddata = 'yes';

    print(carstatus);
    print(widget.carID);

    var url =
        Uri.parse('${MyConstant().domain}/carpool/car/updateStatusCar.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url,
      body: {'Car_ID': '${widget.carID}', 'Car_Status': '$carstatus'},
    );
    // loadAllCar();

    if (response.statusCode == 200) {
      setState(() {
        carstatus == 'Ready'
            ? MyPopup().showToast(context, 'เปิดการใช้งานแล้ว')
            : MyPopup().showToastError(context, 'ปิดการใช้งานแล้ว');
      });

      carstatus == 'Ready'
          ? MyApi()
              .insertLogEvent('เปิดการใช้งานรถยนต์ทะเบียน ${widget.carNumber}')
          : MyApi()
              .insertLogEvent('ปิดการใช้งานรถยนต์ทะเบียน ${widget.carNumber}');
    } else {
      // Error
      print('Error');
    }
  }

  Future<Null> deleteCar() async {
    var url = Uri.parse('${MyConstant().domain}/carpool/car/deleteCar.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url,
      body: {
        'Car_ID': '${widget.carID}',
      },
    );
    setState(() {
      Navigator.pop(context);
      Navigator.pop(context);
      MyApi().insertLogEvent('ลบรถยนต์ทะเบียน ${widget.carNumber}');
      MyPopup().showToast(context, 'ลบรถยนต์สำเร็จ');
    });
  }
}
