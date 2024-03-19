import 'package:carpool/unity/my_api.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReserveAdd extends StatefulWidget {
  final String carNumber, start, end, fullname, carID;
  const ReserveAdd({
    super.key,
    required this.carNumber,
    required this.start,
    required this.end,
    required this.fullname,
    required this.carID,
  });

  @override
  State<ReserveAdd> createState() => _ReserveAddState();
}

class _ReserveAddState extends State<ReserveAdd> {
  String? accID;

  @override
  void initState() {
    getUserData();

    super.initState();
  }

  Future<Null> getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      accID = preferences.getString('Acc_ID')!;
      print(accID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(141, 187, 187, 187),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(20)),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            MyStyle().showTextSCW(
                                context,
                                '   กรอกข้อมูลการจอง ',
                                MediaQuery.of(context).size.width / 20,
                                FontWeight.bold,
                                MyStyle().color1),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            // color: Colors.amber,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: MyStyle().showTextSC(
                                            context,
                                            'ทะเบียนรถ : ',
                                            MediaQuery.of(context).size.width /
                                                17,
                                            MyStyle().color3)),
                                    Expanded(
                                        flex: 4,
                                        child: MyStyle().showTextSC(
                                            context,
                                            '${widget.carNumber}',
                                            MediaQuery.of(context).size.width /
                                                17,
                                            MyStyle().color1)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: MyStyle().showTextSC(
                                            context,
                                            'วันที่เบิกใช้รถ : ',
                                            MediaQuery.of(context).size.width /
                                                17,
                                            MyStyle().color3)),
                                    Expanded(
                                        flex: 4,
                                        child: MyStyle().showTextSC(
                                            context,
                                            widget.start == widget.end
                                                ? dateTypeddmmyyyy(widget.start)
                                                : '${dateTypeddmmyyyy(widget.start)} - ${dateTypeddmmyyyy(widget.end)}',
                                            MediaQuery.of(context).size.width /
                                                17,
                                            MyStyle().color1)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: MyStyle().showTextSC(
                                            context,
                                            'ผู้เบิกใช้รถ : ',
                                            MediaQuery.of(context).size.width /
                                                17,
                                            MyStyle().color3)),
                                    Expanded(
                                        flex: 4,
                                        child: MyStyle().showTextSC(
                                            context,
                                            '${widget.fullname}',
                                            MediaQuery.of(context).size.width /
                                                17,
                                            MyStyle().color1)),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    MyStyle().showTextSC(
                                        context,
                                        'โครงการ/งาน/สถานที่/จังหวัด',
                                        MediaQuery.of(context).size.width / 18,
                                        MyStyle().color3),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Container(
                                  // height: 200,
                                  child: TextFormField(
                                    maxLines: 3,
                                    onChanged: (value) {
                                      setState(() {
                                        inputproject = value.trim();
                                      });
                                    },
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 112, 112, 112),
                                        fontSize: 18),
                                    decoration: InputDecoration(
                                      hintText: 'กรุณากรอกข้อมูล',
                                      hintStyle: TextStyle(
                                          fontSize: 18.0,
                                          color: Color.fromARGB(
                                              255, 184, 184, 184)),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 20),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 241, 241, 241),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              MyStyle().color1),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0), // Adjust corner radius
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      checkNull(context);
                                      // CheckNullText();

                                      // print('$code , $password');
                                    },
                                    child: Text(
                                      'ทำการจอง',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String dateTypeddmmyyyy(String? text) {
    String changeDateTypeOne() {
      String dateString = '$text';
      String year = dateString.substring(0, 4);
      int intyear = int.parse(year) + 543;
      String th_year = '$intyear';
      String month = dateString.substring(4, 6);
      String day = dateString.substring(6, 8);
      String formattedDate = '$day/$month/$th_year';

      return formattedDate;
    }

    return changeDateTypeOne();
  }

  String? inputproject;

  Future<Null> checkNull(context) async {
    if (inputproject == null || inputproject!.isEmpty) {
      MyPopup().showError(context, 'กรุณากรอกโครงการหรือสถานที่');
    } else {
      askToConfirm();
    }
  }

  Future<Null> askToConfirm() async {
    showDialog(
      context: context,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.all(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(220, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyStyle().showTextSC(context, 'ยืนยันการจอง', 15,
                              Color.fromARGB(255, 29, 29, 29)),
                          SizedBox(height: 20),
                          Center(
                            child: MyStyle().showTextSC(
                                context,
                                'เมื่อทำการจองแล้วสามารถยกเลิกได้ทุกเมื่อ',
                                23,
                                const Color.fromARGB(255, 66, 66, 66)),
                          ),
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.2),
                child: Container(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(220, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              insertDataToReserveTB();
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Center(
                                child: Text('จอง',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 72, 209, 72),
                                      fontSize: 18,
                                    )),
                              ),
                            ),
                          ),
                          VerticalDivider(),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Center(
                                child: Text('ปิด',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 216, 71, 71),
                                      fontSize: 18,
                                    )),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> insertDataToReserveTB() async {
    print('${inputproject}');
    print('${widget.start}');
    print('${widget.end}');
    print('${widget.carID}');
    print('${accID}');

    var url =
        Uri.parse('${MyConstant().domain}/carpool/reserve/insertReserve.php');

    // ส่งค่า accCode และ inputPassword ไปยัง PHP
    var response = await http.post(
      url,
      body: {
        'Res_Project': '$inputproject',
        'Res_StartDate': '${widget.start}',
        'Res_EndDate': '${widget.end}',
        'Car_ID': '${widget.carID}',
        'Acc_ID': '$accID'
      },
    );

    if (response.statusCode == 200) {
      // Success
      print('Success');
      MyPopup().showToast(context, 'จองสำเร็จแล้ว');
      MyApi().insertLogEvent('ทำการจองรถทะเบียน ${widget.carNumber}');
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      // Error
      print('Error');
    }
  }
}
