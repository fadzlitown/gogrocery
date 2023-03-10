import 'package:flutter/material.dart';
import 'package:go_grocery/provider/dark_theme_provider.dart';
import 'package:go_grocery/screens/home_screen.dart';
import 'package:go_grocery/services/dark_theme_prefs.dart';
import 'package:provider/provider.dart';

import 'consts/theme_data.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeProvider = DarkThemeProvider();

  void getCurrentTheme() async {
    themeProvider.setDarkTheme = await themeProvider.prefs
        .getTheme(); //add setter inside our provide before launch the app
  }

  @override
  void initState() {
    // before our UI MaterialApp get rendered, we need set the theme first
    getCurrentTheme();
  } // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    bool isDark = true;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeProvider;
        })
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(provider.getDarkTheme, context),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}

