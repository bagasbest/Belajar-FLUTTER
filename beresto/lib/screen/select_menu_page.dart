import 'package:beresto/api/api_service.dart';
import 'package:beresto/model/restaurant_detail.dart';
import 'package:beresto/provider/restaurant_detail_provider.dart';
import 'package:beresto/provider/restaurant_provider.dart';
import 'package:beresto/screen/list_of_foods_and_drinks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SelectMenuPage extends StatelessWidget {
  final Restaurant restaurant;
  final String dateTime;
  final String seatNumber;

  SelectMenuPage(
      {this.restaurant, @required this.dateTime, @required this.seatNumber});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      /// State Management Untuk menampilkan List of Menu foods and drinks
      create: (_) => RestaurantDetailAndReviewProvider(
          apiService: ApiService(), restaurantId: restaurant.id),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.orangeAccent,
          title: Text(
            'Online Reservation',
          ),
        ),
        body: Consumer<RestaurantDetailAndReviewProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(
                child: _shimmerLoadingSkeleton(),
              );
            } else if (state.state == ResultState.HasData) {
              return buildStack(context);
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

  Stack buildStack(BuildContext context) {
    return Stack(
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  child: ListOfFoodsAndDrinks(
                      data: restaurant, option: restaurant.menus.foods),
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
                  child: ListOfFoodsAndDrinks(
                      data: restaurant, option: restaurant.menus.drinks),
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

            /// Penggunaan RaisedButton tidak bisa diganti oleh ElevatedButton, karena memuat properti color
            child: RaisedButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('Reservation Progress'),
                      content:
                          Text('Are you sure want to book this restaurant ? '),
                      actions: [
                        CupertinoDialogAction(
                          child: Text('NO'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        CupertinoDialogAction(
                          child: Text('YES'),
                          onPressed: () {
                            Navigator.pop(context);
                            _showCupertinoDialog(
                                context, dateTime, seatNumber, restaurant.name);
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
}
