
import 'package:beresto/model/restaurant_list.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createObject();

  factory DatabaseHelper () {
    if(_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }
    return _databaseHelper;
  }

  static const String _tableFavoriteResto = 'favorites';

  Future <Database> _initializeDb () async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/favoriteresto.db',
      onCreate: (db,version) async {
        await db.execute(
          '''
            CREATE TABLE $_tableFavoriteResto (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating REAL
            )
          '''
        );
      },
      version: 1,
    );
    return db;
  }

  Future <Database> get database async {
    if(_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  Future <void> insertFavoriteResto(Restaurant restaurants) async {
    final db = await database;
    await db.insert(_tableFavoriteResto, restaurants.toJson());
  }


  Future <List<Restaurant>> getFavoriteResto() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query (_tableFavoriteResto);
    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future <Map> getFavoriteRestoById (String id) async {
    final db = await database;

    List <Map<String, dynamic>> results = await db.query(
      _tableFavoriteResto,
      where: 'id = ?',
      whereArgs: [id],
    );

    if(results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future <void> removeFavoriteResto (String id) async {
    final db = await database;

    await db.delete(
      _tableFavoriteResto,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}