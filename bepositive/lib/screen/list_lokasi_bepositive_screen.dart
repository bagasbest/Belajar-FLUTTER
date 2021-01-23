import 'package:bepositive/data/lokasi_bepositive_data.dart';
import 'package:flutter/material.dart';

import 'lokasi_bepositive_screen.dart';

class ListLokasiBePositive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokasi BePositive'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListOfLokasiBePositive(),
    );
  }
}

class ListOfLokasiBePositive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: lokasiBePositiveList.map((place) {
        return GestureDetector(
          onTap: () {
            Route route = MaterialPageRoute(
                builder: (context) => LokasiBePositive(
                  place: place,
                ));
            Navigator.push(context, route);
          },
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      image: DecorationImage(
                        image: AssetImage(
                          place.imageAsset,
                        ),
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        place.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                      Text(
                        place.description,
                        style: TextStyle(color: Colors.black),
                        maxLines: 2,
                      ),
                    ],
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
