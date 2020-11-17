import 'package:firebase_app/services/auth.dart';
import 'package:flutter/material.dart';



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Sign-in"),),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: RaisedButton(child: Text("Sign-in anon"),onPressed: () async{
              dynamic result = await _auth.signInAnon();
              if(result == null) {
                print('error signing in');
              }else {
                print('signing in');
                print(result.uid);
              }
          }, ),
        ),
      ),
    );
  }
}
