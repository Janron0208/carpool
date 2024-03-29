import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReturnCar extends StatefulWidget {
  const ReturnCar({super.key});

  @override
  State<ReturnCar> createState() => _ReturnCarState();
}

class _ReturnCarState extends State<ReturnCar> {
  String? loaddata = 'no';
  File? picMileageEnd;
  String? inputTextComment, inputTextLastmile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          MyStyle().BG_Image(context, 'bg2.jpg'),
          SafeArea(
            child: Stack(
              children: [
                loaddata == 'yes'
                    ? MyPopup().showLoadData()
                    : GestureDetector(
                        onTap: () =>
                            FocusScope.of(context).requestFocus(FocusNode()),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 1,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 60, left: 10, right: 10, bottom: 10),
                              child: Column(
                                children: [
                                  inputLastmile(context),
                                  SizedBox(height: 10),
                                  uploadPicMileEnd(context),
                                  SizedBox(height: 10),
                                  inputComment(context),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {
                                      checkNullText();
                                    },
                                    child: Material(
                                      elevation: 5,
                                      shadowColor: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                child: Image.asset(
                                                    'images/arrow_left_bottom.gif')),
                                            SizedBox(width: 20),
                                            MyStyle().showSizeTextSC(context,
                                                'คืนรถ', 20, MyStyle().color1),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              )),
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

  Material inputComment(BuildContext context) {
    return Material(
      color: Color.fromARGB(148, 255, 255, 255),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                MyStyle().showSizeTextSC(
                    context, 'ปัญหาการใช้งานรถยนต์', 20, MyStyle().color1),
              ],
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: const Color.fromARGB(218, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 2,
                      initialValue: '',
                      onChanged: (value) {
                        setState(() {
                          inputTextComment = value.trim();
                        });
                      },
                      style: TextStyle(
                          color: Color.fromARGB(255, 112, 112, 112),
                          fontSize: 20),
                      decoration: InputDecoration(
                        hintText: 'ปัญหาการใช้งาน',
                        hintStyle: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 184, 184, 184)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material inputLastmile(BuildContext context) {
    return Material(
      color: Color.fromARGB(148, 255, 255, 255),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                MyStyle().showSizeTextSC(
                    context, 'เลขไมล์หลังใช้รถยนต์', 20, MyStyle().color1),
              ],
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: const Color.fromARGB(218, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: '',
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          inputTextLastmile = value.trim();
                        });
                      },
                      style: TextStyle(
                          color: Color.fromARGB(255, 112, 112, 112),
                          fontSize: 20),
                      decoration: InputDecoration(
                        hintText: 'เลขไมล์ล่าสุด',
                        hintStyle: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 184, 184, 184)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container uploadPicMileEnd(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(148, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                MyStyle().showSizeTextSC(
                    context, 'รูปเลขไมล์หลังใช้รถยนต์', 20, MyStyle().color1),
              ],
            ),
            SizedBox(height: 10),
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
                'คืนรถยนต์',
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

  Future chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker().pickImage(
        source: source,
        imageQuality: 50,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        picMileageEnd = File(object!.path);
      });
    } catch (e) {}
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
                    image: FileImage(
                        picMileageEnd! // Use a default image if picHood is null or not a File
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

  Future<Null> checkNullText() async {
    if (picMileageEnd == null ||
        inputTextLastmile == null ||
        inputTextLastmile!.isEmpty) {
      MyPopup().showError(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
    } else {
      if (inputTextComment == null || inputTextComment!.isEmpty) {
        setState(() {
          inputTextComment = '-';
        });
      }
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('คืนรถยนต์ ?'),
          content: const Text('ตรวจสอบข้อมูลให้เรียบร้อยก่อนการคืนรถยนต์'),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child:
                    MyStyle().showSizeTextSC(context, 'ปิด', 20, Colors.red)),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  updateToDatabase();
                },
                child: MyStyle().showSizeTextSC(
                    context, 'คืนรถ', 20, Color.fromARGB(255, 54, 130, 244))),
          ],
        ),
      );
    }
  }

  Future<void> updateToDatabase() async {
    setState(() {
      loaddata = 'yes';
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String accID = preferences.getString('Acc_ID')!;
    var url1 = Uri.parse(
        '${MyConstant().domain}/carpool/history/getHistoryByAccIDAndStatus.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url1,
      body: {'Acc_ID': accID, 'H_Status': 'driving'},
    );
    var data1 = json.decode(response.body);

    var timenow = DateTime.now();
    var timeend = DateFormat('HH:mm').format(timenow);
    var dateend = DateFormat('yyyyMMdd').format(timenow);

    String apiSaveHistory = '${MyConstant().domain}/carpool/savePic.php';
    String nameFile = '${data1[0]['H_ID']}_end.jpg';

    Map<String, dynamic> map = Map();
    map['file'] =
        await MultipartFile.fromFile(picMileageEnd!.path, filename: nameFile);
    FormData data = FormData.fromMap(map);
    await Dio().post(apiSaveHistory, data: data).then((value) {});

    print('Mile : $inputTextLastmile');
    print('Comment : $inputTextComment');
    print('Path : $nameFile');
    print('timeend : $timeend');

    var url4 = Uri.parse(
        '${MyConstant().domain}/carpool/reserve/updateStatusReserve.php');

    var response4 = await http.post(
      url4,
      body: {
        'Res_StartDate': '${data1[0]['H_StartDate']}',
        'Res_EndDate': '${data1[0]['H_EndDate']}',
      },
    );

    var url3 =
        Uri.parse('${MyConstant().domain}/carpool/car/updateMileCar.php');

    var response3 = await http.post(
      url3,
      body: {
        'Car_ID': '${data1[0]['Car_ID']}',
        'Car_Mileage': '$inputTextLastmile',
      },
    );
    var url = Uri.parse(
        '${MyConstant().domain}/carpool/history/updateHistoryEnd.php');

    var response2 = await http.post(
      url,
      body: {
        'H_ID': '${data1[0]['H_ID']}',
        'H_EndDate': '$dateend',
        'H_EndTime': '$timeend',
        'H_MileageEnd': '$inputTextLastmile',
        'H_PicMileageEnd': '/carpool/pic_history/${nameFile}',
        'H_Comment': '$inputTextComment',
      },
    );

    setState(() {
      loaddata = 'no';
      Navigator.pop(context);
      MyPopup().showToast(context, 'คืนรถยนต์สำเร็จ');
    });
  }
}
