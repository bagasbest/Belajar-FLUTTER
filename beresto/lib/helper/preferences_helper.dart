
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper ({@required this.sharedPreferences});

  static const NIGHT_THEME = 'NIGHT_THEME';
  static const BERESTO_NOTIFICATION = 'BERESTO_NOTIFICATION';

  Future <bool> get isNightTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(NIGHT_THEME) ?? false;
  }

  void setNightTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(NIGHT_THEME, value);
  }

  Future <bool> get isBerestoNotificationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(BERESTO_NOTIFICATION) ?? false;
  }

  void setBerestoNotification (bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(BERESTO_NOTIFICATION, value);
  }
}