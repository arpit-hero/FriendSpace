import 'package:flutter/material.dart';

import 'messageUI.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          topLeft: Radius.circular(30.0),
        ),
        child: ListView.builder(itemBuilder: (BuildContext context, int index){
          final Message chat = chats[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context, MaterialPageRoute( builder: (_) => ChatScreen(

            ))
            ),
            child: Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 35.0,

                      ),
                      SizedBox(width: 10.0,),
                      Column(
                        children: <Widget>[
                          Text('text'),
                          SizedBox(),
                          Container(
                           child: Text("texted") ,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }),

      )

    );
  }
}
