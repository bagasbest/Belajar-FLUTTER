import 'package:flutter/material.dart';
import 'package:flutterku/AnonymousMethod.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("Fleksibel Layout"),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Colors.pinkAccent,
                      child: Center(
                        child: Icon(
                          Icons.add_a_photo,
                          size: 48.0,
                          color: Colors.white,
                        ),
                      ),
                      // ],
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.green,
                        child: Center(
                          child: Icon(
                            Icons.person_add,
                            size: 48.0,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Colors.brown,
                      child: Center(
                        child: Icon(
                          Icons.map,
                          size: 48.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Flexible(
              flex: 2,
              child: Container(
                foregroundDecoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/assets/wait.jpg'),
                        fit: BoxFit.fill)),
              )),
          Flexible(
            flex: 1,
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.pinkAccent,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1590217283222-063e4fa266c5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=528&q=80',
                      ),
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
