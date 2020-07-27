import 'dart:io';

import 'package:flash_chat/Uploader/uploader.dart';
import 'package:flash_chat/profile_image_upload.dart';
import 'package:flash_chat/profile_pic_upload.dart';
import 'package:flutter/material.dart';

class Caption extends StatefulWidget {
  static String id = 'caption';
  @override
  _CaptionState createState() => _CaptionState();
}

class _CaptionState extends State<Caption> {
  TextEditingController _controller;
  Map<int, File> imageFileMap = {};
  File imageFile;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: FlatButton(
              textColor: Colors.black,
              onPressed: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          title: Padding(
            padding: const EdgeInsets.only(right:40.0),
            child: Text('New Post',
            style: TextStyle(color: Colors.black),),
          ),

        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: CircleAvatar(),
                ),
                Container(
                  //padding: EdgeInsets.only(right: 30.0, top: 30.0, left: 8 ),
                  width: 270.0,
                  child: TextField(
                    onChanged: (value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Write a caption...',
                      hintStyle: TextStyle(color: Colors.grey),

                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        child: SizedBox(
                          child: imageFile != null ? Image.file(imageFile, ) : Container(
                            child: Text('No Image Found'),
                            height: 30.0,
                            width: 10.0,),
                        ),
                      ),
                    ),
                    IconButton(
                        tooltip: 'Edit',
                        icon: Icon(Icons.image, color: Colors.blue,),
                        onPressed: () async {
                          imageFile = await Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => PostImageUpload()
                          )
                          );
                          setState(() {

                          });
                        }
                    ),
                  ],
                ),



              ],
              ),
            SizedBox(
              width: 300.0,
              child: Divider(color: Colors.grey,),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Tag People',
                    style: TextStyle(
                      fontSize: 15.0
                    ),),
                  SizedBox(
                    width: 300.0,
                    height: 20.0,
                    child: Divider(color: Colors.grey,),
                  ),
                  Text('Add Location',
                    style: TextStyle(
                      fontSize: 15.0
                    ),),
                  SizedBox(
                    width: 300.0,
                    height: 20.0,
                    child: Divider(color: Colors.grey,),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right:212.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Also Post to',
                      style: TextStyle(
                        fontSize: 15
                      ),),
                    SizedBox(height: 10.0,),
                    Text('Facebook',style: TextStyle(
                        fontSize: 15
                    ),),
                    SizedBox(height: 10.0,),
                    Text('Twitter',style: TextStyle(
                        fontSize: 15
                    ),),
                    SizedBox(height: 10.0,),
                    Text('Instagram',style: TextStyle(
                        fontSize: 15
                    ),),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right:8.0, left: 8),
                child: Uploader(file: imageFile,),
              ),
            ),
          ])
        ),
    );}

}
