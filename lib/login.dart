import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/users_chats.dart';

import 'homepage.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const String id = 'login_page';
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('FriendSpace',
        style: TextStyle(
          fontFamily: 'Lobster',
          fontSize: 30.0,
          color: Colors.black
        ),),
      ),
      body:
        ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(10.0),
                width: 300.0,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your Email'
                  ),
                  onChanged: (value){
                    email = value;
                  },
                ),
              ),
            ),
          Center(
            child: Container(
              padding: EdgeInsets.all(10.0),
              width: 300.0,
              child: TextField(
                obscureText: true,
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                    labelText: 'Password',
                    fillColor: Colors.teal,
                    hintText: 'Enter Your Password'
                ),
                onChanged: (value){
                  password = value;
                },
              ),
            ),
          ),
              RoundedButton(
                text: 'Log In',
                onPressed: () async {
                  setState((){
                    showSpinner = true;
                  });
                  try{
                    final existingUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if (existingUser != null){
                      Navigator.pushNamed(context, UsersChats.id);
                    }
                    showSpinner = false;
                  }catch(e) {
                    print(e);
                  }
                  },
              )]),
        ),
    );
  }
}
