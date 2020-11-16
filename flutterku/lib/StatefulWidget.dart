import 'package:flutter/material.dart';

//fungsi main adalah fungsi yang dijalankan pertama kali ketika aplikasi dijalankan
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int number = 0;
  bool tambah = false;

  void tekanTombolAdd() {
    setState(() {
      number++;
      tambah = true;
    });
  }

  void tekanTombolMin() {
    setState(() {
      if(number==1) {
        return;
      }
      number--;
      tambah = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Belajar Stateful Widget"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if(tambah == true)
                Text(number.toString(), style: TextStyle(fontSize: 10 + number.toDouble()),),
              if(tambah == false)
                Text(number.toString(), style: TextStyle(fontSize: 10 + number.toDouble()),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: RaisedButton(
                      child: Text(
                        "kurang",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: tekanTombolMin,
                      color: Colors.deepOrange,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: RaisedButton(
                      child: Text(
                        "Tambah",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: tekanTombolAdd,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
