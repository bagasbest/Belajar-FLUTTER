import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pemula/model/tourism_place.dart';
import 'package:pemula/screen/list_of_data.dart';

class WisataBandung extends StatelessWidget {
  final TourismPlace place;
  WisataBandung({@required this.place});

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
        resizeToAvoidBottomPadding: false,
        body: DetailScreen(place: place),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final TourismPlace place;
  DetailScreen({@required this.place});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //  Container(
          //   margin: EdgeInsets.only(bottom: 20),
          //   height: 200,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       image: DecorationImage(
          //           image: AssetImage('assets/images/farm-house.jpg'),
          //           fit: BoxFit.contain)),
          // ),

          Stack(
            children: [
              Image.asset(place.imageAsset),
              SafeArea(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => CardWidget()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                  FavoriteButton(),
                ],
              ))
            ],
          ),

          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              place.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),

          Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.date_range,
                        ),
                        Text(place.openDays)
                      ],
                    ),
                  ),
                  // ],
                ),
              ),
              Flexible(
                  flex: 1,
                  child: Container(
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.timeline,
                          ),
                          Text(place.openTime)
                        ],
                      ),
                    ),
                  )),
              Flexible(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.monetization_on,
                        ),
                        Text(place.ticketPrice)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 30.0,
              bottom: 20.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Text(
              place.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Oswald'),
            ),
          ),
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: place.imageUrls.map((url) {
                return Padding(
                  padding: EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(url),
                  ),
                );
              }).toList(),

              //[
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(5),
              //     child: Image.network(
              //         'https://media-cdn.tripadvisor.com/media/photo-s/0d/7c/59/70/farmhouse-lembang.jpg'),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Image.network(
              //       'https://media-cdn.tripadvisor.com/media/photo-w/13/f0/22/f6/photo3jpg.jpg'),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Image.network(
              //       'https://media-cdn.tripadvisor.com/media/photo-m/1280/16/a9/33/43/liburan-di-farmhouse.jpg'),
              // ),

              // ],
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Text("Tekan ini"),
            padding: EdgeInsets.all(8.0),
            color: Colors.pink,
            splashColor: Colors.pink[100],
          ),

          DropDownWidget(),
          RadioWidget(),
          CheckBoxWidget(),
        ],
      ),
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
        });
      },
    );
  }
}

class DropDownWidget extends StatefulWidget {
  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String language;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: [
        DropdownMenuItem(
          child: Text('Dart'),
          value: 'Dart',
        ),
        DropdownMenuItem(
          child: Text('Kotlin'),
          value: 'Kotlin',
        ),
        DropdownMenuItem(
          child: Text('Swift'),
          value: 'Swift',
        )
      ],
      value: language,
      hint: Text('Select Language'),
      onChanged: (String value) {
        setState(() {
          language = value;
        });
      },
    );
  }
}

class RadioWidget extends StatefulWidget {
  @override
  _RadioWidgetState createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  String language;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Radio(
            value: 'Dart',
            groupValue: language,
            onChanged: (val) {
              setState(() {
                language = val;
              });
            },
          ),
          title: Text('Dart'),
        ),
        ListTile(
          leading: Radio(
            value: 'Kotlin',
            groupValue: language,
            onChanged: (val) {
              setState(() {
                language = val;
              });
            },
          ),
          title: Text('Kotlin'),
        ),
        ListTile(
          leading: Radio(
            value: 'Swift',
            groupValue: language,
            onChanged: (val) {
              setState(() {
                language = val;
              });
            },
          ),
          title: Text('Swift'),
        ),
        ListTile(
          leading: Radio(
            value: 'Java',
            groupValue: language,
            onChanged: (val) {
              setState(() {
                language = val;
              });
            },
          ),
          title: Text('Java'),
        )
      ],
    );
  }
}

class CheckBoxWidget extends StatefulWidget {
  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isAgree,
        onChanged: (bool val) {
          setState(() {
            isAgree = val;
          });
        },
      ),
      title: Text('Agree / Disagree'),
    );
  }
}
