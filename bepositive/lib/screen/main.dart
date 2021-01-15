import 'package:bepositive/screen/bottom_navigation_widget.dart';
import 'package:bepositive/screen/category_card_widget.dart';
import 'package:bepositive/screen/lokasi_bepositive_screen.dart';
import 'package:bepositive/screen/positifkan_fikiranmu_screen.dart';
import 'package:bepositive/screen/positifkan_kegiatanmu_screen.dart';
import 'package:bepositive/screen/positifkan_tubuhmu_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BePositive',
      theme: ThemeData(fontFamily: 'NunitoSans'),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  String currenTime() {
    var now = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd-MM-yyyy\nkk:mm').format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    // this gonna give us total height or width in our device
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: [
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
              image: DecorationImage(
                image: AssetImage('asset/image/undraw_pilates_gpdb.png'),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Text(
                        //'Jum\'at, 15 Januari 2021\n1:14 PM',
                        currenTime(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  Text(
                    greeting() + "\nBagas Pangestu",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Apa yang kamu pikirin sih?',
                        icon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: [
                        CategoryCardWidget(
                          cardImage: Icons.psychology,
                          cardTitle: "Positifkan Fikiranmu",
                          press: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => PositifkanFikiranmu());
                            Navigator.push(context, route);
                          },
                        ),
                        CategoryCardWidget(
                          cardImage: Icons.self_improvement,
                          cardTitle: "Positifkan tubuhmu",
                          press: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => PositifkanTubuhmu());
                            Navigator.push(context, route);
                          },
                        ),
                        CategoryCardWidget(
                          cardImage: Icons.directions_bike,
                          cardTitle: "Positifkan Kegiatanmu",
                          press: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => PositifkanKegiatanmu());
                            Navigator.push(context, route);
                          },
                        ),
                        CategoryCardWidget(
                          cardImage: Icons.nature_people,
                          cardTitle: "Lokasi BePostive",
                          press: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => LokasiBePositive());
                            Navigator.push(context, route);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
