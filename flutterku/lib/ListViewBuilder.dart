import 'dart:js';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ProductCard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(builder: (context) => ProductBloc(), child: MainPage());
  }
}

class MainPage extends StatelessWidget {
  final Random rand = Random();
  @override
  Widget build(BuildContext context) {
    ProductBloc bloc = BlocProvider.of<ProductBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo ListView Builder"),
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () {
              bloc.dispatch(rand.nextInt(4) + 2);
            },
          ),
          BlocBuilder<ProductBloc, List<Product>>(
            builder: (context, products) => Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    imageUrl: products[index].imageUrl,
                    name: products[index].name,
                    price: products[index].price.toString(),
                    onAddChartTap: () {},
                    onDecrementTap: () {},
                    onIncrementTap: () {},
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Product {
  String imageUrl;
  String name;
  int price;

  Product({this.imageUrl = "", this.name = "", this.price = 0});
}

class ProductBloc extends Bloc<int, List<Product>> {
  @override
  List<Product> get initialState => [];

  @override
  Stream<List<Product>> mapEventToState(int event) async* {
    List<Product> products = [];
    for (int i = 0; i < event; i++) {
      products.add(Product(
          imageUrl:
              "https://image.sciencenorway.no/1438480.jpg?imageId=1438480&panow=0&panoh=0&panox=0&panoy=0&heightw=0&heighth=0&heightx=0&heighty=0&width=1200&height=630",
          name: "Produk ke-" + i.toString(),
          price: (i + 1) * 5000));
    }
    yield products;
  }
}
