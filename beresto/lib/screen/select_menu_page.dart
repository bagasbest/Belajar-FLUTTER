
import 'package:beresto/widgets/list_of_foods_and_drinks.dart';
import 'package:flutter/cupertino.dart';
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'TODAY AVAILABLE MENU',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Foods Menu',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 230,
                    child: ListOfFoodsAndDrinks(data: data, option: 'foods'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: Colors.grey,
                      height: 5,
                      thickness: 3,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Drinks Menu',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 230,
                    child: ListOfFoodsAndDrinks(data: data, option: 'drinks'),
                  ),
                  SizedBox(
                    height: 64,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 64,
              child: RaisedButton(
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text('Reservation Progress'),
                        content: Text(
                            'Are you sure want to book this restaurant ? '),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('NO'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          CupertinoDialogAction(
                            child: Text('YES'),
                            onPressed: () {
                              Navigator.pop(context);
                              _showCupertinoDialog(context, dateTime,
                                  seatNumber, data['name'].toString());

                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                color: Colors.orangeAccent,
                child: Text(
                  'MAKE A RESERVATION',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

_showCupertinoDialog(BuildContext context, String dateTime, String seatNumber,
    String restaurantName) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text('Your Reservation Successfully'),
        content: Text(
            'You Ordered: \n$restaurantName in $dateTime\nand you picked $seatNumber'),
        actions: [
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}
