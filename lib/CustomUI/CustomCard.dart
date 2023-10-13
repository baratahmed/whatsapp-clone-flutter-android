import 'package:cd_whatsapp_clone/Model/ChatModel.dart';
import 'package:cd_whatsapp_clone/Screens/IndividualPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key key, this.chatModel,this.sourceChat}) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourceChat;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualPage(chatModel: chatModel,sourceChat: sourceChat,)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: SvgPicture.asset(
                chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg",
                color: Colors.white,
                height: 30,
                width: 30,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(
              chatModel.name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  chatModel.currentMessage,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: Text(chatModel.time),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80, right: 20),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
