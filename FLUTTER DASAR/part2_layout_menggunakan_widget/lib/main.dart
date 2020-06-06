import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // menampilkan icon home dan text
          backgroundColor: Colors.red[800],
          leading: Icon(Icons.home),
          title: Text("Flutter Basic"),
        ),

        // membuat card dan teks
        // terdapat Modifikasi
        body: Container(
          color: Colors.lightBlue,
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.archive),
                  Text(
                    "Artikel Terbaru",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    Image.network(
                        'https://flutter.io/images/homepage/header-illustration.png'),
                    Text("Belajar Flutter")
                  ],
                ),
              )
            ],
          ),
        ),

        // Akhir code
      ),
    );
  }
}
