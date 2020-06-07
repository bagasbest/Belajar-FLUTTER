import 'package:flutter/foundation.dart';

class Cart {
  final String id;
  final String title;
  final double harga;
  final int qty;

//Buat CONSTRUCTOR DIMANA SECARA DEFAULT CLASS INI AKAN MEMINTA DATA TERSEBUT
  Cart ({
    @required this.id,
    @required this.title,
    @required this.harga,
    @required this.qty
  });
}
