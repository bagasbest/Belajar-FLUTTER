import 'package:flutter/material.dart';
import 'screens/register.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halaman registrasi',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Form Registrasi"),
        ),
        body: RegisterScreen(),
      ),
    );
  }
}
