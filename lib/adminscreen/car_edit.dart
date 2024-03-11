import 'package:flutter/material.dart';
import 'package:carpool/unity/my_popup.dart';

class CarEdit extends StatefulWidget {
  const CarEdit({super.key});

  @override
  State<CarEdit> createState() => _CarEditState();
}

class _CarEditState extends State<CarEdit> {
  String? loaddata = 'no';
  

  @override
  void initState() {
    // loadCarByIDCar();
    super.initState();
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
          showBlackground(context),
            SafeArea(
              child: Stack(
                children: [
                 loaddata == 'yes'
        ? MyPopup().showLoadData()
        : Container(
                    width: MediaQuery.of(context).size.width * 1,height:MediaQuery.of(context).size.height * 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60,left: 10,right: 10,bottom: 10),
                      child: Column(
                        children: [
                          
                        ],
                      )
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
    return Container(width: MediaQuery.of(context).size.width * 1,height:50,
                      child: Row(
            children: [
              Expanded(flex: 1, child: IconButton(onPressed: (){ Navigator.pop(context); }, icon: Icon(Icons.arrow_back_ios,size: 30,color: Colors.white))),
              Expanded(flex: 3, child: Text('รายการรถยนต์',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)),
              Expanded(flex: 1, child: IconButton(onPressed: (){
                  
               }, icon: Icon(Icons.add_circle,size: 30,color: Colors.white))),
            ],
                      ),
                    );
  }

  Container showBlackground(BuildContext context) {
    return Container(width: MediaQuery.of(context).size.width * 1,height: MediaQuery.of(context).size.height * 1,
            child: Image.asset('images/bg2.jpg',fit: BoxFit.cover,),
          );
  }


}