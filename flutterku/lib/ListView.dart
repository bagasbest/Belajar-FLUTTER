import 'package:flutter/material.dart';

//fungsi main adalah fungsi yang dijalankan pertama kali ketika aplikasi dijalankan
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //llist of widget
  List<Widget> widgets = [];
  int cnt = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Latihan ListView"),
        ),
        // pake list view
        body: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      cnt++;
                      widgets.add(Text(
                        "Data ke-" + cnt.toString(),
                        style: TextStyle(fontSize: 20),
                      ));
                    });
                  },
                  child: Text("Tambah data"),
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      if(cnt == 0){
                        return;
                      }
                      cnt--;
                      widgets.removeLast();
                    });
                  },
                  child: Text("Kurangi data"),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets,
            )
          ],
        ),
      ),
    );
  }
}
