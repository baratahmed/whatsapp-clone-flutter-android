import 'package:cd_whatsapp_clone/Model/ChatModel.dart';
import 'package:cd_whatsapp_clone/Pages/CameraPage.dart';
import 'package:cd_whatsapp_clone/Pages/ChatPage.dart';
import 'package:cd_whatsapp_clone/Pages/StatusPage.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key key, this.chatModels, this
  .sourceChat}):super(key: key);
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1,);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: Text('CD Whats App'),
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: (){}),
            PopupMenuButton(
                onSelected: (val){
                    print(val);
                },
                itemBuilder: (BuildContext context){
              return [
                PopupMenuItem(child: Text('New Group'), value: 'New Group',),
                PopupMenuItem(child: Text('New Broadcast'), value: 'New Broadcast',),
                PopupMenuItem(child: Text('Whatsapp Web'), value: 'Whatsapp Web',),
                PopupMenuItem(child: Text('Starred Messages'), value: 'Starred Messages',),
                PopupMenuItem(child: Text('Messages'), value: 'Messages',),
              ];
            })
          ],
          bottom: TabBar(
            controller: _controller,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.camera_alt),
              ),
              Tab(
                text: 'CHATS'
              ),
              Tab(
                  text: 'STATUS'
              ),
              Tab(
                  text: 'CALLS'
              ),
            ],
          ),
        ),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraPage(),
          ChatPage(
            chatModels: widget.chatModels,
            sourceChat: widget.sourceChat,
          ),
          StatusPage(),
          Text('Four'),
        ],
      ),
    );
  }
}
