import 'package:flutter/material.dart';
import 'package:go_grocery/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class Utils{
  BuildContext context;
  Utils(this.context);

  bool get isDarkTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;

  Color get color => isDarkTheme ? Colors.white : Colors.black;

  Size get getMediaSize => MediaQuery.of(context).size;

}