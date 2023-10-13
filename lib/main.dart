import 'package:camera/camera.dart';
import 'package:cd_whatsapp_clone/NewScreen/LandingScreen.dart';
import 'package:cd_whatsapp_clone/Screens/CameraScreen.dart';
import 'package:cd_whatsapp_clone/Screens/Homescreen.dart';
import 'package:cd_whatsapp_clone/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CD Whats App',
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: Color(0xFF075E54),
        accentColor: Color(0xFF128C7E),
      ),
      home: LoginScreen(),
    );
  }
}
