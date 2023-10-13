import 'package:cd_whatsapp_clone/CustomUI/ButtonCard.dart';
import 'package:cd_whatsapp_clone/Model/ChatModel.dart';
import 'package:cd_whatsapp_clone/Screens/Homescreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel sourceChat;
  List<ChatModel> chatModels = [
    ChatModel(
      name: "Barat Ahmed",
      isGroup: false,
      currentMessage: "Cherished Dream",
      time: "14.23",
      icon: "person.svg",
      id: 1
    ),
    ChatModel(
      name: "Shah Rukh",
      isGroup: false,
      currentMessage: "Flying Colours",
      time: "3.56",
      icon: "person.svg",
      id: 2

    ),
    ChatModel(
      name: "ABC",
      isGroup: false,
      currentMessage: "Favourite Person",
      time: "3.56",
      icon: "person.svg", id: 3

    ),
    // ChatModel(
    //   name: "Bangladeshi People",
    //   isGroup: true,
    //   currentMessage: "We are brave nation.",
    //   time: "17.50",
    //   icon: "groups.svg",
    // ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatModels.length,
        itemBuilder: (context,index)=>
            InkWell(
                onTap: (){
                  sourceChat = chatModels.removeAt(index);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Homescreen(chatModels: chatModels,sourceChat: sourceChat,)));
                },
                child: ButtonCard(name: chatModels[index].name,icon: Icons.person))
      ),
    );
  }
}
