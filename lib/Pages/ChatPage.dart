import 'package:cd_whatsapp_clone/CustomUI/CustomCard.dart';
import 'package:cd_whatsapp_clone/Model/ChatModel.dart';
import 'package:cd_whatsapp_clone/Screens/SelectContact.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key, this.chatModels, this.sourceChat}):super(key: key);
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: Icon(Icons.message),
      ),
      body: ListView.builder(
        itemCount: widget.chatModels.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: widget.chatModels[index],
          sourceChat: widget.sourceChat,
        ),
      ),
    );
  }
}
