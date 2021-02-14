
import 'package:beresto/provider/restaurant_provider.dart';
import 'package:beresto/widgets/card_widget.dart';
import 'package:beresto/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ListOfRestaurant extends StatelessWidget {
  Widget _buildList() {
    return Scaffold(
      body: Consumer<RestaurantListAndSearchProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return _shimmerLoadingSkeleton();
          } else if (state.state == ResultState.HasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.list.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.list.restaurants[index];
                return CardWidget(restaurant: restaurant);
              },
            );
          } else if (state.state == ResultState.NoData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.announcement_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  Text(state.message, textAlign: TextAlign.center,),
                ],
              ),
            );
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
                  Text(state.message, textAlign: TextAlign.center,),
                ],
              ),
            );
          }
        },
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

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
