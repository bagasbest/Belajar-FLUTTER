import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/model/brew.dart';
import 'package:firebase_app/screens/home/brews_list.dart';
import 'package:firebase_app/screens/home/setting_form.dart';
import 'package:firebase_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "Brew Crew",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () async {
                    await _authServices.signOut();
                  },
                  icon: Icon(Icons.person),
                  label: Text("Logout")),
              FlatButton.icon(
                  onPressed: () => _showSettingsPanel(),
                  icon: Icon(Icons.settings),
                  label: Text("settings")),
            ],
          ),
          body: BrewList(),
        ),
      ),
    );
  }
}
