import 'package:flutter/material.dart';
import 'package:Translator/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Translator/routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash_Screen(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
    onGenerateRoute: RouteGen.generateRoute,
    );
  }
}
