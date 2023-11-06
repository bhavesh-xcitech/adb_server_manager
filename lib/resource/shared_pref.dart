import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String IS_LOGGEDIN = 'isLoggedIn';
  static const String IS_NOTIFICATION_ENABLE = 'isNotificationEnable';

  static Future<SharedPreferences> _getPref() async {
    return await SharedPreferences.getInstance();
  }

  static Future<bool> setLoggedIn(bool isLoggedIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool(IS_LOGGEDIN, isLoggedIn);
  }

  static Future<bool> getLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(IS_LOGGEDIN) ?? false;
  }

  static Future<bool> setEnableNotification(bool isNotificationEnable) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool(IS_NOTIFICATION_ENABLE, isNotificationEnable);
  }

  static Future<bool> getEnableNotification() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(IS_NOTIFICATION_ENABLE) ?? false;
  }
}
