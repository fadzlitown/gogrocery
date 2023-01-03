import 'package:flutter/material.dart';
import 'package:go_grocery/provider/cart_provider.dart';
import 'package:go_grocery/provider/dark_theme_provider.dart';
import 'package:go_grocery/provider/products_provider.dart';
import 'package:go_grocery/provider/viewed_provider.dart';
import 'package:go_grocery/provider/wishlist_provider.dart';
import 'package:go_grocery/screens/auth/forget_password.dart';
import 'package:go_grocery/screens/auth/login_screen.dart';
import 'package:go_grocery/screens/auth/register.dart';
import 'package:go_grocery/screens/category_screen.dart';
import 'package:go_grocery/screens/feed/feed_detail_screen.dart';
import 'package:go_grocery/screens/feed_screen.dart';
import 'package:go_grocery/screens/nav_btm_bar.dart';
import 'package:go_grocery/screens/onsale_screen.dart';
import 'package:go_grocery/screens/orders/orders_screen.dart';
import 'package:go_grocery/screens/viewedRecently/viewed_recently_screen.dart';
import 'package:go_grocery/screens/wishlist/wishlist_screen.dart';
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
        }),
        //should add at the highest hierarchy before widget
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => ViewedProvider()),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(provider.getDarkTheme, context),
            home:  const LoginScreen(),
            routes: {
              RegisterScreen.routeName : (context) =>  const RegisterScreen(),
              LoginScreen.routeName : (context) =>  const LoginScreen(),
              ForgetPasswordScreen.routeName : (context) =>  const ForgetPasswordScreen(),
              NavBottomBarScreen.routeName : (context) =>   NavBottomBarScreen(),
              OnSaleScreen.routeName: (context) => const OnSaleScreen(),
              CategoryScreen.routeName: (context) => const CategoryScreen(),
              FeedScreen.routeName : (context) => const FeedScreen(),
              FeedDetailScreen.routeName : (context) =>  FeedDetailScreen(),
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

