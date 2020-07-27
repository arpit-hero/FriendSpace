import 'contacts_models.dart';

class ChatModel {
  ChatModel({this.isTyping, this.lastMessage, this.lastMessageTime, this.contact});
 final bool isTyping;
 final String lastMessage;
 final String lastMessageTime;
 final ContactModel contact;

 static List<ChatModel> list = [
   ChatModel(
    isTyping: true,
    lastMessage: "hello",
    lastMessageTime: "2d",
    contact: ContactModel(name: "Peter Parker")
   ),
   ChatModel(
       isTyping: false,
       lastMessage: "hello",
       lastMessageTime: "2d",
       contact: ContactModel(name: "Peter Parker")
   ),
   ChatModel(
       isTyping: false,
       lastMessage: "hello",
       lastMessageTime: "2d",
       contact: ContactModel(name: "Peter Parker")
   ),
 ];
}