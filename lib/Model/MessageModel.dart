import 'package:flutter/material.dart';

class MessageModel{
  String message;
  String type;
  String time;
  String path;
  MessageModel({this.message,this.type, this.time, @required this.path});
}