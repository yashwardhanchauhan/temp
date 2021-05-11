import 'package:Translator/Home.dart';
import 'package:Translator/Login.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child:SplashScreen(
      title: Text("Translator",
          style: TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold)),
      loadingText: Text("Loading...",style:TextStyle(fontWeight: FontWeight.bold)),
      seconds: 10,
      navigateAfterSeconds: Login(),
      image: Image.asset('assest/Translator.png'),
      photoSize: 150,
      backgroundColor: Colors.grey[300],
      loaderColor: Colors.teal,
    ));
  }
}
