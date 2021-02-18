import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:beresto/api/api_service.dart';
import 'package:beresto/provider/preferences_provider.dart';
import 'package:beresto/provider/restaurant_provider.dart';
import 'package:beresto/provider/schduling_provider.dart';
import 'package:beresto/screen/favorite_resto_page.dart';
import 'package:beresto/screen/list_of_restautant.dart';
import 'package:beresto/screen/settings_resto_page.dart';
import 'package:beresto/service/background_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/notification_helper.dart';
import 'helper/preferences_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _service.someTask());
    _notificationHelper.configureSelectNotificationSubject(context);
  }
  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SchedulingProvider()),
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
        ],

      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'BeResto App',
            theme: provider.themeData,
            builder: (context, child){
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness: provider.isNightTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            home: HomePage(),
          );
        }
      ),
    );
  }
}

String querySearch = '';
var _controllerSearch = TextEditingController();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


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
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            Route route = MaterialPageRoute(
                              builder: (context) => FavoriteRestoPage(),
                            );
                            Navigator.push(context, route);
                          },
                        ),
                        IconButton(
                            icon: Icon(Icons.settings, color: Colors.orange),
                            onPressed: () {
                              Route route = MaterialPageRoute(
                                builder: (context) => SettingsRestoPage(),
                              );
                              Navigator.push(context, route);
                            }),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          _currentTime(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
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
                      style: TextStyle(color: Colors.orange),
                      decoration: InputDecoration(

                        hintText: 'cari berdasarkan nama atau kota',
                        border: InputBorder.none,
                        icon: IconButton(
                          icon: Icon(CupertinoIcons.search, color: Colors.orange,),
                          onPressed: () {
                            setState(
                              () {
                                 _controllerSearch.text;
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
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ChangeNotifierProvider(
                      create: (_) =>
                          /// State Management Provider ini digunakan untuk menampilkan list of Restaurant dan list of search
                          RestaurantListAndSearchProvider(
                              apiService: ApiService(), query: _controllerSearch.text),
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
