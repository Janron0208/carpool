import 'package:carpool/unity/my_api.dart';
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
  String mileage = '0';
  String carStatus = 'No';
  final List<String> items = ['TOYOTA', 'ISUZU'];
  String? selectedValue;
  String carBrand = 'TOYOTA';

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
                    : SingleChildScrollView(
                        child: GestureDetector(
                          onTap: () =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.95,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 50, left: 0, right: 0, bottom: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(122, 218, 218, 218),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text('ยี่ห้อรถยนต์',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: MyStyle()
                                                              .color1)),
                                                ],
                                              ),
                                              SizedBox(height: 3),
                                              Material(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: buildBrand(),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Material(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(122, 218, 218, 218),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text('รุ่น/รหัสโมเดล',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: MyStyle()
                                                              .color1)),
                                                ],
                                              ),
                                              SizedBox(height: 3),
                                              buildModel(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Material(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(122, 218, 218, 218),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text('ป้ายทะเบียน',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: MyStyle()
                                                              .color1)),
                                                ],
                                              ),
                                              SizedBox(height: 3),
                                              buildNumber(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Material(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromARGB(122, 218, 218, 218),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text('เลขไมล์',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: MyStyle()
                                                              .color1)),
                                                ],
                                              ),
                                              SizedBox(height: 3),
                                              buildMile(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(MyStyle().color3),
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
                                      )
                                    ],
                                  ),
                                )),
                          ),
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

  Row buildBrand() {
    return Row(
      children: [
        SizedBox(width: 10),
        Container(
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
              inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(0, 146, 105, 105)), //<-- SEE HERE
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 5.0),
              )),
        ),
      ],
    );
  }

  Container buildNumber() {
    return Container(
      height: 60,
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
              fontSize: 20, color: Color.fromARGB(255, 184, 184, 184)),
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
      height: 60,
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
              fontSize: 20, color: Color.fromARGB(255, 184, 184, 184)),
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

  Container buildMile() {
    return Container(
      height: 60,
      child: TextFormField(
        initialValue: '0',
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            mileage = value.trim();
          });
        },
        style:
            TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 20),
        decoration: InputDecoration(
          hintText: 'เลขไมล์ล่าสุด',
          hintStyle: TextStyle(
              fontSize: 20, color: Color.fromARGB(255, 184, 184, 184)),
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

  Future<Null> checkNullText() async {
    if (carBrand == null ||
        carBrand!.isEmpty ||
        carModel == null ||
        carModel!.isEmpty ||
        carNumber == null ||
        carNumber!.isEmpty ||
        mileage == null ||
        mileage!.isEmpty) {
      MyPopup().showError(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
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
                          MyStyle().showSizeTextSC(
                              context,
                              'ยืนยันการเพิ่มรถยนต์',
                              18,
                              Color.fromARGB(255, 29, 29, 29)),
                          SizedBox(height: 20),
                          Center(
                            child: MyStyle().showSizeTextSC(
                                context,
                                'ต้องการเพิ่มรถยนต์ทะเบียน $carNumber หรือไม่',
                                22,
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
                              insertData();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Center(
                                child: Text('ยืนยัน',
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

  Map<String, String> data = {};

  Future<void> insertData() async {
    print('$carBrand , $carModel ,$carNumber,$mileage ,$carStatus');

    var response = await http.post(
      Uri.parse('${MyConstant().domain}/carpool/car/insertCar.php'),
      body: data = {
        'Car_Brand': carBrand,
        'Car_Model': carModel!,
        'Car_Number': carNumber!,
        'Car_Mileage': mileage,
        'Car_Status': carStatus,
      },
    );

    if (response.statusCode == 200) {
      MyPopup().showToast(context, 'เพิ่มรถยนต์สำเร็จ');
      MyApi().insertLogEvent('เพิ่มรถยนต์ใหม่ทะเบียน ${carNumber!}');
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      // Error
      print('Error');
    }
  }
}
