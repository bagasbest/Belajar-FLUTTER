import 'package:firebase_app/model/user.dart';
import 'package:firebase_app/screens/authenticate/authenticate.dart';
import 'package:firebase_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);

    //return either Home or Authenticate widget
    if(user == null) {
      return Authenticate();
    }else{
      return Home();
    }
  }
}
