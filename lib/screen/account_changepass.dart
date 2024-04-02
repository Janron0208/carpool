import 'package:carpool/unity/my_api.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AccountChangePass extends StatefulWidget {
  final String accID;
  const AccountChangePass({super.key, required this.accID});

  @override
  State<AccountChangePass> createState() => _AccountChangePassState();
}

class _AccountChangePassState extends State<AccountChangePass> {
  String? loaddata = 'no';
  String? accPass;
  String? accPass2;
  String obscureText = 'hide';
  String obscureText2 = 'hide';
  @override
  void initState() {
    super.initState();
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
                            child: Material(
                              color: const Color.fromARGB(155, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('กรอกรหัสผ่านใหม่',
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    buildPass1(context),
                                    SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Text('กรอกรหัสผ่านใหม่อีกครั้ง',
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    buildPass2(context),
                                    SizedBox(height: 5),
                                    accPass2 == null
                                        ? Container()
                                        : Text(
                                            accPass == accPass2
                                                ? ''
                                                : '**รหัสผ่านไม่ตรงกัน**',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16),
                                          ),
                                    Spacer(),
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
                                                  20.0), // Adjust corner radius
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          checkNullText();
                                        },
                                        child: Text(
                                          'เปลี่ยนรหัสผ่าน',
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
                'เปลี่ยนรหัสผ่าน',
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

  Row buildPass1(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 60,
          child: TextFormField(
            obscureText: obscureText == 'show' ? false : true,
            onChanged: (value) {
              setState(() {
                accPass = value.trim();
              });
            },
            style: TextStyle(
                color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(obscureText == 'show'
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    if (obscureText == 'show') {
                      setState(() {
                        obscureText = 'hide';
                        print(obscureText);
                      });
                    } else {
                      setState(() {
                        obscureText = 'show';
                        print(obscureText);
                      });
                    }
                  }),
              hintText: 'รหัสผ่าน',
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

  Row buildPass2(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 60,
          child: TextFormField(
            obscureText: obscureText2 == 'show' ? false : true,
            onChanged: (value) {
              setState(() {
                accPass2 = value.trim();
              });
            },
            style: TextStyle(
                color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(obscureText2 == 'show'
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    if (obscureText2 == 'show') {
                      setState(() {
                        obscureText2 = 'hide';
                      });
                    } else {
                      setState(() {
                        obscureText2 = 'show';
                      });
                    }
                  }),
              hintText: 'รหัสผ่าน',
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

  Future<Null> checkNullText() async {
    if (accPass == '' ||
        accPass!.isEmpty ||
        accPass2 == '' ||
        accPass2!.isEmpty) {
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
        content: const Text('ตรวจสอบรหัสผ่านให้ดีก่อนทำการบันทึก'),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: MyStyle().showSizeTextSC(context, 'ปิด', 20, Colors.red)),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                insertData();
              },
              child: MyStyle().showSizeTextSC(context, 'เปลี่ยนรหัส', 20,
                  Color.fromARGB(255, 54, 130, 244))),
        ],
      ),
    );
  }

  Future<void> insertData() async {
    var url =
        Uri.parse('${MyConstant().domain}/carpool/authen/updateChangePass.php');

    var response = await http.post(
      url,
      body: {'Acc_ID': '${widget.accID}', 'Acc_Password': accPass!},
    );

    if (response.statusCode == 200) {
      MyPopup().showToast(context, 'เปลี่ยนรหัสผ่านสำเร็จ');
      MyApi().insertLogEvent('เปลี่ยนรหัสผ่าน');
      Navigator.pop(context);
    } else {
      // Error
      print('Error');
    }
  }
}
