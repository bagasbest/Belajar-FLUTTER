import 'package:beresto/model/restaurant_list.dart';
import 'package:beresto/screen/detail_resto_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Restaurant restaurant;

  CardWidget({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Route route = MaterialPageRoute(
          builder: (context) => DetailRestoPage(
              restaurantId: restaurant.id,
              ),
        );
        Navigator.push(context, route);
      },
      splashColor: Colors.grey,
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          leading: Hero(
            tag: 'https://restaurant-api.dicoding.dev/images/small/' +
                restaurant.pictureId,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://restaurant-api.dicoding.dev/images/small/' +
                        restaurant.pictureId,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          title: Text(
            restaurant.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Icon(
                    (defaultTargetPlatform == TargetPlatform.android)
                        ? Icons.pin_drop
                        : CupertinoIcons.map_pin_ellipse,
                    size: 20,
                    color: Colors.orangeAccent,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    restaurant.city,
                    style: TextStyle(fontSize: 13),
                  ),

                ],
              ),
              Row(
                children: [
                  Icon(
                    (defaultTargetPlatform == TargetPlatform.android)
                        ? Icons.star
                        : CupertinoIcons.star_fill,
                    size: 20,
                    color: Colors.orangeAccent,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    restaurant.rating.toString(),
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
