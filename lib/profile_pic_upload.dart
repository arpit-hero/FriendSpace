import 'dart:io';

import 'package:flash_chat/profile_image_upload.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PostImageUpload extends StatefulWidget {
  @override
  _PostImageUploadState createState() => _PostImageUploadState();
}

class _PostImageUploadState extends State<PostImageUpload> {
  
  Future<File> image;
  File imageReturn;
  
  Future selectImage(ImageSource source) async{
    setState(() {
      image = ImagePicker.pickImage(source: source);
    });
  }
  Future captureImage(ImageSource source) async {
    final capturedImage = await ImagePicker.pickImage(source: source);
    final bytes = await capturedImage.readAsBytes();

    setState(() {
      image = File(capturedImage.path) as Future<File>;

      print('Image Path is $image');
      print('Image size in bytes is $bytes');
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      //sourcePath: image.path,
      cropStyle: CropStyle.circle,
    );
    setState(() {
      image = cropped ?? image;
    });
  }
  void _clearImage(){
    setState(() => image = null);
  }

  Widget showImage(){
    return FutureBuilder(
        future: image,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot){
          imageReturn = snapshot.data;
          if(snapshot.connectionState == ConnectionState.done
              &&  snapshot.data != null ){
            return Image.file(
              snapshot.data,
              width: 500.0,
              height: 500.0,
            );
          } else if (snapshot.error != null){
            return const Text(
              'Error while selecting Image',
              textAlign: TextAlign.center,
            );
          } else {
            return const Text(
              'No Image Selected',
              textAlign: TextAlign.center,
            );
          }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(icon: Icon(Icons.photo_camera), onPressed: (){
            captureImage(ImageSource.camera);
          }),
          IconButton(icon: Icon(Icons.photo_library), onPressed: (){
            setState(() {
              selectImage(ImageSource.gallery);
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
                  child: image == null
                      ? Text('No Image Selected'):
                  showImage(),
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
                Navigator.pop(context, imageReturn);
              },
              child: Icon(Icons.navigate_next),

            ),
          ),
        ],
      ),
    );
  }
}
