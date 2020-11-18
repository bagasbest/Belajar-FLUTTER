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
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

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
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //email
                    SizedBox(
                      height: 10.0,
                    ),

                    TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
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
                        validator: (val) =>
                            val.length < 6 ? 'Password min 6 digit' : null,
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
                          //register user
                          if (_formKey.currentState.validate()) {
                            dynamic result = await _authServices
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Please input valid email';
                              });
                            }
                          }
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.pink[400],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    )
                  ],
                ),
              ),
            )),
    );
  }
}
