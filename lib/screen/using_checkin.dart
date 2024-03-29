import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:carpool/models/history_model.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart' as path;

class UsingCheckIn extends StatefulWidget {
  const UsingCheckIn({super.key});

  @override
  State<UsingCheckIn> createState() => _UsingCheckInState();
}

class _UsingCheckInState extends State<UsingCheckIn> {
  String? loaddata = 'yes';
  String? loadPic = 'no';
  String? accID;
  List<HistoryModel> historyModels = [];
  List<dynamic> his = [];
  String phase = 'start';
  String choosePic = '';
  File? picMileageStart,
      picMileageEnd,
      picFront,
      picBack,
      picLeft,
      picRight,
      picHood;

  Uint8List picMileageStartWeb = Uint8List(10);
  Uint8List picFrontWeb = Uint8List(10);
  Uint8List picBackWeb = Uint8List(10);
  Uint8List picLeftWeb = Uint8List(10);
  Uint8List picRightWeb = Uint8List(10);
  Uint8List picHoodWeb = Uint8List(10);
  String startWeb = 'no',
      frontWeb = 'no',
      backWeb = 'no',
      leftWeb = 'no',
      rightWeb = 'no',
      hoodWeb = 'no';
  String? editProject;

  @override
  void initState() {
    print('on Website : ${kIsWeb}');

    checkStatusStarted();
    super.initState();
  }

  Future<Null> checkStatusStarted() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    accID = preferences.getString('Acc_ID')!;
    var url1 = Uri.parse(
        '${MyConstant().domain}/carpool/history/getHistoryByAccIDAndStatus.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url1,
      body: {'Acc_ID': accID, 'H_Status': 'started'},
    );

    var data1 = json.decode(response.body);

    for (var item1 in data1) {
      HistoryModel historyModel = HistoryModel.fromJson(item1);
      setState(() {
        historyModels.add(historyModel);
      });
    }

    var url = Uri.parse(
        '${MyConstant().domain}/carpool/history/getHistoryAndAccountAndCar.php');

    var response2 = await http.post(
      url,
      body: {'Acc_ID': accID, 'Car_ID': historyModels[0].carID},
    );
    var hi = json.decode(response2.body);

    setState(() {
      his.add(hi[0]);
      editProject = '${historyModels[0].hProject}';

      loaddata = 'no';
    });

    print(his);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MyStyle().BG_Image(context, 'bg2.jpg'),
          GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            behavior: HitTestBehavior.opaque,
            child: SafeArea(
              child: Stack(
                children: [
                  loaddata == 'yes'
                      ? MyPopup().showLoadData()
                      : Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * 1,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 60, left: 10, right: 10, bottom: 10),
                                  child: Material(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    elevation: 8,
                                    child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: phase == 'start'
                                            ? Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      MyStyle().showSizeTextSC(
                                                          context,
                                                          'ขื่อผู้ใช้งาน : ',
                                                          25,
                                                          MyStyle().color3),
                                                      Expanded(
                                                        child: MyStyle()
                                                            .showSizeTextSC(
                                                                context,
                                                                '${his[0]['Acc_Fullname']} (${his[0]['Acc_Nickname']})',
                                                                23,
                                                                MyStyle()
                                                                    .color1),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      MyStyle().showSizeTextSC(
                                                          context,
                                                          'วันที่ใช้งาน : ',
                                                          25,
                                                          MyStyle().color3),
                                                      Expanded(
                                                        child: MyStyle().showSizeTextSC(
                                                            context,
                                                            his[0]['H_StartDate'] ==
                                                                    his[0][
                                                                        'H_EndDate']
                                                                ? '${MyStyle().dateTypeddmmyyyy('${his[0]['H_StartDate']}')}'
                                                                : '${MyStyle().dateTypeddmmyyyy('${his[0]['H_StartDate']}')} - ${MyStyle().dateTypeddmmyyyy('${his[0]['H_EndDate']}')}',
                                                            23,
                                                            MyStyle().color1),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      MyStyle().showSizeTextSC(
                                                          context,
                                                          'ทะเบียนรถ : ',
                                                          25,
                                                          MyStyle().color3),
                                                      Expanded(
                                                        child: MyStyle()
                                                            .showSizeTextSC(
                                                                context,
                                                                '${his[0]['Car_Number']}',
                                                                23,
                                                                MyStyle()
                                                                    .color1),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      MyStyle().showSizeTextSC(
                                                          context,
                                                          'เลขไมล์ล่าสุด : ',
                                                          25,
                                                          MyStyle().color3),
                                                      Row(
                                                        children: [
                                                          MyStyle()
                                                              .showTextNumberSC(
                                                                  context,
                                                                  '${his[0]['Car_Mileage']}',
                                                                  23,
                                                                  MyStyle()
                                                                      .color1),
                                                          MyStyle()
                                                              .showSizeTextSC(
                                                                  context,
                                                                  ' Km.',
                                                                  23,
                                                                  MyStyle()
                                                                      .color1),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          MyStyle().showSizeTextSC(
                                                              context,
                                                              'โครงการ/สถานที่ (แก้ไขได้)',
                                                              25,
                                                              MyStyle().color3),
                                                        ],
                                                      ),
                                                      Container(
                                                        // height: 200,
                                                        child: TextFormField(
                                                          initialValue:
                                                              '${his[0]['H_Project']}',
                                                          maxLines: 3,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              editProject =
                                                                  value.trim();
                                                            });
                                                          },
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      112,
                                                                      112,
                                                                      112),
                                                              fontSize: 18),
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'กรุณากรอกข้อมูล',
                                                            hintStyle: TextStyle(
                                                                fontSize: 18.0,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        184,
                                                                        184,
                                                                        184)),
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            15,
                                                                        vertical:
                                                                            20),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .transparent),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            filled: true,
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    241,
                                                                    241,
                                                                    241),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Spacer(),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 50,
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    MyStyle()
                                                                        .color1),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0), // Adjust corner radius
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          phase = 'upload';
                                                        });
                                                      },
                                                      child: MyStyle()
                                                          .showSizeTextSC(
                                                              context,
                                                              'ถัดไป',
                                                              20,
                                                              Colors.white),
                                                    ),
                                                  )
                                                  // Divider(),
                                                  // SizedBox(height: 10),
                                                ],
                                              )
                                            : SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        MyStyle()
                                                            .showSizeTextSC(
                                                                context,
                                                                'อัปโหลดรูปภาพ',
                                                                20,
                                                                MyStyle()
                                                                    .color1),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    uploadMileage(context),
                                                    SizedBox(height: 10),
                                                    uploadFront(context),
                                                    SizedBox(height: 10),
                                                    uploadBack(context),
                                                    SizedBox(height: 10),
                                                    uploadLeft(context),
                                                    SizedBox(height: 10),
                                                    uploadRight(context),
                                                    SizedBox(height: 10),
                                                    uploadHood(context),
                                                    SizedBox(height: 20),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 50,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      MyStyle()
                                                                          .color1),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0), // Adjust corner radius
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          checkNullImage();
                                                          // setState(() {
                                                          //   phase = 'return';
                                                          // });
                                                        },
                                                        child: MyStyle()
                                                            .showSizeTextSC(
                                                                context,
                                                                'บันทึก',
                                                                20,
                                                                Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                  )),
                            ),
                            loadPic == 'yes'
                                ? Material(
                                    color: Color.fromARGB(183, 255, 255, 255),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  )
                                : Container()
                          ],
                        ),
                  showheadBar(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container uploadMileage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: MyStyle().color3,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 231, 231, 231),
            offset: Offset(3.0, 6.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                MyStyle().showSizeTextSC(
                    context, 'เลขไมล์ก่อนเดินทาง : ', 25, MyStyle().color3),
                Row(
                  children: [
                    MyStyle().showTextNumberSC(context,
                        '${his[0]['Car_Mileage']}', 23, MyStyle().color1),
                    MyStyle()
                        .showSizeTextSC(context, ' Km.', 23, MyStyle().color1),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),
            kIsWeb
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 120,
                    child: startWeb == 'no'
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.grey[300],
                              elevation: 5.0,
                              shadowColor: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                choosePic = 'mileageStart';
                                chooseImage(ImageSource.gallery);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                MyStyle().showSizeTextSC(
                                    context, 'เพิ่มรูปภาพ', 23, Colors.white)
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                child: Center(
                                    child: Image.memory(picMileageStartWeb)),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    choosePic = 'mileageStart';
                                    showPicture();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color.fromARGB(118, 104, 104, 104),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                : Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 120,
                    child: picMileageStart == null
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.grey[300],
                              elevation: 5.0,
                              shadowColor: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                choosePic = 'mileageStart';
                                chooseImage(ImageSource.gallery);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                MyStyle().showSizeTextSC(
                                    context, 'เพิ่มรูปภาพ', 23, Colors.white)
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300],
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: FileImage(picMileageStart!)))),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    choosePic = 'mileageStart';
                                    showPicture();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color.fromARGB(118, 104, 104, 104),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
          ],
        ),
      ),
    );
  }

  Container uploadFront(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: MyStyle().color3,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 231, 231, 231),
            offset: Offset(3.0, 6.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                MyStyle().showSizeTextSC(
                    context, 'รูปถ่ายหน้ารถ', 25, MyStyle().color3),
              ],
            ),
            SizedBox(height: 5),
            kIsWeb
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 120,
                    child: frontWeb == 'no'
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.grey[300],
                              elevation: 5.0,
                              shadowColor: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                choosePic = 'front';
                                chooseImage(ImageSource.gallery);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                MyStyle().showSizeTextSC(
                                    context, 'เพิ่มรูปภาพ', 23, Colors.white)
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                child: Center(child: Image.memory(picFrontWeb)),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    choosePic = 'front';
                                    showPicture();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color.fromARGB(118, 104, 104, 104),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                : Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 120,
                    child: picFront == null
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.grey[300],
                              elevation: 5.0,
                              shadowColor: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                choosePic = 'front';
                                chooseImage(ImageSource.gallery);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                MyStyle().showSizeTextSC(
                                    context, 'เพิ่มรูปภาพ', 23, Colors.white)
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300],
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: FileImage(picFront!)))),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    choosePic = 'front';
                                    showPicture();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color.fromARGB(118, 104, 104, 104),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
          ],
        ),
      ),
    );
  }

  Container uploadBack(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: MyStyle().color3,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 231, 231, 231),
            offset: Offset(3.0, 6.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                MyStyle().showSizeTextSC(
                    context, 'รูปถ่ายหลังรถ', 25, MyStyle().color3),
              ],
            ),
            SizedBox(height: 5),
            kIsWeb
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 120,
                    child: backWeb == 'no'
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.grey[300],
                              elevation: 5.0,
                              shadowColor: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                choosePic = 'back';
                                chooseImage(ImageSource.gallery);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                MyStyle().showSizeTextSC(
                                    context, 'เพิ่มรูปภาพ', 23, Colors.white)
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                child: Center(child: Image.memory(picBackWeb)),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    choosePic = 'back';
                                    showPicture();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color.fromARGB(118, 104, 104, 104),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                : Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 120,
                    child: picBack == null
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.grey[300],
                              elevation: 5.0,
                              shadowColor: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                choosePic = 'back';
                                chooseImage(ImageSource.gallery);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                MyStyle().showSizeTextSC(
                                    context, 'เพิ่มรูปภาพ', 23, Colors.white)
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300],
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: FileImage(picBack!)))),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    choosePic = 'back';
                                    showPicture();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color.fromARGB(118, 104, 104, 104),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
          ],
        ),
      ),
    );
  }

  Container uploadLeft(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: MyStyle().color3,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 231, 231, 231),
            offset: Offset(3.0, 6.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                MyStyle().showSizeTextSC(
                    context, 'รูปถ่ายรถข้างซ้าย', 25, MyStyle().color3),
              ],
            ),
            SizedBox(height: 5),
            kIsWeb
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 120,
                    child: leftWeb == 'no'
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.grey[300],
                              elevation: 5.0,
                              shadowColor: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                choosePic = 'left';
                                chooseImage(ImageSource.gallery);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                MyStyle().showSizeTextSC(
                                    context, 'เพิ่มรูปภาพ', 23, Colors.white)
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                child: Center(child: Image.memory(picLeftWeb)),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    choosePic = 'left';
                                    showPicture();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color.fromARGB(118, 104, 104, 104),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                : Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 120,
                    child: picLeft == null
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.grey[300],
                              elevation: 5.0,
                              shadowColor: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                choosePic = 'left';
                                chooseImage(ImageSource.gallery);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                MyStyle().showSizeTextSC(
                                    context, 'เพิ่มรูปภาพ', 23, Colors.white)
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300],
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: FileImage(picLeft!)))),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    choosePic = 'left';
                                    showPicture();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color.fromARGB(118, 104, 104, 104),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
          ],
        ),
      ),
    );
  }

  Container uploadRight(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: MyStyle().color3,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 231, 231, 231),
            offset: Offset(3.0, 6.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                MyStyle().showSizeTextSC(
                    context, 'รูปถ่ายรถข้างขวา', 25, MyStyle().color3),
              ],
            ),
            SizedBox(height: 5),
            kIsWeb
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 120,
                    child: rightWeb == 'no'
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.grey[300],
                              elevation: 5.0,
                              shadowColor: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                choosePic = 'right';
                                chooseImage(ImageSource.gallery);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                MyStyle().showSizeTextSC(
                                    context, 'เพิ่มรูปภาพ', 23, Colors.white)
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                child: Center(child: Image.memory(picRightWeb)),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    choosePic = 'right';
                                    showPicture();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color.fromARGB(118, 104, 104, 104),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                : Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 120,
                    child: picRight == null
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.grey[300],
                              elevation: 5.0,
                              shadowColor: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                choosePic = 'right';
                                chooseImage(ImageSource.gallery);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                MyStyle().showSizeTextSC(
                                    context, 'เพิ่มรูปภาพ', 23, Colors.white)
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300],
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: FileImage(picRight!)))),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    choosePic = 'right';
                                    showPicture();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color.fromARGB(118, 104, 104, 104),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
          ],
        ),
      ),
    );
  }

  Container uploadHood(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: MyStyle().color3,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 231, 231, 231),
            offset: Offset(3.0, 6.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                MyStyle().showSizeTextSC(
                    context, 'รูปถ่ายใต้ฝากระโปรง', 25, MyStyle().color3),
              ],
            ),
            SizedBox(height: 5),
            kIsWeb
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 120,
                    child: hoodWeb == 'no'
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.grey[300],
                              elevation: 5.0,
                              shadowColor: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                choosePic = 'hood';
                                chooseImage(ImageSource.gallery);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                MyStyle().showSizeTextSC(
                                    context, 'เพิ่มรูปภาพ', 23, Colors.white)
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                child: Center(child: Image.memory(picHoodWeb)),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    choosePic = 'hood';
                                    showPicture();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color.fromARGB(118, 104, 104, 104),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                : Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 120,
                    child: picHood == null
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.grey[300],
                              elevation: 5.0,
                              shadowColor: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                choosePic = 'hood';
                                chooseImage(ImageSource.gallery);
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                MyStyle().showSizeTextSC(
                                    context, 'เพิ่มรูปภาพ', 23, Colors.white)
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300],
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: FileImage(picHood!)))),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    choosePic = 'hood';
                                    showPicture();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color.fromARGB(118, 104, 104, 104),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
          ],
        ),
      ),
    );
  }

  Container uploadMileageEnd(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: MyStyle().color3,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 231, 231, 231),
            offset: Offset(3.0, 6.0),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                MyStyle().showSizeTextSC(
                    context, 'เลขไมล์วันคืนรถ', 25, MyStyle().color3),
              ],
            ),
            SizedBox(height: 5),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 120,
                child: picMileageEnd == null
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Colors.grey[300],
                          elevation: 5.0,
                          shadowColor: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            choosePic = 'mileageEnd';
                            chooseImage(ImageSource.gallery);
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                            MyStyle().showSizeTextSC(
                                context, 'เพิ่มรูปภาพ', 23, Colors.white)
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300],
                                  image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: FileImage(picMileageEnd!)))),
                          InkWell(
                            onTap: () {
                              setState(() {
                                choosePic = 'mileageEnd';
                                showPicture();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color.fromARGB(118, 104, 104, 104),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.search,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
          ],
        ),
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
          Expanded(
              flex: 1,
              child: phase == 'upload'
                  ? IconButton(
                      onPressed: () {
                        if (kIsWeb) {
                          startWeb = 'no';
                          frontWeb = 'no';
                          backWeb = 'no';
                          leftWeb = 'no';
                          rightWeb = 'no';
                          hoodWeb = 'no';
                          // print(picMileageStartWeb);
                          //  Uint8List picMileageStartWeb = Uint8List(10);
                        } else {
                          setState(() {
                            picMileageStart = null;
                            picMileageEnd = null;
                            picFront = null;
                            picBack = null;
                            picLeft = null;
                            picRight = null;
                            picHood = null;
                          });
                        }

                        MyPopup().showToast(context, 'รีเซ็ทสำเร็จ');
                      },
                      icon: Icon(
                        Icons.restart_alt,
                        size: 30,
                        color: Colors.red[300],
                      ))
                  : Container()),
        ],
      ),
    );
  }

  Future<Null> showPicture() async {
    showDialog(
      context: context,
      builder: (context) => Scaffold(
        backgroundColor: Color.fromARGB(190, 240, 240, 240),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kIsWeb
                  ? Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(0, 255, 255, 255),
                      ),
                      child: Image.memory(
                          choosePic == 'mileageStart'
                              ? picMileageStartWeb
                              : choosePic == 'front'
                                  ? picFrontWeb
                                  : choosePic == 'back'
                                      ? picBackWeb
                                      : choosePic == 'left'
                                          ? picLeftWeb
                                          : choosePic == 'right'
                                              ? picRightWeb
                                              : picHoodWeb,
                          fit: BoxFit.contain),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(0, 255, 255, 255),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: FileImage(choosePic == 'mileageStart'
                                  ? picMileageStart!
                                  : choosePic == 'mileageEnd'
                                      ? picMileageEnd!
                                      : choosePic == 'front'
                                          ? picFront!
                                          : choosePic == 'back'
                                              ? picBack!
                                              : choosePic == 'left'
                                                  ? picLeft!
                                                  : choosePic == 'right'
                                                      ? picRight!
                                                      : picHood! // Use a default image if picHood is null or not a File
                              ),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.6,
                    ),
              SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(MyStyle().color1),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Adjust corner radius
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                          chooseImage(ImageSource.gallery);
                        });
                      },
                      child: MyStyle().showSizeTextSC(
                          context, 'เปลี่ยนรูป', 20, Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Adjust corner radius
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: MyStyle()
                          .showSizeTextSC(context, 'ปิด', 20, Colors.white),
                    ),
                  )
                ],
              ),
              // Expanded(
              //   flex: 5,
              //   child: Container(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future chooseImage(ImageSource source) async {
    setState(() {
      loadPic = 'yes';
    });
    print(choosePic);
    try {
      if (kIsWeb) {
        final ImagePicker _picker = ImagePicker();
        XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        var f = await image!.readAsBytes();
        setState(() {
          if (choosePic == 'mileageStart') {
            setState(() {
              startWeb = 'yes';
              picMileageStartWeb = f;
            });
          } else if (choosePic == 'mileageEnd') {
            setState(() {
              // picMileageEndWE = File(image!.path);
            });
          } else if (choosePic == 'front') {
            setState(() {
              frontWeb = 'yes';
              picFrontWeb = f;
            });
          } else if (choosePic == 'back') {
            setState(() {
              backWeb = 'yes';
              picBackWeb = f;
            });
          } else if (choosePic == 'left') {
            setState(() {
              leftWeb = 'yes';
              picLeftWeb = f;
            });
          } else if (choosePic == 'right') {
            setState(() {
              rightWeb = 'yes';
              picRightWeb = f;
            });
          } else if (choosePic == 'hood') {
            setState(() {
              hoodWeb = 'yes';
              picHoodWeb = f;
            });
          }
        });
      } else {
        var object = await ImagePicker().pickImage(
          source: source,
          imageQuality: 50,
          maxWidth: 800.0,
          maxHeight: 800.0,
        );

        setState(() {
          if (choosePic == 'mileageStart') {
            setState(() {
              picMileageStart = File(object!.path);
            });
          } else if (choosePic == 'mileageEnd') {
            setState(() {
              picMileageEnd = File(object!.path);
            });
          } else if (choosePic == 'front') {
            setState(() {
              picFront = File(object!.path);
            });
          } else if (choosePic == 'back') {
            setState(() {
              picBack = File(object!.path);
            });
          } else if (choosePic == 'left') {
            setState(() {
              picLeft = File(object!.path);
            });
          } else if (choosePic == 'right') {
            setState(() {
              picRight = File(object!.path);
            });
          } else if (choosePic == 'hood') {
            setState(() {
              picHood = File(object!.path);
            });
          }
        });
      }
    } catch (e) {}
    setState(() {
      loadPic = 'no';
    });
  }

  Future<Null> checkNullImage() async {
    if (kIsWeb) {
      if (startWeb == 'no' ||
          frontWeb == 'no' ||
          backWeb == 'no' ||
          leftWeb == 'no' ||
          rightWeb == 'no' ||
          hoodWeb == 'no') {
        MyPopup().showError(context, 'กรุณาอัพโหลดรูปภาพให้ครบ');
      } else {
        showDialogConfirm();
      }
    } else {
      if (picMileageStart == null ||
          picFront == null ||
          picBack == null ||
          picLeft == null ||
          picRight == null ||
          picHood == null) {
        MyPopup().showError(context, 'กรุณาอัพโหลดรูปภาพให้ครบ');
      } else {
        showDialogConfirm();
      }
    }
  }

  Future<String?> showDialogConfirm() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ยืนยันการบันทึก'),
        content: const Text('ตรวจสอบข้อมูลให้เรียบร้อยก่อนการบันทึก'),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: MyStyle().showSizeTextSC(context, 'ปิด', 20, Colors.red)),
          TextButton(
              onPressed: () {
                if (kIsWeb) {
                  createNameImageWeb();
                } else {
                  Navigator.pop(context);
                  createNameImageMobile();
                }
              },
              child: MyStyle().showSizeTextSC(
                  context, 'บันทึก', 20, Color.fromARGB(255, 54, 130, 244))),
        ],
      ),
    );
  }

  Future<File> convertUint8ListToFile(Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory();
    final filename = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final file = File(path.join(tempDir.path, filename));
    file.writeAsBytesSync(bytes);
    return file;
  }

  Future<Null> createNameImageWeb() async {
    print('WEBSITE');

    setState(() {
      loadPic = 'yes';
    });

    var timenow = DateTime.now();
    var timestart = DateFormat('HH:mm').format(timenow);

    List<String> PathPicture = [];
    List<String> name = [
      '_start.jpg',
      '_front.jpg',
      '_left.jpg',
      '_right.jpg',
      '_hood.jpg',
    ];
    List<Uint8List?> pathsUint8List = [];
    pathsUint8List.add(picMileageStartWeb);
    pathsUint8List.add(picFrontWeb);
    pathsUint8List.add(picLeftWeb);
    pathsUint8List.add(picRightWeb);
    pathsUint8List.add(picHoodWeb);
    int loop = 0;

    List<File?> paths = [];

    for (var item in pathsUint8List) {
      // String nameFile = '${historyModels[0].hID}${name[loop]}';

      print(convertUint8ListToFile(picMileageStartWeb));
    }
  }

  Future<Null> createNameImageMobile() async {
    setState(() {
      loadPic = 'yes';
    });

    var timenow = DateTime.now();
    var timestart = DateFormat('HH:mm').format(timenow);

    List<String> PathPicture = [];
    List<String> name = [
      '_start.jpg',
      '_front.jpg',
      '_back.jpg',
      '_left.jpg',
      '_right.jpg',
      '_hood.jpg',
    ];
    List<File?> paths = [];
    paths.add(picMileageStart);
    paths.add(picFront);
    paths.add(picBack);
    paths.add(picLeft);
    paths.add(picRight);
    paths.add(picHood);
    String apiSaveHistory = '${MyConstant().domain}/carpool/savePic.php';

    int loop = 0;
    for (var item in paths) {
      String nameFile = '${historyModels[0].hID}${name[loop]}';

      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(item!.path, filename: nameFile);
      FormData data = FormData.fromMap(map);
      await Dio().post(apiSaveHistory, data: data).then((value) async {
        print('รูปที่ ${loop + 1} Upload Success');

        PathPicture.add(
            '/carpool/pic_history/${historyModels[0].hID}${name[loop]}');
        print(PathPicture[loop]);

        loop++;
        if (loop >= paths.length) {}
      });
    }
    print('ขั้นตอนต่อไป');

    var url = Uri.parse(
        '${MyConstant().domain}/carpool/history/updateHistoryStart.php');
    var response = await http.post(
      url,
      body: {
        'H_ID': '${historyModels[0].hID}',
        'H_StartTime': '$timestart',
        'H_Project': '$editProject',
        'H_PicMileageStart': '${PathPicture[0]}',
        'H_PicFront': '${PathPicture[1]}',
        'H_PicBack': '${PathPicture[2]}',
        'H_PicLeft': '${PathPicture[3]}',
        'H_PicRight': '${PathPicture[4]}',
        'H_PicHood': '${PathPicture[5]}',
        'H_Status': 'driving'
      },
    );
    if (response.statusCode == 200) {
      MyPopup().showToast(context, 'อัปโหลดรูปภาพสำเร็จ');
    } else {
      // Error
      print('Error');
    }
    setState(() {
      loadPic = 'no';
      Navigator.pop(context);
    });
  }
}
