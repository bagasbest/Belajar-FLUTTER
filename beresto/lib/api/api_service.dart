import 'dart:convert';
import 'package:beresto/model/restaurant_detail.dart';
import 'package:beresto/model/restaurant_list.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';


  Future<RestaurantList> listOfRestaurants () async {
    final response = await http.get(_baseUrl + 'list');
    if(response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list of restaurants');
    }
  }

  Future<RestaurantDetail> detailOfRestaurants (String _id) async {
    final response = await http.get(_baseUrl + 'detail/' + _id);
    if(response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list of restaurants');
    }
  }
}