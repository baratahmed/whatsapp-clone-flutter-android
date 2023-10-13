import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:cd_whatsapp_clone/CustomUI/OwnFileCard.dart';
import 'package:cd_whatsapp_clone/CustomUI/OwnMessageCard.dart';
import 'package:cd_whatsapp_clone/CustomUI/ReplyCard.dart';
import 'package:cd_whatsapp_clone/CustomUI/ReplyFileCard.dart';
import 'package:cd_whatsapp_clone/Model/ChatModel.dart';
import 'package:cd_whatsapp_clone/Model/MessageModel.dart';
import 'package:cd_whatsapp_clone/Screens/CameraScreen.dart';
import 'package:cd_whatsapp_clone/Screens/CameraView.dart';
// import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';


class IndividualPage extends StatefulWidget {
  IndividualPage({Key key, this.chatModel, this.sourceChat}) : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourceChat;
  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  IO.Socket socket;
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  ImagePicker _picker = ImagePicker();
  XFile file;
  int popTime = 0;


  @override
  void initState() {
    // TODO: implement initState
    connect();
    super.initState();
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        setState((){
          show = false;
        });
      }
    });
  }

  void connect(){
    socket = IO.io("https://limitless-lowlands-13375.herokuapp.com/",<String, dynamic>{
      "transports":["websocket"],
      "autoConnect":false,
    });
    socket.connect();
    socket.emit('signin',widget.sourceChat.id);
    socket.onConnect((data) {
      socket.on("message",(msg){
        setMessage(msg["txtMessage"],"destination", msg["path"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
  }
  
  void sendMessage(String txtMessage, int sourceId, int targetId, String path){
    setMessage(txtMessage,"source", path);
    socket.emit("message",{"txtMessage":txtMessage, "sourceId":sourceId, "targetId":targetId, "path":path});
  }

  void setMessage(String message, String type, String path){
      MessageModel messageModel = MessageModel(message: message, type: type, time: DateTime.now().toString().substring(10,16), path: path);
      setState(() {
        messages.add(messageModel);
      });
  }

  void onImageSend(String path, String message) async {
      print("Hey there is a $path");
      for(int i=0; i<popTime; i++){
          Navigator.pop(context);
      }
      setState(() {
        popTime=0;
      });
      var request = http.MultipartRequest("POST",Uri.parse("https://limitless-lowlands-13375.herokuapp.com/routes/addimage"));
      request.files.add(await http.MultipartFile.fromPath("img", path));
      request.headers.addAll({
        "Content-type": "multipart/form-data",
      });
      // var response = request.send();
      // print(response);
      http.StreamedResponse response = await request.send();
      var httpResponse = await http.Response.fromStream(response);
      var data = json.decode(httpResponse.body);
      print(data['path']);
      setMessage(message,"source", path);
      socket.emit("message",{"txtMessage":message, "sourceId":widget.sourceChat.id, "targetId":widget.chatModel.id, "path":data['path']});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/whatsapp_back.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 70,
            titleSpacing: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: 23,
                  ),
                  CircleAvatar(
                    child: SvgPicture.asset(
                      widget.chatModel.isGroup
                          ? "assets/groups.svg"
                          : "assets/person.svg",
                      color: Colors.white,
                      height: 30,
                      width: 30,
                    ),
                    radius: 20,
                    backgroundColor: Colors.blueGrey,
                  ),
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.name,
                      style: TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Last seen today at 12:23",
                      style: TextStyle(
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
              IconButton(icon: Icon(Icons.call), onPressed: () {}),
              PopupMenuButton(onSelected: (val) {
                print(val);
              }, itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text('View Contact'),
                    value: 'View Contact',
                  ),
                  PopupMenuItem(
                    child: Text('Media, links & docs'),
                    value: 'Media, links & docs',
                  ),
                  PopupMenuItem(
                    child: Text('Whatsapp Web'),
                    value: 'Whatsapp Web',
                  ),
                  PopupMenuItem(
                    child: Text('Search'),
                    value: 'Search',
                  ),
                  PopupMenuItem(
                    child: Text('Mute Notification'),
                    value: 'Mute Notification',
                  ),
                  PopupMenuItem(
                    child: Text('Wallpaper'),
                    value: 'Wallpaper',
                  ),
                ];
              }),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index){
                        if(index == messages.length){
                          return Container(
                            height: 70,
                          );
                        }
                        if(messages[index].type == "source"){
                           if(messages[index].path.length > 0){
                             return OwnFileCard(path: messages[index].path, message: messages[index].message,time: messages[index].time,);
                           }else{
                             return OwnMessageCard(
                               txtMessage: messages[index].message,
                               time: messages[index].time,
                             );
                           }
                        }else{
                          if(messages[index].path.length > 0){
                            return ReplyFileCard(path: messages[index].path, message: messages[index].message,time: messages[index].time,);
                          }else{
                            return ReplyCard(
                              txtMessage: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 55,
                                child: Card(
                                  margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                  ),
                                  child: TextFormField(
                                    controller: _controller,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value){
                                      if(value.length > 0){
                                        setState(() {
                                            sendButton = true;
                                        });
                                      }else{
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      contentPadding: EdgeInsets.all(5),
                                      prefixIcon: IconButton(
                                        icon: Icon(Icons.emoji_emotions),
                                        onPressed: (){
                                          setState(() {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                            show = !show;
                                          });
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(icon: Icon(Icons.attach_file), onPressed: (){
                                            showModalBottomSheet(
                                              backgroundColor: Colors.transparent,
                                              context: context,
                                               builder: (builder) =>
                                                bottomSheet()
                                            );
                                          }),
                                          IconButton(icon: Icon(Icons.camera_alt), onPressed: (){
                                            setState(() {
                                              popTime = 2;
                                            });
                                            Navigator.push(context, MaterialPageRoute(builder: (builder)=> CameraScreen(onImageSend: onImageSend,)));
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0,right: 5, left: 2),
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFF128C7E),
                                  radius: 23,
                                  child: IconButton(
                                    icon: Icon(sendButton ? Icons.send : Icons.mic, color: Colors.white,),
                                    onPressed: (){
                                      if(sendButton){
                                        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                                        sendMessage(_controller.text, widget.sourceChat.id, widget.chatModel.id,"");
                                        _controller.clear();
                                        setState(() {
                                          sendButton = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiSelect() : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onWillPop: (){
                if(show){
                  setState(() {
                    show = false;
                  });
                }else{
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet(){
    return Container(
    height: 278,
    width: MediaQuery.of(context).size.width,
    child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.insert_drive_file, Colors.indigo,"Documents",(){}),
                  SizedBox(width: 40,),
                  iconCreation(Icons.camera_alt, Colors.pink,"Camera",(){
                    setState(() {
                      popTime = 3;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=> CameraScreen(onImageSend: onImageSend,)));
                  }),
                  SizedBox(width: 40,),
                  iconCreation(Icons.insert_photo, Colors.purple,"Gallery",()async{
                    setState(() {
                      popTime = 2;
                    });
                     file = await _picker.pickImage(source: ImageSource.gallery);
                     Navigator.push(context, MaterialPageRoute(builder: (builder)=> CameraViewPage(path: file.path,onImageSend: onImageSend,)));
                  })
                ],
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange,"Audio",(){}),
                  SizedBox(width: 40,),
                  iconCreation(Icons.location_pin, Colors.teal,"Location",(){}),
                  SizedBox(width: 40,),
                  iconCreation(Icons.person, Colors.blue,"Contact",(){})
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text, Function onTap){
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              color: Colors.white,
              size: 29,
            ),
          ),
          SizedBox(height: 5),
          Text(text, style: TextStyle(fontSize: 12),),
        ],
      ),
    );
  }

  Widget emojiSelect(){
    // return EmojiPicker(
    //     rows: 4,
    //     columns: 7,
    //     onEmojiSelected: (emoji, category){
    //       //print(emoji);
    //       setState(() {
    //         _controller.text = _controller.text + emoji.emoji;
    //       });
    //     });
    return Container();
  }
}
