import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<Money>(
            create: (context) => Money(),
          ),
          ChangeNotifierProvider<Cart>(
            create: (context) => Cart(),
          )
        ],
        child: Scaffold(
          floatingActionButton: Consumer<Cart>(
            builder: (context, cart, _) => Consumer<Money>(
              builder: (context, money, _) => FloatingActionButton(
                onPressed: () {
                  if (money.balance >= 500) {
                    cart.quantity += 1;
                    money.balance -= -500;
                  }
                },
                backgroundColor: Colors.purple,
                child: Icon(
                  Icons.add_shopping_cart,
                ),
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text(
              "Multi Provider",
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Balance"),
                    Container(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Consumer<Money>(
                          builder: (context, money, _) => Text(
                            money._balance.toString(),
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      height: 30,
                      width: 150,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.purple[100],
                        border: Border.all(color: Colors.purple, width: 2),
                      ),
                    )
                  ],
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Consumer<Cart>(
                      builder: (context, cart, _) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Apple (500) x " + cart.quantity.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            (500 * cart.quantity).toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  height: 30,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Cart with ChangeNotifier {
  int _quantity = 0;

  int get quantity => _quantity;
  set quantity(int val) {
    _quantity = val;
    notifyListeners();
  }
}

class Money with ChangeNotifier {
  int _balance = 10000;

  int get balance => _balance;
  set balance(int val) {
    _balance = val;
    notifyListeners();
  }
}
