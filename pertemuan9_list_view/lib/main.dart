import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> widgets = [];
  int cnt = 1;

  // isi widget sebelum ditampilkan
  // buat constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Belajar List View"),
        ),
        body: ListView(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                child: Text("Tambah data"),
                onPressed: () {
                  setState(() {
                    widgets.add(Text(
                      "Data ke-" + cnt.toString(),
                      style: TextStyle(fontSize: 35),
                    ));
                    cnt++;
                  });
                },
              ),
              RaisedButton(
                  child: Text("Hapus data"),
                  onPressed: () {
                    setState(() {
                      widgets.removeLast();
                      cnt--;
                    });
                  })
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          )
        ]),
      ),
    );
  }
}
