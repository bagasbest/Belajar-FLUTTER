import 'package:beresto/api/api_service.dart';
import 'package:beresto/provider/restaurant_provider.dart';
import 'package:beresto/screen/list_of_restautant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

String querySearch = '';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _controllerSearch = TextEditingController();

  String _currentTime() {
    var now = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd-MM-yyyy\nkk:mm').format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Card(
            elevation: 10,
            //color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Image.asset(
              'assets/banner.png',
              fit: BoxFit.fitWidth,
              height: 200,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      _currentTime(),
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ),
                Text(
                  'BeResto\nBebas Pilih Resto Favoritmu',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _controllerSearch,
                      decoration: InputDecoration(
                        hintText: 'cari berdasarkan nama atau kota',
                        border: InputBorder.none,
                        icon: IconButton(
                          icon: Icon(CupertinoIcons.search),
                          onPressed: () {
                              setState(() {
                                querySearch = _controllerSearch.text;
                              },
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  super.widget),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: ChangeNotifierProvider(
                      create: (_) =>
                      /// State Management Provider ini digunakan untuk menampilkan list of Restaurant dan list of search
                          RestaurantListAndSearchProvider(
                              apiService: ApiService(), query: querySearch),
                      child: ListOfRestaurant(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
