import 'package:flutter/material.dart';
import 'package:flutterku/AnimatedContainer_GestureDetector.dart';
import 'package:provider/provider.dart';

const Color firstColor = Color(0xfff44336);
const Color secondColor = Color(0xff4CAF50);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Product Card"),
          backgroundColor: firstColor,
        ),
        body: ChangeNotifierProvider<ProductState>(
          create: (context) => ProductState(),
          child: Container(
            margin: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Consumer<ProductState>(
                builder: (context, productState, _) => ProductCard(
                  imageUrl:
                      "https://image.sciencenorway.no/1438480.jpg?imageId=1438480&panow=0&panoh=0&panox=0&panoy=0&heightw=0&heighth=0&heightx=0&heighty=0&width=1200&height=630",
                  name: "Buah - Buahan Mix 1 kg",
                  price: "Rp.25.000",
                  onAddChartTap: () {},
                  notification:
                      (productState.quantity > 5) ? "Diskon 10%" : null,
                  quantity: productState.quantity,
                  onIncrementTap: () {
                    productState.quantity++;
                  },
                  onDecrementTap: () {
                    productState.quantity--;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String notification;

  final int quantity;

  final Function onAddChartTap;
  final Function onIncrementTap;
  final Function onDecrementTap;

  final TextStyle textStyle = TextStyle(
      fontFamily: "Milonga",
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.grey[800]);

  final String imageUrl;
  ProductCard(
      {this.imageUrl = "",
      this.name = "",
      this.price = "",
      this.quantity = 0,
      this.onIncrementTap,
      this.onDecrementTap,
      this.notification,
      this.onAddChartTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //notifikasi
        AnimatedContainer(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(left: 10, right: 10),
            width: 130,
            height: (notification != null) ? 270 : 250,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    offset: Offset(1, 1),
                    color: Colors.black.withOpacity(0.3),
                  )
                ],
                color: secondColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                (notification != null) ? notification : "",
                style: textStyle.copyWith(color: Colors.white, fontSize: 12),
              ),
            ),
            duration: Duration(milliseconds: 300)),
        Container(
          width: 150,
          height: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(1, 1),
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                        image: DecorationImage(
                            image: NetworkImage(imageUrl), fit: BoxFit.cover)),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      name,
                      style: textStyle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      price,
                      style:
                          textStyle.copyWith(fontSize: 12, color: firstColor),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 140,
                    height: 30,
                    decoration:
                        BoxDecoration(border: Border.all(color: firstColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: onIncrementTap,
                          child: Container(
                            width: 30,
                            height: 30,
                            color: firstColor,
                            child: Icon(
                              Icons.add,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          quantity.toString(),
                          style: textStyle,
                        ),
                        GestureDetector(
                          onTap: onDecrementTap,
                          child: Container(
                            width: 30,
                            height: 30,
                            color: firstColor,
                            child: Icon(
                              Icons.remove,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                      width: 140,
                      child: RaisedButton(
                        onPressed: onAddChartTap,
                        color: firstColor,
                        child: Icon(
                          Icons.add_shopping_cart,
                          size: 18,
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16))),
                      ))
                ],
              )
            ],
          ),
        )
        //card
      ],
    );
  }
}

class ProductState with ChangeNotifier {
  int _quantity = 0;

  int get quantity => _quantity;
  set quantity(int newValue) {
    _quantity = newValue;
    notifyListeners();
  }
}
