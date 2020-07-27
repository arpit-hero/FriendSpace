import 'package:flutter/material.dart';
import 'package:flash_chat/chatScreen.dart';

class HomePage extends StatefulWidget {
  static String id = 'home page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
          appBar:AppBar(
            backgroundColor: Colors.teal[800],
            title:Text('Chat',
              style: TextStyle(
                color: Colors.white,
              ),),
            actions: <Widget>[
              Icon(Icons.search),
            ],
            bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text('CHATS'),
                      ),
                      Tab(
                        child: Text('STATUS'),
                      ),
                      Tab(
                        child: Text('CALLS'),
                      ),
                      Tab(
                        child: Text('POSTS'),
                      ),
                      Tab(
                        child: Text('ROOMS'),
                      ),
                      Tab(
                        child: Text('CHANNEL'),
                      ),
                      Tab(
                        child: Text('MAP'),
                      )
                    ]),
                preferredSize: Size.fromHeight(30.0)),

          ),
          body:TabBarView(
            children: <Widget>[
                ChatScreen(),
              ChatScreen(),
              ChatScreen(),
              ChatScreen(),
              ChatScreen(),
              ChatScreen(),
              ChatScreen(),
            ],
          ),
      ),
    );
  }
}
