import 'package:carpool/unity/my_style.dart';
import 'package:flutter/material.dart';

class ReserveAdd extends StatefulWidget {
  const ReserveAdd({super.key});

  @override
  State<ReserveAdd> createState() => _ReserveAddState();
}

class _ReserveAddState extends State<ReserveAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(206, 102, 102, 102),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.42,
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(20)),
            child: Column(
              children: [
                Row(
                  children: [
                    MyStyle().showTextSCW('   กรอกข้อมูลการจอง ', 19,
                        FontWeight.bold, MyStyle().color1),
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
                    height: MediaQuery.of(context).size.height * 0.36,
                    // color: Colors.amber,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: MyStyle().showTextSC(
                                    'วันที่เบิกใช้รถ : ',
                                    16,
                                    MyStyle().color3)),
                            Expanded(
                                flex: 4,
                                child: MyStyle().showTextSC(
                                    'วันที่จองรถ : ', 17, MyStyle().color1)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: MyStyle().showTextSC(
                                    'ผู้เบิกใช้รถ : ', 16, MyStyle().color3)),
                            Expanded(
                                flex: 4,
                                child: MyStyle().showTextSC(
                                    'ฟหกฟกฟหกฟหกฟ ', 17, MyStyle().color1)),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            MyStyle().showTextSC('โครงการ/งาน/สถานที่/จังหวัด',
                                17, MyStyle().color3),
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(
                          // height: 200,
                          child: TextFormField(
                            maxLines: 3,
                            // onChanged: (value) {
                            //   setState(() {
                            //     line = value.trim();
                            //   });
                            // },
                            style: TextStyle(
                                color: Color.fromARGB(255, 112, 112, 112),
                                fontSize: 18),
                            decoration: InputDecoration(
                              hintText: 'กรุณากรอกข้อมูล',
                              hintStyle: TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromARGB(255, 184, 184, 184)),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 241, 241, 241),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                              // CheckNullText();

                              // print('$code , $password');
                            },
                            child: Text(
                              'ทำการจอง',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
    );
  }
}
