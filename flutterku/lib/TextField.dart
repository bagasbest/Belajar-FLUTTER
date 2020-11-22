import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Text Field"),
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    //hintText: 'Email',
                    // labelText: 'Email',

                    // //suffixIcon: Icon(Icons.eye),
                    // prefixIcon: Icon(
                    //   Icons.email_outlined,
                    //   color: Colors.pinkAccent,
                    // ),
                    // // prefixText: 'Email: ',
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(5),
                    // ),

                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),
                    ),

                    hintText: 'Email',
                  ),
                  onChanged: (val) {
                    setState(() {});
                  },
                  controller: controller,
                ),
                Text(controller.text),
                TextField(
                  decoration: InputDecoration(
                    //hintText: 'Email',
                    // labelText: 'Email',

                    // //suffixIcon: Icon(Icons.eye),
                    // prefixIcon: Icon(
                    //   Icons.email_outlined,
                    //   color: Colors.pinkAccent,
                    // ),
                    // // prefixText: 'Email: ',
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(5),
                    // ),

                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink, width: 2.0),
                    ),

                    hintText: 'Email',
                  ),
                  onChanged: (val) {
                    setState(() {});
                  },
                  controller: controller,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
