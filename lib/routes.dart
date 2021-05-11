import 'package:Translator/signup.dart';
import 'package:flutter/material.dart';
import 'package:Translator/main.dart';
import 'package:Translator/Login.dart';
import 'package:Translator/image_to_text.dart';
import 'package:Translator/text_to_text.dart';
import 'package:Translator/voice_to_text.dart';
import 'package:Translator/Home.dart';

class RouteGen {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyApp());
      case '/login':
        return MaterialPageRoute(builder: (context) => Login());
      case '/signup':
        return MaterialPageRoute(builder: (context) => SignupPage());
      case '/home':
        return MaterialPageRoute(builder: (context) => Home());
      case '/third':
        if (arg == 'text')
          return MaterialPageRoute(builder: (context) => MyText());
        else if (arg == "image")
          return MaterialPageRoute(builder: (context) => MyImage());
        else if (arg == "voice")
          return MaterialPageRoute(builder: (context) => Myvoice());
    }
  }
}
