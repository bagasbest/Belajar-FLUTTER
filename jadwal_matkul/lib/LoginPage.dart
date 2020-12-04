import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  String error = '';
  String hintText = "Password";

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Semoga membantu jadwal kuliahmu\nDan menjadi orang sukses",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2.0),
                    ),
                    hintText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (val) =>
                      val.isEmpty ? "Enter a valid email address" : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: hintText == "Password" ? _isHidden : false,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.orange, width: 2.0),
                      ),
                      hintText: hintText,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                      suffixIcon: IconButton(
                        icon: _isHidden
                            ? Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )
                            : Icon(
                                Icons.visibility,
                                color: Colors.orange,
                              ),
                        onPressed: _toggleVisibility,
                      )),
                  validator: (val) =>
                      val.isEmpty ? "Enter a valid password" : null,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 300,
                  height: 45,
                  child: RaisedButton(
                    onPressed: () {
                      if (email.isNotEmpty && password.isNotEmpty) {
                        Fluttertoast.showToast(
                            msg: email + " " + password,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: StadiumBorder(),
                    color: Colors.orange,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
