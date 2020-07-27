import 'package:flash_chat/Uploader/caption.dart';
import 'package:flash_chat/friends.dart';
import 'package:flash_chat/homepage.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/users.dart';
import 'package:flash_chat/users_chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        )
      ),
      initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          HomePage.id: (context) => HomePage(),
          Caption.id: (context) => Caption(),
          Friends.id: (context) => Friends(),
          UsersChats.id: (context) => UsersChats(),
          UsersAccount.id: (context) => UsersAccount(),
          LoginScreen.id: (context) => LoginScreen(),
          ChatScreen.id : (context) => ChatScreen(),
          RegistrationScreen.id : (context) => RegistrationScreen(),
        }
    );
  }
}

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;
 final List<String> categories = ['CHATS','STATUS','CALLS','POSTS','ROOMS','CHANNEL','MAP'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index){
        return Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            categories[index],
            style: TextStyle(
                fontSize: 12.0,

            ),

          ),
        );
      }),
    );
  }
}

