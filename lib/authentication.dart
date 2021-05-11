import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn gooleSignIn = GoogleSignIn();

Future<bool> googleSignIn() async {
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  if (googleUser != null) {
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);
    var user = auth.currentUser;
    return Future.value(true);
  }
}

successfulSignup(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registered Successfully '),
          content: Text("Go to login page"),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'))
          ],
        );
      });
}

Future<bool> signUp(String email, String password, context) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    Fluttertoast.showToast(
        msg: "You Registered Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.teal,
        textColor: Colors.white,
        fontSize: 16.0);

    return Future.value(true);
  } catch (e) {
    Fluttertoast.showToast(
        msg: e.code,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text(e.code),
    //         content: Text(e.message),
    //         actions: <Widget>[
    //           FlatButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: Text('OK'))
    //         ],
    //       );
    //     });
  }
}

Future<bool> signIn(String email, String password) async {
  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (userCredential == null) {
      return false;
    } else {
      return true;
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

Future<bool> signOutUser() async {
  User user = await auth.currentUser;
  print(user.providerData[0].providerId);
  if (user.providerData[0].providerId == 'google.com') {
    await gooleSignIn.disconnect();
  }
  await auth.signOut();
  return Future.value(true);
}

// void checkConnectivity() {
//   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//     if(result==ConnectivityResult.none){
//       showDialog(context: context,
//       barrierDismissible: false,
//       child: AlertDialog(
//         title: Text("Error"),
//         content: Text("No Data Connection Available"),
//         actions: <Widget>[
//           FlatButton(
//             onPressed: ()=>{
//               SystemChannels.platform.invokeMethod('SystemNavigator.pop')
//             }, 
//           child:Text("Exit"))
//         ],
//       )
//       );
//     }else if()
//   });
// }
