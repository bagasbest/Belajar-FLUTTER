import 'package:flutter/material.dart';

class SelectMenuPage extends StatelessWidget {
  final data;
  final String dateTime;
  final String seatNumber;

  SelectMenuPage({this.data, this.dateTime, this.seatNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        title: Text(
          'Online Reservation',
        ),
      ),
      body: Stack(
        children: [

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 64,
              child: RaisedButton(
                onPressed: (){},
                color: Colors.orangeAccent,
                child: Text('MAKE A RESERVATION'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
