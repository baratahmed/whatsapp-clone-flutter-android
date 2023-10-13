import 'package:cd_whatsapp_clone/Model/CountryModel.dart';
import 'package:cd_whatsapp_clone/NewScreen/CountryPage.dart';
import 'package:cd_whatsapp_clone/NewScreen/OtpScreen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}):super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String countryName = "Bangladesh";
  String countryCode = "+88";
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Enter your phone number",
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            wordSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          Icon(
            Icons.more_vert,
            color: Colors.black,
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(
              "Whatsapp will send you an sms to verify your number",
              style: TextStyle(
                fontSize: 13.5,
              ),
            ),
            SizedBox(height: 5,),
            Text(
              "What's my number?",
              style: TextStyle(
                fontSize: 12.8,
                color: Colors.cyan[800],
              ),
            ),
            SizedBox(height: 15,),
            countryCard(),
            SizedBox(height: 5,),
            number(),
            Expanded(child: Container()),
            InkWell(
              onTap: (){
                if(_textEditingController.text.length < 10){
                  showMyDialogue2();
                }else{
                  showMyDialogue1();
                }
              },
              child: Container(
                height: 40,
                width: 70,
                color: Colors.tealAccent[400],
                child: Center(
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),


          ],
        ),
      ),
    );
  }

  Widget countryCard(){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (builder)=> CountryPage(setCountryData: setCountryData,)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.teal,
              width: 1.8,
            )
          ),
        ),
        child: Row(
          children: [
            Expanded(child: Container(
              child: Center(
                child: Text(countryName, style: TextStyle(fontSize: 16),),
              ),
            )),
            Icon(Icons.arrow_drop_down, color: Colors.teal, size: 28,),
          ],
        ),
      ),
    );
  }

  Widget number(){
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 38,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 70,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.teal,
                  width: 1.8,
                )
              )
            ),
            child: Row(
              children: [
                SizedBox(width: 13,),
                Text("+", style: TextStyle(fontSize: 18),),
                SizedBox(width: 10,),
                Text(countryCode.substring(1), style: TextStyle(fontSize: 15),),

              ],
            ),
          ),
          SizedBox(width: 30,),
          Container(
            width: MediaQuery.of(context).size.width / 1.5 - 100,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: Colors.teal,
                      width: 1.8,
                    )
                )
            ),
            child: TextFormField(
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8),
                hintText: "Phone Number",
              ),
            )
          ),
        ],
      ),
    );
  }

  void setCountryData(CountryModel countryModel){
    setState(() {
      countryName = countryModel.name;
      countryCode = countryModel.code;
    });
    Navigator.pop(context);
  }

  Future<void> showMyDialogue1(){
      return showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("We will be verifying your phone number", style: TextStyle(fontSize: 14),),
                    SizedBox(height: 10,),
                    Text(countryCode + " " + _textEditingController.text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                    SizedBox(height: 10,),
                    Text("Is this Ok? or would you like to edit the number?", style: TextStyle(fontSize: 13.5),),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Edit")),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder) => OtpScreen(countryCode: countryCode, number: _textEditingController.text,)));
                }, child: Text("Ok"))
              ],
            );
          }
      );
  }

  Future<void> showMyDialogue2(){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("There is no number you entered", style: TextStyle(fontSize: 14),),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Ok"))
            ],
          );
        }
    );
  }
}
