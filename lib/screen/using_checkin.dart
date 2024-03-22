import 'dart:convert';
import 'dart:io';

import 'package:carpool/models/history_model.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
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

  String? editProject;

  @override
  void initState() {
    checkStatusUsing();
    super.initState();
  }

  Future<Null> checkStatusUsing() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    accID = preferences.getString('Acc_ID')!;
    var url1 = Uri.parse(
        '${MyConstant().domain}/carpool/history/getHistoryByAccIDAndStatus.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url1,
      body: {'Acc_ID': accID},
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
                      : Container(
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
                                                  MyStyle().showTextSC(
                                                      context,
                                                      'ขื่อผู้ใช้งาน : ',
                                                      25,
                                                      MyStyle().color3),
                                                  Expanded(
                                                    child: MyStyle().showTextSC(
                                                        context,
                                                        '${his[0]['Acc_Fullname']} (${his[0]['Acc_Nickname']})',
                                                        23,
                                                        MyStyle().color1),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  MyStyle().showTextSC(
                                                      context,
                                                      'วันที่ใช้งาน : ',
                                                      25,
                                                      MyStyle().color3),
                                                  Expanded(
                                                    child: MyStyle().showTextSC(
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
                                                  MyStyle().showTextSC(
                                                      context,
                                                      'ทะเบียนรถ : ',
                                                      25,
                                                      MyStyle().color3),
                                                  Expanded(
                                                    child: MyStyle().showTextSC(
                                                        context,
                                                        '${his[0]['Car_Number']}',
                                                        23,
                                                        MyStyle().color1),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  MyStyle().showTextSC(
                                                      context,
                                                      'เลขไมล์ล่าสุด : ',
                                                      25,
                                                      MyStyle().color3),
                                                  Row(
                                                    children: [
                                                      MyStyle().showTextNumberSC(
                                                          context,
                                                          '${his[0]['Car_Mileage']}',
                                                          23,
                                                          MyStyle().color1),
                                                      MyStyle().showTextSC(
                                                          context,
                                                          ' Km.',
                                                          23,
                                                          MyStyle().color1),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      MyStyle().showTextSC(
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
                                                          color: Color.fromARGB(
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
                                                            color:
                                                                Color.fromARGB(
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
                                                            Color.fromARGB(255,
                                                                241, 241, 241),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Spacer(),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 50,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<
                                                                    Color>(
                                                                MyStyle()
                                                                    .color1),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15.0), // Adjust corner radius
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      phase = 'upload';
                                                    });
                                                  },
                                                  child: MyStyle().showTextSC(
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
                                                    MyStyle().showTextSC(
                                                        context,
                                                        'อัปโหลดรูปภาพ',
                                                        20,
                                                        MyStyle().color1),
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
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 50,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<
                                                                      Color>(
                                                                  MyStyle()
                                                                      .color1),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
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
                                                    child: MyStyle().showTextSC(
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
                MyStyle().showTextSC(
                    context, 'เลขไมล์ก่อนเดินทาง : ', 25, MyStyle().color3),
                Row(
                  children: [
                    MyStyle().showTextNumberSC(context,
                        '${his[0]['Car_Mileage']}', 23, MyStyle().color1),
                    MyStyle().showTextSC(context, ' Km.', 23, MyStyle().color1),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),
            Container(
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
                            MyStyle().showTextSC(
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
                MyStyle()
                    .showTextSC(context, 'รูปถ่ายหน้ารถ', 25, MyStyle().color3),
              ],
            ),
            SizedBox(height: 5),
            Container(
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
                            MyStyle().showTextSC(
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
                MyStyle()
                    .showTextSC(context, 'รูปถ่ายหลังรถ', 25, MyStyle().color3),
              ],
            ),
            SizedBox(height: 5),
            Container(
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
                            MyStyle().showTextSC(
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
                MyStyle().showTextSC(
                    context, 'รูปถ่ายรถข้างซ้าย', 25, MyStyle().color3),
              ],
            ),
            SizedBox(height: 5),
            Container(
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
                            MyStyle().showTextSC(
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
                MyStyle().showTextSC(
                    context, 'รูปถ่ายรถข้างขวา', 25, MyStyle().color3),
              ],
            ),
            SizedBox(height: 5),
            Container(
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
                            MyStyle().showTextSC(
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
                MyStyle().showTextSC(
                    context, 'รูปถ่ายใต้ฝากระโปรง', 25, MyStyle().color3),
              ],
            ),
            SizedBox(height: 5),
            Container(
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
                            MyStyle().showTextSC(
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
                MyStyle().showTextSC(
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
                            MyStyle().showTextSC(
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
                        setState(() {
                          picMileageStart = null;
                          picMileageEnd = null;
                          picFront = null;
                          picBack = null;
                          picLeft = null;
                          picRight = null;
                          picHood = null;
                        });

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
              Container(
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
              // SizedBox(height: 10),
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
                      child: MyStyle()
                          .showTextSC(context, 'เปลี่ยนรูป', 20, Colors.white),
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
                          .showTextSC(context, 'ปิด', 20, Colors.white),
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
    print(choosePic);
    try {
      var object = await ImagePicker().pickImage(
        source: source,
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

      // print('Path : ${object!.path}');
    } catch (e) {}
  }

  Future<Null> checkNullImage() async {
    if (picMileageStart == null ||
        picFront == null ||
        picBack == null ||
        picLeft == null ||
        picRight == null ||
        picHood == null) {
      MyPopup().showError(context, 'กรุณาอัพโหลดรูปภาพให้ครบ');
    } else {
      createNameImage();
    }
  }

  Future<Null> createNameImage() async {
    String namepicMileageStart = '${historyModels[0].hID}_start.jpg';
    String namepicFront = '${historyModels[0].hID}_front.jpg';
    String namepicBack = '${historyModels[0].hID}_back.jpg';
    String namepicLeft = '${historyModels[0].hID}_left.jpg';
    String namepicRight = '${historyModels[0].hID}_right.jpg';
    String namepicHood = '${historyModels[0].hID}_hood.jpg';

    String pathpicMileageStart = '/carpool/pic_history/$namepicMileageStart';
    String pathpicFront = '/carpool/pic_history/$namepicFront';
    String pathpicBack = '/carpool/pic_history/$namepicBack';
    String pathpicLeft = '/carpool/pic_history/$namepicLeft';
    String pathpicRight = '/carpool/pic_history/$namepicRight';
    String pathpicHood = '/carpool/pic_history/$namepicHood';

    print(editProject);

    //  var url =
    //     Uri.parse('${MyConstant().domain}/carpool/reserve/insertReserve.php');

    // // ส่งค่า accCode และ inputPassword ไปยัง PHP
    // var response = await http.post(
    //   url,
    //   body: {
    //     'H_ID': '${historyModels[0].hID}',
    //    'H_StartTime': '$inputproject',
    //    'H_Project': '$inputproject',
    //    'H_PicFront': '$inputproject',
    //    'H_PicBack': '$inputproject',
    //    'H_PicLeft': '$inputproject',
    //    'H_PicRight': '$inputproject',
    //    'H_PicHood': '$inputproject',
    //    'H_PicMileageStart': '$inputproject',
    //    'H_Status': 'start'
    //   },
    // );

    // if (response.statusCode == 200) {
    //   // Success
    //   // print('Success');
    //   // MyPopup().showToast(context, 'จองสำเร็จแล้ว');
    //   // MyApi().insertLogEvent('ทำการจองรถทะเบียน ${widget.carNumber}');
    //   // Navigator.pop(context);
    //   // Navigator.pop(context);
    // } else {
    //   // Error
    //   print('Error');
    // }
  }
}
