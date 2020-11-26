import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PostResult postResult = null;
  User user = null;
  Support support = null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Demo Api'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                (user != null && support != null)
                    ? user.id + " | " + user.name + "\n" + support.keterangan
                    // " | " +
                    // postResult.job +
                    // " | " +
                    // postResult.created
                    : "Tidak Ada Data",
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                onPressed: () {
                  // PostResult.connectToAPI("Bedul", "Dokter").then((val) {
                  //   postResult = val;
                  //   setState(() {});
                  // });

                  User.connectToAPI("3").then((value) {
                    user = value;
                    setState(() {});
                  });

                  Support.connectToAPI("3").then((value) {
                    support = value;
                    setState(() {});
                  });
                },
                child: Text('POST'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//buat kelas untuk ambil data API
class PostResult {
  int id;
  String name;
  String job;
  String created;

  //buat constructor untuk parameter agar masuk ke field yang disediakan
  PostResult({this.id, this.name, this.job, this.created});

  //buat factory method
  factory PostResult.createdPostResult(Map<String, dynamic> object) {
    return PostResult(
      id: object['id'],
      name: object['name'],
      job: object['job'],
      created: object['createdAt'],
    );
  }

  //method untuk menghubungkan aplikasi ke API
  static Future<PostResult> connectToAPI(String name, String job) async {
    String url = "https://reqres.in/api/users";

    var apiResult = await http.post(url, body: {
      //ambil dari parameter diatas

      "name": name,
      "job": job,
    });

    //dart convert
    var jsonObject = json.decode(apiResult.body);

    return PostResult.createdPostResult(jsonObject);
  }
}

//GET METHOD
class User {
  String id;
  String name;
  // String keterangan;

  User({this.id, this.name});

  factory User.createUser(Map<String, dynamic> object) {
    return User(
      id: object['id'].toString(),
      name: object['first_name'] + " " + object['last_name'],
      // keterangan: object['text'],
    );
  }

  static Future<User> connectToAPI(String id) async {
    String url = "https://reqres.in/api/users/" + id;

    var apiResult = await http.get(url);
    var jsonObject = json.decode(apiResult.body);

    var userData = (jsonObject as Map<String, dynamic>)['data'];

    return User.createUser(userData);
  }
}

class Support {
  String keterangan;

  Support({this.keterangan});

  factory Support.createUser(Map<String, dynamic> object) {
    return Support(
      keterangan: object['text'],
    );
  }

  static Future<Support> connectToAPI(String id) async {
    String url = "https://reqres.in/api/users/" + id;

    var apiResult = await http.get(url);
    var jsonObject = json.decode(apiResult.body);

    var userData = (jsonObject as Map<String, dynamic>)['support'];

    return Support.createUser(userData);
  }
}
