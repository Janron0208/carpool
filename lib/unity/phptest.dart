import 'dart:convert';

import 'package:carpool/unity/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhpTest extends StatefulWidget {
  const PhpTest({super.key});

  @override
  State<PhpTest> createState() => _PhpTestState();
}

class _PhpTestState extends State<PhpTest> {
  @override
  void initState() {
    super.initState();
  }

  Future<Null> readCarIdFormCarTB() async {
    var url =
        Uri.parse('${MyConstant().domain}/carpool/car/getCarChooseDay.php');
    http.Response response = await http.get(url);
    var data = json.decode(response.body);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              IconButton(
                  onPressed: () {
                    readCarIdFormCarTB();
                  },
                  icon: Icon(
                    Icons.power_settings_new_rounded,
                    size: 30,
                    color: Colors.red,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
