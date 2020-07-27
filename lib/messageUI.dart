import 'package:flash_chat/userUI.dart';

class Message {
  User sender;
  final String time;
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.isLiked,
    this.unread
});
}
final User currentUser = User(id: 0,
                              name: 'Current User',
                              imageUrl: 'assets/images/greg.jpg');
List<Message> chats = [
  Message(
    sender: currentUser,
    time: '5:30 pm',
    text: 'hey',
    isLiked: false,
    unread: true,
  ),
];
