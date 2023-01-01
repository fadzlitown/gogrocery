import 'package:flutter/material.dart';
import 'package:go_grocery/provider/dark_theme_provider.dart';
import 'package:go_grocery/screens/auth/login_screen.dart';
import 'package:go_grocery/screens/feed/feed_detail_screen.dart';
import 'package:go_grocery/screens/feed_screen.dart';
import 'package:go_grocery/screens/home_screen.dart';
import 'package:go_grocery/screens/nav_btm_bar.dart';
import 'package:go_grocery/screens/onsale_screen.dart';
import 'package:go_grocery/screens/orders/orders_screen.dart';
import 'package:go_grocery/screens/viewedRecently/viewed_recently_screen.dart';
import 'package:go_grocery/screens/wishlist/wishlist_screen.dart';
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
            home:  const LoginScreen(),
            routes: {
              OnSaleScreen.routeName: (context) => const OnSaleScreen(),
              FeedScreen.routeName : (context) => const FeedScreen(),
              FeedDetailScreen.routeName : (context) =>  FeedDetailScreen(quantity: 1,),
              WishlistScreen.routeName : (context) =>  const WishlistScreen(),
              OrdersScreen.routeName : (context) =>  const OrdersScreen(),
              ViewedRecentlyScreen.routeName : (context) =>  const ViewedRecentlyScreen(),
            },
          );
        },
      ),
    );
  }
}

