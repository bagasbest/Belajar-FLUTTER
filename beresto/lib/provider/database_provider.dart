
import 'package:beresto/helper/database_helper.dart';
import 'package:beresto/model/restaurant_list.dart';
import 'package:beresto/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';



class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  
  DatabaseProvider({@required this.databaseHelper}) {
    _getFavoriteResto();
  }
  
  ResultState _state;
  ResultState get state => _state;

  
  String _message = '';
  String get message => _message;
  
  List <Restaurant> _favoriteResto = [];
  List <Restaurant> get favoriteResto => _favoriteResto;
  
  void _getFavoriteResto() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      _favoriteResto = await databaseHelper.getFavoriteResto();
      if(_favoriteResto.length > 0) {
        _state = ResultState.HasData;
        notifyListeners();
      } else {
        _state = ResultState.NoData;
        notifyListeners();
        _message = 'Empty Data';
      }
    } catch (err) {
      _state = ResultState.Error;
      notifyListeners();
      print(err);
      _message = 'Maaf, Sedang Terjadi Error Bung, Silahkan Periksa Jaringan Internet Anda atau Mulai Ulang Aplikasi';
    }
  }
  
  void addFavoriteResto(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavoriteResto(restaurant);
      _getFavoriteResto();
    } catch (err) {
      _state = ResultState.Error;
      notifyListeners();
      _message = 'Error: $err';
    }
  }

  Future <bool> isFavorited (String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteRestoById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavoriteResto(id);
      _getFavoriteResto();
    } catch (err) {
      _state = ResultState.Error;
      _message = 'Error: $err';
      notifyListeners();
    }
  }
}