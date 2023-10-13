import 'package:cd_whatsapp_clone/CustomUI/AvatarCard.dart';
import 'package:cd_whatsapp_clone/CustomUI/ButtonCard.dart';
import 'package:cd_whatsapp_clone/CustomUI/ContactCard.dart';
import 'package:cd_whatsapp_clone/Model/ChatModel.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Dev Stack", status: "A full stack developer"),
    ChatModel(name: "Barat Ahmed", status: "Software Engineer"),
    ChatModel(name: "Saket", status: "Web developer..."),
    ChatModel(name: "Bhanu Dev", status: "App developer...."),
    ChatModel(name: "Collins", status: "Raect developer.."),
    ChatModel(name: "Kishor", status: "Full Stack Web"),
    ChatModel(name: "Testing1", status: "Example work"),
    ChatModel(name: "Testing2", status: "Sharing is caring"),
    ChatModel(name: "Divyanshu", status: "....."),
    ChatModel(name: "Helper", status: "Love you Mom Dad"),
    ChatModel(name: "Tester", status: "I find the bugs"),
  ];
  List<ChatModel> groupmember = [

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Add participants",
              style: TextStyle(
                fontSize: 13,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 26,
              ),
              onPressed: (){}
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: contacts.length + 1,
            itemBuilder:  (context, index){
              if(index == 0){
                return Container(
                  height: groupmember.length>0 ? 90 : 5,
                );
              }
              return InkWell(
                  onTap: (){
                    if(contacts[index-1].select == false){
                      setState(() {
                        contacts[index-1].select = true;
                        groupmember.add(contacts[index-1]);
                      });
                    }else{
                      setState(() {
                        contacts[index-1].select = false;
                        groupmember.remove(contacts[index-1]);
                      });
                    }
                  },
                  child: ContactCard(contact: contacts[index-1])
              );
            },
          ),
          groupmember.length>0 ? Column(
            children: [
              Container(
                height: 75,
                color: Colors.white,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: contacts.length,
                  itemBuilder: (context,index){
                    if(contacts[index].select == true){
                      return InkWell(
                          onTap: (){
                            setState(() {
                              groupmember.remove(contacts[index]);
                              contacts[index].select = false;
                            });
                          },
                          child: AvatarCard(chatModel: contacts[index])
                      );
                    }else{
                      return Container();
                    }
                  },
                ),
              ),
              Divider(
                thickness: 1,
              ),
            ],
          ) : Container(),
        ],
      ),
    );
  }
}
