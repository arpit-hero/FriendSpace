import 'dart:io';
import 'package:flash_chat/Friends.dart';
import 'package:flash_chat/Uploader/caption.dart';
import 'package:flash_chat/Uploader/uploader.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/user_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flash_chat/screens/welcome_screen.dart';

class ProfilePicUpload extends StatefulWidget {
  static const String id = 'ProfilePicUpload';
  @override
  _ProfilePicUploadState createState() => _ProfilePicUploadState();
}

class _ProfilePicUploadState extends State<ProfilePicUpload> {

  File _image;
  final imagePicker = ImagePicker();

  Future getImage(ImageSource source) async{
    final pickedImage = await imagePicker.getImage(source: source);
    final bytes = await pickedImage.readAsBytes();

    setState(() {
      _image = File(pickedImage.path);
      UserData(image: _image);
      print('Image Path is $_image');
      print('Image size in bytes is $bytes');
    });
  }

  Future captureImage(ImageSource source) async {
    final capturedImage = await imagePicker.getImage(source: source);
    final bytes = await capturedImage.readAsBytes();

    setState(() {
      _image = File(capturedImage.path);
      if(_image!=null){
        UserData(image: _image);
      }
      print('Image Path is $_image');
      print('Image size in bytes is $bytes');
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _image.path,
        cropStyle: CropStyle.circle,
    );
    setState(() {
      _image = cropped ?? _image;
    });
  }
  void _clearImage(){
    setState(() => _image = null);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
          IconButton(icon: Icon(Icons.photo_camera), onPressed: (){
            captureImage(ImageSource.camera);
          }),
          IconButton(icon: Icon(Icons.photo_library), onPressed: (){
            setState(() {
              captureImage(ImageSource.gallery);
            });
          }),
        ],),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 500,
                width: 500,
                child: Center(
                        child: _image == null
                        ? Text('No Image Selected'):
                          Image.file(_image,),
                      ),),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      child: Icon(Icons.crop),
                      onPressed: _cropImage,
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      child: Icon(Icons.refresh),
                      onPressed: _clearImage,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Caption()));
                },
              child: Icon(Icons.navigate_next),

            ),
          ),
        ],
      ),
    );
  }
}