import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyPopup {
  sendingEmail(BuildContext context) {
    Scaffold alert = Scaffold(
      backgroundColor: Color.fromARGB(0, 255, 193, 7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 210,
              width: 210,
              decoration: new BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: new BorderRadius.circular(30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      child: Image.asset('images/email.gif')),
                  Container(
                    height: 20,
                  ),
                  Text(
                    'กำลังส่ง...',
                    style: TextStyle(
                        color: Color.fromARGB(255, 75, 75, 75), fontSize: 23),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showProcessing(BuildContext context) {
    Scaffold alert = Scaffold(
      backgroundColor: Color.fromARGB(0, 255, 193, 7),
      body: Container(),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showError(BuildContext context, String? string) {
    Scaffold alert = Scaffold(
      backgroundColor: Color.fromARGB(59, 0, 0, 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: new BoxDecoration(
                  color: Color.fromARGB(228, 233, 233, 233),
                  borderRadius: new BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      child: Image.asset('images/error.gif'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'ผิดพลาด!!',
                      style: TextStyle(
                          color: Color.fromARGB(255, 41, 41, 41), fontSize: 25),
                    ),
                    SizedBox(height: 10),
                    Text(
                      string!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255, 75, 75, 75), fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: 40,
                        child: Center(
                            child: Text('ปิด',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 84, 141, 206),
                                    fontSize: 20))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showToast(BuildContext context, String? string) {
    final scaffold = ScaffoldMessenger.of(context);
    Fluttertoast.showToast(
        msg: ('    $string!    '),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(148, 63, 63, 63),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void showToastError(BuildContext context, String? string) {
    Fluttertoast.showToast(
        msg: ('    $string!    '),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(209, 212, 92, 92),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Center showLoadData() {
    return Center(
      child: Container(
        height: 210,
        width: 210,
        decoration: new BoxDecoration(
            color: Color.fromARGB(193, 233, 233, 233),
            borderRadius: new BorderRadius.circular(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 120,
                width: 120,
                child: Image.asset('images/loading1.gif')),
            Container(
              height: 35,
            ),
            Text(
              'กำลังโหลด...',
              style: TextStyle(
                  color: Color.fromARGB(255, 75, 75, 75), fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  MyPopup();
}
