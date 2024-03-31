import 'dart:io';
import 'dart:typed_data';

import 'package:carpool/unity/my_constant.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class SavePic extends StatefulWidget {
  const SavePic({super.key});

  @override
  State<SavePic> createState() => _SavePicState();
}

File? _pickedimage;
Uint8List webImage = Uint8List(8);

class _SavePicState extends State<SavePic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('savePic'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text('File path: $_filePath'),
            _pickedimage == null
                ? Container()
                : Container(
                    width: 100, height: 100, child: Image.memory(webImage)),
            ElevatedButton(
              onPressed: () {
                chooseImage();
              },
              child: Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }

  Future chooseImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (image != null) {
      var f = await image.readAsBytes();
      setState(() {
        webImage = f;
        _pickedimage = File('a');
        // print(_pickedimage);
        saveFileToDataBase();
      });
    }
  }

  Future<void> saveFileToDataBase() async {
    String nameFile = 'test.jpg';

    String apiSaveHistory = '${MyConstant().domain}/carpool/savePicWeb.php';

    Map<String, dynamic> map = {
      'file': MultipartFile.fromBytes(webImage, filename: nameFile),
    };

    FormData data = FormData.fromMap(map);

    await Dio().post(apiSaveHistory, data: data);
  }
}
