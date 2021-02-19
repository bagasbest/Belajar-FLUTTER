import 'package:beresto/api/api_service.dart';
import 'package:beresto/model/restaurant_detail.dart';
import 'package:beresto/provider/database_provider.dart';
import 'package:beresto/provider/restaurant_detail_provider.dart';
import 'package:beresto/provider/restaurant_provider.dart';
import 'package:beresto/screen/reservation_page.dart';
import 'package:beresto/screen/review_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DetailRestoPage extends StatelessWidget {
  final restaurantId;
  final restaurantList;

  DetailRestoPage({@required this.restaurantId, this.restaurantList});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailAndReviewProvider(
          apiService: ApiService(), restaurantId: restaurantId),
      child: Scaffold(
        body: Consumer<RestaurantDetailAndReviewProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(
                child: _shimmerLoadingSkeleton(),
              );
            } else if (state.state == ResultState.HasData) {
              var restaurant = state.detail.restaurant;
              return DetailRestaurant(
                  restaurant: restaurant, restaurantList: restaurantList);
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      size: 100,
                      color: Colors.grey,
                    ),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _shimmerLoadingSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350],
      highlightColor: Colors.grey[200],
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            height: 150,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}

class DetailRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  final restaurantList;

  DetailRestaurant({this.restaurant, this.restaurantList});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag:
                              'https://restaurant-api.dicoding.dev/images/small/' +
                                  restaurant.pictureId,
                          child: Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://restaurant-api.dicoding.dev/images/small/' +
                                      restaurant.pictureId,
                                ),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                restaurant.name,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              isFavorited
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        provider.removeFavorite(restaurant.id);
                                        _toast('Menghapus ${restaurant.name} dari daftar restoran favorit');
                                      }
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        provider.addFavoriteResto(restaurantList);
                                        _toast('Menambahkan ${restaurant.name} ke daftar restoran favorit');
                                      }
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          child: Text(
                            restaurant.description,
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
                              children: [
                                Icon(Icons.family_restroom),
                                Text('Toilet')
                              ],
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
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16),
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

                              /// Penggunaan FlatButton tidak bisa diganti oleh ElevatedButton, karena memuat properti splashColor
                              FlatButton(
                                onPressed: () {
                                  Route route = MaterialPageRoute(
                                    builder: (context) => ReviewPage(
                                      restaurantReview:
                                          restaurant.customerReviews,
                                      restaurantId: restaurant.id,
                                    ),
                                  );
                                  Navigator.push(context, route);
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
                              _starIcon(),
                              _starIcon(),
                              _starIcon(),
                              _starIcon(),
                              _starIcon(),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(restaurant.rating.toString() +
                                    ' / 5.0 . 231 Feeds'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16),
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
                                'Location: ${restaurant.address}\n' +
                                    restaurant.city,
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

                          /// Penggunaan RaisedButton tidak bisa diganti oleh ElevatedButton, karena memuat properti color
                          child: RaisedButton(
                            onPressed: () {
                              Route route = MaterialPageRoute(
                                builder: (context) => ReservationPage(
                                  restaurant: restaurant,
                                ),
                              );
                              Navigator.push(context, route);
                            },
                            color: Colors.orangeAccent,
                            child: Text(
                              'RESERVATION',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
          },
        );
      },
    );
  }

  Icon _starIcon() {
    return Icon(
      Icons.star,
      color: Colors.orangeAccent,
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
