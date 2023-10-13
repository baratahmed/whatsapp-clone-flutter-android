class ChatModel{
  String name, icon, time, currentMessage, status;
  int id;
  bool isGroup, select = false;
  ChatModel({this.name, this.icon, this.isGroup, this.time, this.currentMessage, this.status, this.select = false,this.id});
}