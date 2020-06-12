import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './mixins/validation.dart';



class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFFB415B),
      ),
      home: Login(),
    );
  }
}


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<Login> with Validation{

  final formKey = GlobalKey<FormState>();

  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        padding: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0, bottom: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              Image.asset('assets/logo/logo_04.png', width: MediaQuery.of(context).size.width*.4,),
              SizedBox(height: 20.0),

              Row(
                children: <Widget>[
                  Text("Masukkan", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),  textAlign: TextAlign.center, ),
                  Text(" email yang anda telah daftarkan", style: TextStyle(fontSize: 16.0),  textAlign: TextAlign.center, ),
                ],
              ),
              Text("untuk memperoleh konfirmasi password", style: TextStyle(fontSize: 16.0),  textAlign: TextAlign.center, ),
              Text("pada email anda", style: TextStyle(fontSize: 16.0),  textAlign: TextAlign.center, ),
              SizedBox(height: 30.0,),
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    buildTextField1("Email"),
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              buildButton(),
              SizedBox(height: 25.0,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Kembali ke halaman Login",style: TextStyle(
                      color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,
                    ),),

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField1(String hintText) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(Icons.email),
      ),
      validator: validateEmail,
      onSaved: (String value){
        email = value;
      },
    );
  }

  Widget buildButton() {

    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: Color(0xFFEE5623),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),

        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFFFB415B),
                  Color(0xFFEE5623)
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft

            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: Text("SUBMIT",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0, fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),

            onPressed: () {
              //formKey ADALAH GLOBAL KEY, KEMUDIAN DIIKUTI DENGAN currentState
              //LALU METHOD validate(), NILAINYA ADALAH FALSE / TRUE
              if (formKey.currentState.validate()) { //JIKA TRUE
                formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

                //DISINI KAMU BISA MENGHANDLE DATA YANG SDH DITAMPUNG PADA MASING-MASING VARIABLE
                //KAMU DAPAT MENGIRIMNYA KE API ATAU APAPUN
                //NAMUN UNTUK SEMENTARA KITA PRINT KE CONSOLE SAJA
                //KARENA BELUM MEMBAHAS TENTANG HTTP REQUEST
                print('Email: $email');
              }
            },
      ),


    );
  }
}
