import 'package:beresto/screen/reservation_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailRestoPage extends StatelessWidget {
  final data;

  DetailRestoPage({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  data['pictureId'],
                  fit: BoxFit.fill,
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data['name'],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      FavoriteButton(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Text(
                    data['description'],
                    maxLines: 5,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [Icon(Icons.wifi), Text('Free Wi-Fi')],
                    ),
                    Column(
                      children: [
                        Icon(Icons.phone),
                        Text(
                          'Reservation',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Column(
                      children: [Icon(Icons.family_restroom), Text('Toilet')],
                    ),
                    Column(
                      children: [
                        Icon(Icons.meeting_room),
                        Text(
                          'Have VIP Room',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Feedback',
                        style: TextStyle(fontSize: 18),
                      ),
                      FlatButton(
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text('Coming Soon :)'),
                                content: Text(
                                    'This feature will be developed soon!'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        splashColor: Colors.grey,
                        child: Text(
                          'See all comment',
                          style: TextStyle(color: Colors.orangeAccent),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StarIcon(),
                      StarIcon(),
                      StarIcon(),
                      StarIcon(),
                      StarIcon(),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                            data['rating'].toString() + ' / 5.0 . 231 Feeds'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 50,
                      ),
                      Text(
                        'Location: ' + data['city'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 64,
                  child: RaisedButton(
                    onPressed: () {
                      Route route = MaterialPageRoute(
                        builder: (context) => ReservationPage(
                          data: data,
                        ),
                      );
                      Navigator.push(context, route);
                    },
                    color: Colors.orangeAccent,
                    child: Text(
                      'RESERVATION',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: FloatingActionButton(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon StarIcon() {
    return Icon(
      Icons.star,
      color: Colors.orangeAccent,
    );
  }
}

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
          (isFavorite)
              ? _toast('You loved this restaurant')
              : _toast('You not loved this restaurant');
        });
      },
    );
  }
}

_toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orangeAccent,
      textColor: Colors.white,
      fontSize: 16.0);
}
