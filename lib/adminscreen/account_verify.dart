import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carpool/adminscreen/account_detail.dart';
import 'package:carpool/models/user_model.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:carpool/unity/my_style.dart';

class AccountVerify extends StatefulWidget {
  const AccountVerify({super.key});

  @override
  State<AccountVerify> createState() => _AccountVerifyState();
}

class _AccountVerifyState extends State<AccountVerify> {
  String? loaddata = 'yes';
  String? havedata = 'no';
  String chooseType = 'รอตรวจสอบ';
  List<UserModel> userModels = [];
  String formpage = 'verify';

  @override
  void initState() {
    checkchooseType();
    super.initState();
  }

  void checkchooseType() async {
    if (chooseType == 'รอตรวจสอบ') {
      loadUserTypePending();
    } else {
      loadUserTypeUnauthorized();
    }
  }

  void loadUserTypePending() async {
    userModels.clear();

    final url = await Uri.parse(
      '${MyConstant().domain}/carpool/authen/getUserByStatus.php?Acc_Status=Pending',
    );

    http.Response response = await http.get(url);

    var data = json.decode(response.body);

    for (var item in data) {
      UserModel userModel = UserModel.fromJson(item);
      setState(() {
        userModels.add(userModel);
        print(userModels.length);
      });
    }
    setState(() {
      print(havedata);
      loaddata = 'no';
    });
  }

  void loadUserTypeUnauthorized() async {
    userModels.clear();

    final url = await Uri.parse(
      '${MyConstant().domain}/carpool/authen/getUserByStatus.php?Acc_Status=Unauthorized',
    );

    http.Response response = await http.get(url);

    var data = json.decode(response.body);

    for (var item in data) {
      UserModel userModel = UserModel.fromJson(item);
      setState(() {
        userModels.add(userModel);
        print(userModels.length);
      });
    }

    setState(() {
      print(havedata);
      loaddata = 'no';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MyStyle().BG_PinkPurple(context),
          SafeArea(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 60, left: 10, right: 10, bottom: 10),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                chooseType == 'รอตรวจสอบ'
                                                    ? Colors.white
                                                    : Color.fromARGB(
                                                        40, 24, 24, 24)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ))),
                                    onPressed: () {
                                      setState(() {
                                        chooseType = 'รอตรวจสอบ';
                                        loaddata = 'yes';
                                        checkchooseType();
                                      });
                                    },
                                    child: Text(
                                      'รอตรวจสอบ',
                                      style: TextStyle(
                                        color: chooseType == 'รอตรวจสอบ'
                                            ? Color.fromARGB(255, 53, 53, 53)
                                            : Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                            chooseType == 'ไม่ผ่าน'
                                                ? Colors.white
                                                : Color.fromARGB(
                                                    40, 24, 24, 24)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                                side: BorderSide(
                                                    color: const Color.fromARGB(
                                                        0, 244, 67, 54))))),
                                    onPressed: () {
                                      setState(() {
                                        chooseType = 'ไม่ผ่าน';
                                        loaddata = 'yes';
                                        checkchooseType();
                                      });
                                    },
                                    child: Text(
                                      'ไม่ผ่าน',
                                      style: TextStyle(
                                        color: chooseType == 'ไม่ผ่าน'
                                            ? Color.fromARGB(255, 53, 53, 53)
                                            : Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  )),
                                ],
                              )),
                          Expanded(
                            flex: 12,
                            child: Material(
                              borderRadius: BorderRadius.circular(0),
                              elevation: 8,
                              child: loaddata == 'yes'
                                  ? showCircularProgressIndicator()
                                  : ListView.builder(
                                      itemCount: userModels.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            color: index % 2 == 0
                                                ? const Color.fromARGB(
                                                    255, 255, 255, 255)
                                                : Color.fromARGB(
                                                    255, 219, 219, 219),
                                            height: 60,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Row(children: [
                                                  Expanded(
                                                      flex: 4,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 19),
                                                        child: Text(
                                                            '${userModels[index].accFullname!} (${userModels[index].accNickname!})'),
                                                      )),
                                                  Expanded(
                                                      flex: 2,
                                                      child: MyStyle().showTextSCW(
                                                          '${userModels[index].accType!}',
                                                          18,
                                                          FontWeight.normal,
                                                          userModels[index]
                                                                      .accType ==
                                                                  'admin'
                                                              ? Colors.red
                                                              : Colors.green)),
                                                  Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            print(
                                                                '${userModels[index].accID!}');
                                                            MaterialPageRoute
                                                                route =
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AccountDetail(
                                                                              accID: userModels[index].accID!,
                                                                              formpage: formpage,
                                                                            ));
                                                            Navigator.push(
                                                                    context,
                                                                    route)
                                                                .then((value) {
                                                              userModels
                                                                  .clear();
                                                              checkchooseType();

                                                              setState(() {
                                                                havedata = 'no';
                                                                loaddata =
                                                                    'yes';
                                                              });
                                                            });
                                                          },
                                                          icon: Icon(Icons
                                                              .search_outlined))),
                                                ])));
                                      }),
                            ),
                          ),
                        ],
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

  Center showCircularProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
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
                'อนุมัติสิทธิ',
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
