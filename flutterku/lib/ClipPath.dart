import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterku/AnimatedContainer_GestureDetector.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          //potong gambar
          child: ClipPath(
            clipper: MyClipper(),
            child: Image(
              width: 300,
              image: AssetImage('lib/assets/sunset.webp'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    //kita ingin memotong dengan pola apa
    Path path = Path();

    //lurus
    path.lineTo(0, size.height);
    //melengkung
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.75, size.width, size.height);
    //lurus
    path.lineTo(size.width, 0);
    //tutup
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
