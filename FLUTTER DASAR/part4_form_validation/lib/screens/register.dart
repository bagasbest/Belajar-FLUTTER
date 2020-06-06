import 'package:flutter/material.dart';
import '../mixins/validation.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

//VALIDATION ADALAH NAMA CLASS YANG TELAH DIBUAT SEBELUMNYA
class _RegisterScreenState extends State<RegisterScreen> with Validation {
  //MEMBUAT GLOBAL KEY UNTUK VALIDASI
  final formKey = GlobalKey<FormState>();

  //  Define variable
  String name = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0), //SET MARGIN DARI CONTAINER
      child: Form(
        key: formKey, //MENGGUNAKAN GLOBAL KEY
        child: Column(
          //CHILDREN DARI COLUMN BERISI 4 BUAH OBJECT YANG AKAN DI-RENDER, YAKNI
          // TextInput UNTUK NAME, EMAIL, PASSWORD DAN TOMBOL DAFTAR
          children: <Widget>[
            // berisi 4 buah helper
            nameField(),
            emailField(),
            passwordField(),
            registerButton(),
          ],
        ),
      ),
    );
  }

  Widget nameField() {
    // MEMBUAT TEXT INPUT
    return TextFormField(
        decoration: InputDecoration(labelText: 'Nama Lengkap'),
        // Akan berisi validation
        validator: validateName,
        onSaved: (String value) {
          name = value;
        });
  }

  Widget emailField() {
    return TextFormField(
        keyboardType:
            TextInputType.emailAddress, // KEYBOARD TYPENYA ADALAH EMAIL ADDRESS
        //AGAR SYMBOL @ DILETAKKAN DIDEPAN KETIKA KEYBOARD DI TAMPILKAN
        decoration: InputDecoration(
          labelText: 'email',
          hintText: 'Enter email',
        ),
        validator: validateEmail,
        onSaved: (String value) {
          email = value;
        });
  }

  Widget passwordField() {
    return TextFormField(
        obscureText: true, //KETIKA obsecureText bernilai TRUE
        //MAKA SAMA DENGAN TYPE PASSWORD PADA HTML
        decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Enter password',
        ),
        validator: validatePassword,
        onSaved: (String value) {
          password = value;
        });
  }

  Widget registerButton() {
    // MEMBUAT TOMBOL
    return RaisedButton(
      onPressed: () {
        //PERINTAH YANG AKAN DIEKSEKUSI KETIKA TOMBOL DITEKAN
        //formKey ADALAH GLOBAL KEY, KEMUDIAN DIIKUTI DENGAN currentState
        //LALU METHOD validate(), NILAINYA ADALAH FALSE / TRUE

        if (formKey.currentState.validate()) {
          //jika true
          formKey.currentState.save(); //lakukan save
        }

        //DISINI KAMU BISA MENGHANDLE DATA YANG SDH DITAMPUNG PADA MASING-MASING VARIABLE
        //KAMU DAPAT MENGIRIMNYA KE API ATAU APAPUN
        //NAMUN UNTUK SEMENTARA KITA PRINT KE CONSOLE SAJA
        //KARENA BELUM MEMBAHAS TENTANG HTTP REQUEST

        print('Nama Lengkap : $name');
        print('Email        : $email');
        print('Password     : $password');
      },
      child: Text("Daftar"), //TEXT YANG AKAN DITAMPILKAN PADA TOMBOL
    );
  }
}
