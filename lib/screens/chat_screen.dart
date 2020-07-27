import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }catch(e){
      print(e);
    }
  }
/*
  void getMessages() async {
    try{
      final messages = await _fireStore.collection('messages').getDocuments();
      if (messages != null){
        for(var message in messages.documents){
          print(message.data);
        }
      }
    }catch(e){
      print(e);
    }
  }*/

  void messageStream() async {
    await for(var snapshot in  _fireStore.collection('messages').snapshots()){
      for(var message in snapshot.documents){
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
               _auth.signOut();
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Container(decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessageStream(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                          //Do something with the user input.
                        },
                        decoration: kMessageTextFieldDecoration,
                          style: TextStyle(color: Colors.grey[900]),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        messageTextController.clear();
                        _fireStore.collection('messages').add({
                          'text':messageText,
                          'sender': loggedInUser.email},
                        );
                        //Implement send functionality.
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ), );
          }
          final messages = snapshot.data.documents.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.data['text'];
            final messageSender = message.data['sender'];

            final currentUser = loggedInUser.email;

            if(currentUser == messageSender){
              //The message is from logged in user.

            }

            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );

        });
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isMe});
  final String text;
  final String sender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    CrossAxisAlignment crossAxisAlignment;
    Color color;
    Color textColor;
    if(isMe == true){
      crossAxisAlignment = CrossAxisAlignment.end;
      color = Colors.lightBlueAccent;
      textColor = Colors.white;
    }
    else{
      crossAxisAlignment = CrossAxisAlignment.start;
      color = Colors.white;
      textColor = Colors.grey[700];
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text('$sender',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black
            ),),
          Material(
            borderRadius: isMe ? BorderRadius.only(topLeft: Radius.circular(30.0), bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0)) :
            BorderRadius.only(topRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: color,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Text(
                  '$text',
              style: TextStyle(
                color: textColor,
                fontSize: 15.0
              ),),
            )
          ),
        ],
      ),
    );
  }
}

