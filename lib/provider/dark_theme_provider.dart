import 'package:flutter/cupertino.dart';
import 'package:go_grocery/services/dark_theme_prefs.dart';

//todo ChangeNotifier will always keep listening for changes
class DarkThemeProvider with ChangeNotifier{
  DarkThemePrefs prefs = DarkThemePrefs();
  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool val){ // if setter setDarkTheme, then need to use provider.setDarkTheme = ???
    _darkTheme = val;
    prefs.setDarkTheme(val);
    notifyListeners();  //Call all the registered listeners. Call this method whenever the object changes
  }
}