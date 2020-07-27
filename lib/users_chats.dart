import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/friends.dart';
import 'package:flash_chat/models/chat_models.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class UsersChats extends StatefulWidget {
  static String id = 'Users Chat';
  @override
  _UsersChatsState createState() => _UsersChatsState();
}

class _UsersChatsState extends State<UsersChats>  {

  final _auth = FirebaseAuth.instance;

  void getNewUser() async {
    try{
      final newUser = await _auth.currentUser();
    }catch(e){
      print(e);
    }

  }
  static List<ChatModel> list = ChatModel.list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black12,
        title: Text('Chats',
        style: TextStyle(
          fontSize: 32
        ),),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.filter,
              color: Colors.blue,),
              onPressed: null)
        ],
      ),
      body: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search,
                color: Colors.white54,),
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      /*image: DecorationImage(image:
                      ExactAssetImage("assets/")
                      )*/
                    ),
                  ),
                  title: Text(list[index].contact.name,
                    style: TextStyle(
                      color: Colors.white),),
                  subtitle: list[index].isTyping
                      ? Row(
                        children: <Widget>[
                          Text('typing', style: TextStyle(color: Colors.blue),),
                          SizedBox(width: 10.0),
                          SpinKitThreeBounce(
                            color: Colors.blue,
                            size: 20.0,
                        ),
                       ],)
                      : Row(
                      children: <Widget>[
                        Text(list[index].lastMessage,
                          style: TextStyle(
                            color: Colors.white54
                        ),),
                        SizedBox(width: 25.0),
                        Text(list[index].lastMessageTime + "days ago",
                          style: TextStyle(
                              color: Colors.white54
                          ),),
                    ],
                  ),

                );
            },),),
      ],),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white24,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.white12,
              icon : Icon(Icons.home),
              title: Container(),
            ),
            BottomNavigationBarItem(
              icon : Icon(Icons.live_tv),
              title: Container(),
            ),
            BottomNavigationBarItem(
              icon : Icon(Icons.notifications),
              title: Container(),
            ),
            BottomNavigationBarItem(
              icon : GestureDetector(
                      child: Icon(Icons.chat),
                      onTap: (){
                        Navigator.pushNamed(context, ChatScreen.id);
                      },
              ),
              title: Container(),
            ),
            BottomNavigationBarItem(
              icon : GestureDetector(
                      child: Icon(Icons.menu),
                      onTap: (){
                        Navigator.pushNamed(context, Friends.id);
                      },
              ),
              title: Container(),
            ),
          ]),
    );
  }
}


