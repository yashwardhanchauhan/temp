import 'package:flutter/material.dart';
import 'package:Translator/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("/login");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      this.user = firebaseUser;
      this.isloggedin = true;
    }
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    child:Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Option below",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
              ),
              onPressed: () => signOutUser().whenComplete(
                  () => Navigator.of(context).pushNamed("/login")))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: MyRadioWidget(),
      ),
    ));
  }
}

var options = ['text', 'image', 'voice'];

class MyRadioWidget extends StatefulWidget {
  @override
  _MyRadioWidgetState createState() => _MyRadioWidgetState();
}

class _MyRadioWidgetState extends State<MyRadioWidget> {
  var _site = options[0];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Text(
            "Translation Type",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            title: const Text('Translate into Text',
                style: TextStyle(fontSize: 20.0)),
            leading: Radio(
              value: options[0],
              activeColor:Colors.blue ,
              groupValue: _site,
              onChanged: (var value) {
                setState(() {
                  _site = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Translate into Text from image',
                style: TextStyle(fontSize: 20.0)),
            leading: Radio(
              value: options[1],
              groupValue: _site,
              activeColor:Colors.blue,
              onChanged: (var value) {
                setState(() {
                  _site = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Translate into Voice',
                style: TextStyle(fontSize: 20.0,)),
            leading: Radio(
              value: options[2],
              groupValue: _site,
              activeColor: Colors.blue,
              onChanged: (var value) {
                setState(() {
                  _site = value;
                });
              },
            ),
          ),
          
          SizedBox(height: 50),
          Container(
            margin: EdgeInsets.all(25),
            child: FlatButton(
              child: Text(
                'NEXT',
                style: TextStyle(fontSize: 20.0),
              ),
              color: Colors.teal,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed("/third", arguments: _site);
              },
            ),
          ),
        ],
      ),
    );
  }
}
