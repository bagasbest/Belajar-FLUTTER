import 'package:firebase_app/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar (
          title: Text("Brew Crew",
          style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(onPressed: () async{
              await _authServices.signOut();
            },
                icon: Icon(Icons.person),
                label: Text("Logout")),
          ],
        ),
      ),
    );
  }
}
