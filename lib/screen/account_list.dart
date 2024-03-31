import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carpool/screen/account_detail.dart';
import 'package:carpool/models/user_model.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:http/http.dart' as http;
import 'package:carpool/unity/my_style.dart';

class AccountList extends StatefulWidget {
  const AccountList({super.key});

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  String? loaddata = 'yes';
  List<UserModel> userModels = [];
  String accStatus = 'Actived';
  String formpage = 'Acclist';

  @override
  void initState() {
    loadUserTypeActived();
    super.initState();
  }

  void loadUserTypeActived() async {
    final url = await Uri.parse(
      '${MyConstant().domain}/carpool/authen/getUserByStatus.php?Acc_Status=$accStatus',
    );

    http.Response response = await http.get(url);

    var data = json.decode(response.body);

    for (var item in data) {
      UserModel userModel = UserModel.fromJson(item);
      setState(() {
        userModels.add(userModel);
        print(userModels.length);
      });

      setState(() {
        loaddata = 'no';
      });

      // String passData = item['Car_Number'];

      // print(passData);

      // print('Password : ${item['Acc_Password']}');
      // if (item['Acc_Password'] == null) {
      //   print('ไม่มีข้อมูล');
      // } else {
      //   print('มีข้อมูล');
      // }
      // print('Acc_Code: ${item['Acc_Code']}');
      // print('Acc_Name: ${item['Acc_Fullame']}');
      // print('Acc_Email: ${item['Acc_Nickname']}');
      // print('--------------------');
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
                            padding: EdgeInsets.only(
                                top: 60, left: 5, right: 5, bottom: 5),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 8,
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Material(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        color:
                                            Color.fromARGB(255, 119, 119, 119),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 4,
                                                  child: MyStyle()
                                                      .showSizeTextSC(
                                                          context,
                                                          'ชื่อผู้ใช้',
                                                          23,
                                                          Colors.white)),
                                              Expanded(
                                                  flex: 2,
                                                  child: MyStyle()
                                                      .showSizeTextSC(
                                                          context,
                                                          'ประเภท',
                                                          23,
                                                          Colors.white)),
                                              Expanded(
                                                  flex: 1, child: Text(' ')),
                                            ],
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                    flex: 35,
                                    child: ListView.builder(
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Row(children: [
                                                    Expanded(
                                                        flex: 4,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 19),
                                                          child: MyStyle()
                                                              .showSizeTextS(
                                                                  context,
                                                                  '${userModels[index].accFullname!} (${userModels[index].accNickname!})',
                                                                  29),
                                                        )),
                                                    Expanded(
                                                        flex: 2,
                                                        child: MyStyle().showSizeTextSCW(
                                                            context,
                                                            '${userModels[index].accType!}',
                                                            23,
                                                            FontWeight.normal,
                                                            userModels[index]
                                                                        .accType ==
                                                                    'admin'
                                                                ? Colors.red
                                                                : Colors
                                                                    .green)),
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
                                                                  .then(
                                                                      (value) {
                                                                // carModels.clear();
                                                                // loadAllCar();
                                                              });
                                                            },
                                                            icon: Icon(Icons
                                                                .search_outlined))),
                                                  ])));
                                        }),
                                  ),
                                ],
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
                'รายชื่อผู้ใช้ระบบ',
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
