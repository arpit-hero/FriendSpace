import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flash_chat/Uploader/caption.dart';
import 'package:flash_chat/user_data.dart';
import 'package:flash_chat/users.dart';
import 'package:flutter/material.dart';


class Friends extends StatefulWidget {
  static String id = 'Friends list';
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

  List<Contact> contacts = [];
/*
  getFriends() async {
    await for(var friendsSnapshot in _fireStore.collection('Friends').snapshots()){
      for(var friend in friendsSnapshot.documents){
        print('New Friend is $friend');
        print('$friendsSnapshot');
      }
    }
  }*/

  @override
  void initState() {
    super.initState();
    getAllContacts();
  }

  void getAllContacts() async {
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    File image = UserData().image;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: Column(
        children: <Widget>[
        ListView.builder(
            shrinkWrap: true,
            itemCount: contacts.length,
            itemBuilder: (context, index){
              Contact contact = contacts[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    setState(() async {
                      Navigator.pushNamed(context, Caption.id);
                      image = UserData().image;
                    });
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              image: DecorationImage(image: image != null ?
                                ExactAssetImage("$image") : ExactAssetImage("images/logo.png", scale: 10.0)
                                ),
                            ),
                          ),
                          title: Text(contacts[index].displayName,
                            style: TextStyle(
                                color: Colors.black),),
                          subtitle: Text(contacts[index].phones.elementAt(0).value,
                              style: TextStyle(color: Colors.grey[600]),),
                        ),Center(
                          child: SizedBox(
                            height: 20.0,
                            child: Divider(
                              color: Colors.teal,
                              endIndent: 12.0,
                            ),
                            width: 312.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ],),
    );
  }
}


