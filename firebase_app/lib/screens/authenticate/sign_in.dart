import 'package:firebase_app/services/auth.dart';
import 'package:firebase_app/shared/constraint.dart';
import 'package:firebase_app/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loading
          ? Loading()
          : Scaffold(
              appBar: AppBar(
                title: Text("Sign-in"),
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
                        "Register",
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
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) =>
                                val.isEmpty ? 'Emter an valid email' : null,
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
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            //password
                            validator: (val) =>
                                val.length < 6 ? 'Password min 6 digit' : null,
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
                              //validate input and login
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Please input valid email';
                                    loading = false;
                                  });
                                }
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.pink[400],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  )),
            ),
    );
  }
}
