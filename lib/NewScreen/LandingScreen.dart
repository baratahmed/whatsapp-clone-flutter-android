import 'package:cd_whatsapp_clone/NewScreen/LoginPage.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Text(
                "Welcome to WhatsApp",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 29,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 25,),
              Image.asset("assets/bg.png",height: 340, width: 340,),
              SizedBox(height: MediaQuery.of(context).size.height / 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                    text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                  children: [
                    TextSpan(
                      text: "Agree and Continue to accept the",
                      style: TextStyle(
                        color: Colors.grey[600]
                      ),
                    ),
                    TextSpan(
                      text: " WhatsApp Terms of Service and Privacy Policy",
                      style: TextStyle(
                          color: Colors.cyan
                      ),
                    ),
                  ]
                )),
              ),
              SizedBox(height: 35,),
              InkWell(
                onTap: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>LoginPage()), (route) => false);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 110,
                  height: 40,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    elevation: 8,
                    color: Colors.greenAccent[700],
                    child: Center(
                      child: Text(
                        "AGREE AND CONTINUE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
