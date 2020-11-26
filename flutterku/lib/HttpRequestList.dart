import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterku/AnimatedContainer_GestureDetector.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String output = "no data";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Http Requests List"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                output,
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                onPressed: () {
                  User.getUser("2").then((value) {
                    output = "";
                    for (int i = 0; i < value.length; i++) {
                      output = output + " [ " + value[i].name + " ] ";
                    }
                    setState(() {});
                  });
                },
                child: Text('GET'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class User {
  String id;
  String name;

  User({this.id, this.name});

  factory User.createUser(Map<String, dynamic> object) {
    return User(
        id: object['id'].toString(),
        name: object['first_name'] + " " + object['last_name']);
  }

  static Future<List<User>> getUser(String page) async {
    String url = "https://reqres.in/api/users?page=" + page;
    var apiResult = await http.get(url);
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listUser = (jsonObject as Map<String, dynamic>)['data'];

    List<User> users = [];
    for (int i = 0; i < listUser.length; i++) {
      users.add(User.createUser(listUser[i]));
    }

    return users;
  }
}
