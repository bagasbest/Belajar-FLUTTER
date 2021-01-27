import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GestureDetection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double boxSize = 150;
  int numTap = 0;
  int numDoubleTap = 0;

  double posX = 0.0;
  double posY = 0.0;

  void center(BuildContext context) {
    posX = (MediaQuery.of(context).size.width / 2) - boxSize / 2;
    posY = (MediaQuery.of(context).size.height / 2) - boxSize / 30;

    setState(() {
      this.posX = posX;
      this.posY = posY;
    });

  }

  @override
  Widget build(BuildContext context) {

    if(posX == 0) {
      center(context);
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: posY,
            left: posX,
            child: GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  double deltaX = details.delta.dx;
                  double deltaY = details.delta.dy;
                  posX += deltaX;
                  posY += deltaY;
                });
              },
              onTap: () {
                setState(() {
                  numTap++;
                });
              },
              onDoubleTap: () {
                setState(() {
                  numDoubleTap++;
                });
              },
              child: Container(
                height: boxSize,
                width: boxSize,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.yellow,
        padding: EdgeInsets.all(16),
        child: Text(
          'taps: $numTap - Double taps: $numDoubleTap - Long Press: 0',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
