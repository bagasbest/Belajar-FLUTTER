
import 'package:beresto/common/styles.dart';
import 'package:beresto/helper/preferences_helper.dart';
import 'package:flutter/material.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({@required this.preferencesHelper}) {
    _getTheme();
    _getBerestoNotification();
  }

  bool _isNightTheme = false;
  bool get isNightTheme => _isNightTheme;

  bool _isBerestoNotificationActive = false;
  bool get isBerestoNotificationActive => _isBerestoNotificationActive;

  ThemeData get themeData => _isNightTheme ? nightTheme : lightTheme;

  void _getTheme() async {
    _isNightTheme = await preferencesHelper.isNightTheme;
    notifyListeners();
  }

  void _getBerestoNotification() async {
    _isBerestoNotificationActive = await preferencesHelper.isBerestoNotificationActive;
    notifyListeners();
  }

  void enableNightTheme(bool value) {
    preferencesHelper.setNightTheme(value);
    _getTheme();
  }

  void enableRestoOfTheDayNotification(bool value) {
    preferencesHelper.setBerestoNotification(value);
    _getBerestoNotification();
  }

}