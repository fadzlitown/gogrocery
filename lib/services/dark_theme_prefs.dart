import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePrefs {
  static const themeStatus = "themeStatus";

  setDarkTheme(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();  // required Future<SharedPreferences> getInstance() !! hence use async wait
    prefs.setBool(themeStatus, val);
  }
  
  Future<bool> getTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? false;
  }
}