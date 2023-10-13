import 'dart:io';
import 'package:flutter/material.dart';

class ReplyFileCard extends StatelessWidget {

  ReplyFileCard({Key key, this.path, this.message, this.time}):super(key: key);
  final String path;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: MediaQuery.of(context).size.height/ 2.3,
          width: MediaQuery.of(context).size.width/ 1.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[400]
          ),
          child: Card(
            margin: EdgeInsets.all(1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height/ 2.3,
              width: MediaQuery.of(context).size.width/ 1.8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green[300]
              ),
              child: Card(
                margin: EdgeInsets.all(1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Image.network("https://limitless-lowlands-13375.herokuapp.com/uploads/$path", fit: BoxFit.fitHeight,),
                    Text(message),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
