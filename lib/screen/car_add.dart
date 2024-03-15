import 'package:flutter/material.dart';
import 'package:carpool/unity/my_constant.dart';
import 'package:carpool/unity/my_popup.dart';
import 'package:http/http.dart' as http;
import 'package:carpool/unity/my_style.dart';

class CarAdd extends StatefulWidget {
  const CarAdd({super.key});

  @override
  State<CarAdd> createState() => _CarAddState();
}

class _CarAddState extends State<CarAdd> {
  String? loaddata = 'no';
  String? carModel, carNumber;
  String carStatus = 'Ready';
  final List<String> items = ['TOYOTA', 'ISUZU'];
  String? selectedValue;
  String carBrand = 'TOYOTA';

  @override
  void initState() {
    print('object');
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
                              borderRadius: BorderRadius.circular(20),
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('ยี่ห้อรถยนต์',
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    SizedBox(height: 3),
                                    buildBrand(),
                                    SizedBox(height: 25),
                                    Row(
                                      children: [
                                        Text('รุ่น/รหัสโมเดล',
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    SizedBox(height: 3),
                                    buildModel(),
                                    SizedBox(height: 25),
                                    Row(
                                      children: [
                                        Text('ป้ายทะเบียน',
                                            style: TextStyle(fontSize: 20)),
                                      ],
                                    ),
                                    SizedBox(height: 3),
                                    buildNumber(),
                                    Spacer(),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color.fromARGB(
                                                      255, 209, 209, 209)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20.0), // Adjust corner radius
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          print('object');
                                          insertData();
                                        },
                                        child: Text(
                                          'บันทึก',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    )
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

  Row buildBrand() {
    return Row(
      children: [
        Container(
          height: 50,
          child: DropdownMenu<String>(
            initialSelection: items.first,
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                carBrand = value!;
              });
            },
            dropdownMenuEntries:
                items.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Container buildNumber() {
    return Container(
      height: 70,
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            carNumber = value.trim();
          });
        },
        style:
            TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
        decoration: InputDecoration(
          hintText: 'ป้ายทะเบียน',
          hintStyle: TextStyle(
              fontSize: 25, color: Color.fromARGB(255, 184, 184, 184)),
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

  Container buildModel() {
    return Container(
      height: 70,
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            carModel = value.trim();
          });
        },
        style:
            TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
        decoration: InputDecoration(
          hintText: 'รุ่น/รหัสโมเดล',
          hintStyle: TextStyle(
              fontSize: 25, color: Color.fromARGB(255, 184, 184, 184)),
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
                'เพิ่มรถยนต์',
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

  Container showBlackground(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: Image.asset(
        'images/bg2.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Map<String, String> data = {};

  Future<void> insertData() async {
    print('$carBrand , $carModel ,$carNumber ,$carStatus');

    var response = await http.post(
      Uri.parse('${MyConstant().domain}/carpool/car/insertCar.php'),
      body: data = {
        'Car_Brand': carBrand!,
        'Car_Model': carModel!,
        'Car_Number': carNumber!,
        'Car_Status': carStatus,
      },
    );

    if (response.statusCode == 200) {
      // Success
      print('Success');
    } else {
      // Error
      print('Error');
    }
  }
}
