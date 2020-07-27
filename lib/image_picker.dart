import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PicUpload extends  StatefulWidget {
  static String id = 'PicUpload';
  @override
  _PicUploadState createState() => _PicUploadState();
}

class _PicUploadState extends State<PicUpload> {

  Future<File> imageFile;
  File imageFileReturn;

  Future openGallery(ImageSource source) async {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage(){
    return FutureBuilder(
        future: imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot){
          imageFileReturn = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Image.file(
              snapshot.data,
              width: 400,
              height: 400,
            );
          } else if (snapshot.error != null) {
            return const Text(
              'Error Picking Image',
              textAlign: TextAlign.center,
            );
          } else {
            return const Text(
              'No Image Selected',
              textAlign: TextAlign.center,
            );
          }
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showImage(),
            RaisedButton(
              child: Text("Select Image from Gallery"),
              onPressed: () {
                openGallery(ImageSource.gallery);
              },
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context, imageFileReturn);
              },
              child: Text('Select Finish, Go back '),
            ),
          ],
        ),
      ),
    );
  }
}

