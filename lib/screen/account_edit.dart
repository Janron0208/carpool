import 'package:carpool/unity/my_api.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AccountEdit extends StatefulWidget {
  final String accID, accCode, accFullname, accNickname, accTel, accLine;
  const AccountEdit(
      {super.key,
      required this.accID,
      required this.accCode,
      required this.accFullname,
      required this.accNickname,
      required this.accTel,
      required this.accLine});

  @override
  State<AccountEdit> createState() => _AccountEditState();
}

class _AccountEditState extends State<AccountEdit> {
  String? accCode, accFullname, accNickname, accTel, accLine;
  String? loaddata = 'no';

  @override
  void initState() {
    super.initState();
    setState(() {
      accCode = '${widget.accCode}';
      accFullname = '${widget.accFullname}';
      accNickname = '${widget.accNickname}';
      accTel = '${widget.accTel}';
      accLine = '${widget.accLine}';
    });
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
                    : SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 60, left: 10, right: 10, bottom: 10),
                              child: Material(
                                color: const Color.fromARGB(155, 255, 255, 255),
                                borderRadius: BorderRadius.circular(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('รหัสพนักงาน',
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      buildCode(context),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text('ชื่อ-นามสกุล',
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      buildFullname(),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text('ชื่อเล่น',
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      buildNickname(context),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text('เบอร์โทรศัพท์',
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      buildTel(),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text('Line ID',
                                              style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      buildLine(),
                                      SizedBox(height: 15),
                                      Spacer(),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(MyStyle().color1),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    20.0), // Adjust corner radius
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            checkNullText();
                                          },
                                          child: Text(
                                            'บันทึก',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                'แก้ไขรายชื่อ',
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

  Row buildCode(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50,
          child: TextFormField(
            initialValue: accCode,
            onChanged: (value) {
              setState(() {
                accCode = value.trim();
              });
            },
            style: TextStyle(
                color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'รหัสพนักงาน',
              hintStyle: TextStyle(
                  fontSize: 18.0, color: Color.fromARGB(255, 184, 184, 184)),
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
              filled: true,
              fillColor: Color.fromARGB(255, 241, 241, 241),
            ),
          ),
        ),
      ],
    );
  }

  Row buildNickname(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50,
          child: TextFormField(
            initialValue: accNickname,
            onChanged: (value) {
              setState(() {
                accNickname = value.trim();
              });
            },
            style: TextStyle(
                color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
            decoration: InputDecoration(
              hintText: 'ชื่อเล่น',
              hintStyle: TextStyle(
                  fontSize: 18.0, color: Color.fromARGB(255, 184, 184, 184)),
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
              filled: true,
              fillColor: Color.fromARGB(255, 241, 241, 241),
            ),
          ),
        ),
      ],
    );
  }

  Container buildFullname() {
    return Container(
      height: 50,
      child: TextFormField(
        initialValue: accFullname,
        onChanged: (value) {
          setState(() {
            accFullname = value.trim();
          });
        },
        style:
            TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
        decoration: InputDecoration(
          hintText: 'ชื่อ - นามสกุล',
          hintStyle: TextStyle(
              fontSize: 18.0, color: Color.fromARGB(255, 184, 184, 184)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
          filled: true,
          fillColor: Color.fromARGB(255, 241, 241, 241),
        ),
      ),
    );
  }

  Container buildLine() {
    return Container(
      height: 50,
      child: TextFormField(
        initialValue: accLine,
        onChanged: (value) {
          setState(() {
            accLine = value.trim();
          });
        },
        style:
            TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
        decoration: InputDecoration(
          hintText: 'Line ID',
          hintStyle: TextStyle(
              fontSize: 18.0, color: Color.fromARGB(255, 184, 184, 184)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
          filled: true,
          fillColor: Color.fromARGB(255, 241, 241, 241),
        ),
      ),
    );
  }

  Container buildTel() {
    return Container(
      height: 50,
      child: TextFormField(
        initialValue: accTel,
        onChanged: (value) {
          setState(() {
            accTel = value.trim();
          });
        },
        style:
            TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'เบอร์โทรศัพท์',
          hintStyle: TextStyle(
              fontSize: 18.0, color: Color.fromARGB(255, 184, 184, 184)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
          filled: true,
          fillColor: Color.fromARGB(255, 241, 241, 241),
        ),
      ),
    );
  }

  Future<Null> checkNullText() async {
    if (accCode == '' ||
        accCode!.isEmpty ||
        accFullname == '' ||
        accFullname!.isEmpty ||
        accNickname == '' ||
        accNickname!.isEmpty ||
        accLine == '' ||
        accLine!.isEmpty ||
        accTel == '' ||
        accTel!.isEmpty) {
      print(accLine);
      MyPopup().showError(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
    } else {
      showDialogConfirm();
    }
  }

  Future<String?> showDialogConfirm() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ยืนยันการบันทึก'),
        content: const Text('ตรวจสอบข้อมูลให้ดีก่อนทำการบันทึก'),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: MyStyle().showSizeTextSC(context, 'ปิด', 20, Colors.red)),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                insertData();
              },
              child: MyStyle().showSizeTextSC(
                  context, 'บันทึก', 20, Color.fromARGB(255, 54, 130, 244))),
        ],
      ),
    );
  }

  Future<void> insertData() async {
    var url = Uri.parse(
        '${MyConstant().domain}/carpool/authen/updateEditProfile.php');

    var response = await http.post(
      url,
      body: {
        'Acc_ID': '${widget.accID}',
        'Acc_Code': accCode!,
        'Acc_Fullname': accFullname!,
        'Acc_Nickname': accNickname!,
        'Acc_Tel': accTel!,
        'Acc_Line': accLine!,
      },
    );

    if (response.statusCode == 200) {
      MyPopup().showToast(context, 'แก้ไขข้อมูลสำเร็จ');
      MyApi().insertLogEvent('แก้ไขข้อมูลส่วนตัว');
      Navigator.pop(context);
    } else {
      // Error
      print('Error');
    }
  }
}
