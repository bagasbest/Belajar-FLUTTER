import 'package:flutter/material.dart';
import 'package:part6statelessdanstateful/models/cart.dart';
import './components/product_lists.dart';
import './components/dashboard.dart';
import './components/add_new_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shopping Bag",
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.purpleAccent,
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )
      ),

      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Cart> _carts = [
    Cart(id: 'DW1', title: 'Sabun Mandi', harga:15000, qty: 1),
    Cart(id: 'DW2', title: 'Shampoo', harga: 17000,qty: 2),
  ];

  //METHOD INI AKAN MENJALANKAN MODAL BOTTOM SHEET, DIMANA MODAL INI AKAN TAMPIL DARI BAWAH
  void _openModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        //DAN ISI DARI MODAL TERSEBUT ADALAH COMPONENT AddNewItem. PASTINYA PARAMETER YANG DIKIRIM ADALAH SEBUAH FUNGSI BERNAMA _addNewItem, MAKA PERLU KITA DEFINISIKAN SELANJUTNYA
        return AddNewItem(_addNewItem);
      }
    );
  }

  //FUNGSI INI UNTUK MEMANIPULASI DENGAN MENAMBAHKAN DATA BARU KE DALAM CART
  void _addNewItem(String title, double harga, int qty) {
    //BBUAT FORMAT DATANYA DENGAN REFERENSI MENGGINAKAN MODAL Cart
    final newItem = Cart(id: DateTime.now().toString(), title: title, harga: harga, qty: qty);
    setState(() {
      _carts.add(newItem);
    });
  }

  //FUNGSI INI UNTUK MENGHAPIS SEMUA DATA PADA VARIABEL CARTS
  void _resetCarts() {
    setState(() {
      _carts.clear();
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Belanjaan"),
        actions: <Widget>[
          //TAMBAHKAN KODE INI
          FlatButton(child: Icon(Icons.clear, color: Colors.white,), onPressed: () => _resetCarts(),),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            //NANTINYA BERISI WIDGET
            Dashboard(_carts),
            ProductList(_carts), //TAMBAHKAN BAGIAN INI

          ],
        ),
      ),

      //TAMBAHKAN KODE INI
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
          //KETIKA DITEKAN MENJALANKAN FUNGSI _openModal
          _openModal(context),
      ),
    );
  }
}

