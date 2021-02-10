
import 'package:beresto/api/api_service.dart';
import 'package:beresto/model/restaurant_list.dart';
import 'package:flutter/cupertino.dart';

enum ResultState {Loading, NoData, HasData, Error}

class RestaurantProvider extends ChangeNotifier{
  final ApiService apiService;

  RestaurantProvider({@required this.apiService}){
    _fetchAllRestaurant();
  }
  
  RestaurantList _restaurantList;
  String _message = '';
  ResultState _state;
  
  String get message => _message;
  
  RestaurantList get list => _restaurantList;
  
  ResultState get state => _state;

  Future <dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final listOfRestaurant = await apiService.listOfRestaurants();
      if(listOfRestaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantList = listOfRestaurant;
      }
    } catch (error) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $error';
    }
  }
}