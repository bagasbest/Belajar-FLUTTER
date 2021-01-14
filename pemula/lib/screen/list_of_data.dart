import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pemula/data/tourism_place_data.dart';
import 'package:pemula/screen/wisata_bandung.dart';

void main() {
  runApp(CardWidget());
}

class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Bandung',
      theme: ThemeData(
        fontFamily: 'Oswald',

        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.pink,
        accentColor: Colors.pink[100],

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Wisata Bandung'),
        ),
        body: ListOfDataTourism(),
      ),
    );
  }
}

class ListOfDataTourism extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: tourismPlaceList.map((place) {
        return FlatButton(
          onPressed: () {
            Route route = MaterialPageRoute(
                builder: (context) => WisataBandung(
                      place: place,
                    ));
            Navigator.push(context, route);
          },
          child: Card(
            child: Row(
              children: [
                Expanded(flex: 1, child: Image.asset(place.imageAsset)),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Farm House Lembang',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(place.location)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
