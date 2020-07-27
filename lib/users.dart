import 'dart:io';
import 'package:flash_chat/Friends.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/user_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flash_chat/screens/welcome_screen.dart';

class UsersAccount extends StatefulWidget {
  static const String id = 'user_screen';
  @override
  _UsersAccountState createState() => _UsersAccountState();
}

class _UsersAccountState extends State<UsersAccount> {

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
         Image.file(_image);
      }
      print('Image Path is $_image');
      print('Image size in bytes is $bytes');
    });
  }
/*
  Future<void>retrieveLostData() async {
    final LostData response = await imagePicker.getLostData();
    if (response == null){
        return;
    }
    if(response.file != null){
      setState(() {
        if (response.type == RetrieveType.video) {
          exception(response.file);
        }
      });
    }
  }*/

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Profile Photo'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  getImage(ImageSource.camera);
                },
                child: Icon(Icons.camera),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              GestureDetector(
                onTap: (){
                  getImage(ImageSource.gallery);
                },
                child: Icon(Icons.image),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Profile'),
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);},
            child: Icon(Icons.backspace)),
             ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(30.0),
              padding: EdgeInsets.all(50.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(70.0)),
              ),
              child: Center(
                child: _image == null
                    ? Text('No Image Selected'):
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70.0,
                    child: Image.file(_image,)),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                onPressed: (){
                  _showChoiceDialog(context);
                },
              child: Icon(Icons.camera,)
                ),
                Container(
                  padding: EdgeInsets.all(30.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person, color: Colors.teal,),
                        SizedBox(width: 30.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                            Text('Name'),
                            Text('Your Name'),
                            Text('Description'),
                          ],),
                        ),
                        SizedBox(width: 100.0),
                        Icon(Icons.edit, color: Colors.grey,),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.all(30.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.description, color: Colors.teal,),
                        SizedBox(width: 30.0,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('About'),
                              Text('Description'),
                            ],
                          ),
                        ),
                        SizedBox(width: 100.0,),
                        Icon(Icons.edit, color: Colors.grey,),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(30.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.phone, color: Colors.teal,),
                        SizedBox(width: 30.0,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Phone'),
                              Text('+1 716 817 3402'),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            )

          ],),
      )

    );
  }
}
