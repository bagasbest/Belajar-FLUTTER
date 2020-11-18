import 'package:firebase_app/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices _authServices = AuthServices();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Register"),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.pinkAccent,
                ),
                label: Text(
                  "Sign-in",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //email
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(onChanged: (val) {
                    setState(() {
                      //email
                      email = val;
                    });
                  }),

                  //password
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      //password
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          //password
                          password = val;
                        });
                      }),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: RaisedButton(
                      onPressed: () async {
                        print("Email    : " + email);
                        print("Password : " + password);
                        //go to homepage
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.pink[400],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
