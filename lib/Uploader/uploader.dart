import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Uploader extends StatefulWidget {
  Uploader({Key key, this.file}) : super(key:key);
  final File file;


  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://friendspace-fd530.appspot.com/');

  StorageUploadTask _uploadTask;

  void _startUpload(){
    String filePath = 'images/${DateTime.now()}.png';
    try{
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
    }catch(e){
      print("Uploading failed due to $e");
    }

  }

  @override
  Widget build(BuildContext context) {
    if(_uploadTask != null){
      return StreamBuilder(
          stream: _uploadTask.events,
          builder: (context, snapshot){
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _uploadTask.isComplete ?
                          Image.asset('images/done.jpg',
                            width: 30.0,
                            height: 30.0,
                          ) : FlatButton(
                        child: Icon(Icons.play_arrow, color: Colors.grey,),
                        onPressed: _uploadTask.resume,
                      ),
                      _uploadTask.isPaused ?
                      FlatButton(
                        child: Icon(Icons.play_arrow, color: Colors.grey,),
                        onPressed: _uploadTask.resume,
                      ) : FlatButton(
                          onPressed: _uploadTask.pause,
                          child: Icon(Icons.pause, color: Colors.grey,),
                      ),

                    ],
                  ),
                ),

                LinearProgressIndicator(value: progressPercent, backgroundColor: Colors.white12,valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[900]),),
                Text('${(progressPercent*100).toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0
                  ),)
              ],
            );
          });

    }else{
      return FlatButton(
          child: Text('Share',
            style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 19.0,
            ),),
          onPressed: _startUpload,
      );
    }
    return Container();
  }
}
