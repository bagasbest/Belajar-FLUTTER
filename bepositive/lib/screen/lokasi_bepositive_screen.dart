import 'package:bepositive/model/lokasi_bepositive_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LokasiBePositive extends StatelessWidget {
  final LokasiBePositiveModel place;

  LokasiBePositive({@required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.asset(
                  place.imageAsset,
                  fit: BoxFit.fill,
                ),
                SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Text(
                place.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Text(
                place.description,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  heroTag: 'btn1',
                  onPressed: () {
                    toast('Kamu menyukai ${place.name}');
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  backgroundColor: Colors.white,
                ),
                FloatingActionButton(
                  heroTag: 'btn2',
                  onPressed: () {
                    toast('Kamu membagikan ${place.name}');
                  },
                  child: Icon(
                    Icons.share,
                    color: Colors.red,
                  ),
                  backgroundColor: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.orangeAccent,
      textColor: Colors.white,
      fontSize: 16.0);
}
