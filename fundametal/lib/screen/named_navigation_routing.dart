import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NamedNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Navigation adn Route',
      initialRoute: '/',
      routes: {
        '/secondScreen': (context) => SecondScreen(),
        '/secondScreenWithData': (context) => SecondScreenWithData(),
        '/returnDataScreen': (context) => ReturnDataScreen(),
        '/replacementScreen': (context) => ReplacementScreen(),
        '/anotherScreen': (context) => AnotherScreen(),
      },
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Named Navigation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/secondScreen');
              },
              child: Text('Go to Second Screen'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/secondScreenWithData',
                  arguments: 'Hello From first screen',
                );
              },
              child: Text('Navigation with data'),
            ),
            RaisedButton(
              onPressed: () async {
                final result =
                    await Navigator.pushNamed(context, '/returnDataScreen');
                SnackBar snackBar = SnackBar(
                  content: Text('$result'),
                );
                _scaffoldKey.currentState.showSnackBar(snackBar);
              },
              child: Text('return data from another scren'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/replacementScreen');
              },
              child: Text('replace screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Kembali ke first page'),
        ),
      ),
    );
  }
}

class SecondScreenWithData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(data),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Kembali ke first page'),
            ),
          ],
        ),
      ),
    );
  }
}

class ReturnDataScreen extends StatelessWidget {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(labelText: 'Enter your name'),
              ),
            ),
            RaisedButton(
              onPressed: () => Navigator.pop(context, textController.text),
              child: Text('Send'),
            )
          ],
        ),
      ),
    );
  }
}

class ReplacementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/anotherScreen'),
          child: Text('open another screen'),
        ),
      ),
    );
  }
}

class AnotherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('back to first screen'),
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('back'),
            ),
          ],
        ),
      ),
    );
  }
}
