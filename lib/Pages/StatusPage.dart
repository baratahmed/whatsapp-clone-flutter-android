import 'package:cd_whatsapp_clone/CustomUI/StatusPage/HeadOwnStatus.dart';
import 'package:cd_whatsapp_clone/CustomUI/StatusPage/OtherStatus.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48,
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
              onPressed: (){},
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
          SizedBox(height: 13,),
          FloatingActionButton(
            onPressed: (){},
            backgroundColor: Colors.greenAccent[700],
            elevation: 5,
            child: Icon(
              Icons.camera_alt,

            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 10,),
            HeadOwnStatus(),
            label("Recent Updates"),
            OtherStatus(
              name: "Person One",
              imageName: "assets/2.jpeg",
              time: "12:56",
              isSeen: false,
              statusNum: 15,
            ),
            OtherStatus(
              name: "Person Two",
              imageName: "assets/3.jpg",
              time: "12:56",
              isSeen: false,
              statusNum: 2,
            ),
            OtherStatus(
              name: "Person Three",
              imageName: "assets/1.jpg",
              time: "12:56",
              isSeen: false,
              statusNum: 3,
            ),
            SizedBox(height: 10,),
            label("Viewed Updates"),
            OtherStatus(
              name: "Person One",
              imageName: "assets/2.jpeg",
              time: "12:56",
              isSeen: true,
              statusNum: 1,
            ),
            OtherStatus(
              name: "Person Two",
              imageName: "assets/3.jpg",
              time: "12:56",
              isSeen: true,
              statusNum: 2,
            ),
            OtherStatus(
              name: "Person Three",
              imageName: "assets/1.jpg",
              time: "12:56",
              isSeen: true,
              statusNum: 10,
            ),
          ],
        ),
      ),
    );
  }
  Widget label(String labelName){
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        child: Text(labelName, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
      ),
    );
  }
}

