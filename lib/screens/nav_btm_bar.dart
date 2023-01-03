import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/screens/cart.dart';
import 'package:go_grocery/screens/categories.dart';
import 'package:go_grocery/screens/home_screen.dart';
import 'package:go_grocery/screens/user.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../provider/dark_theme_provider.dart';

class NavBottomBarScreen extends StatefulWidget {
  @override
  State<NavBottomBarScreen> createState() => _NavBottomBarScreenState();
  static const routeName = "/NavBottomBarScreen";

}

class _NavBottomBarScreenState extends State<NavBottomBarScreen> {
  final List<Map<String, dynamic>> _pagesConfig = [
    {
      'page': HomeScreen(),
      'navBtn': const BottomNavigationBarItem(
          icon: Icon(IconlyLight.home), label: "Home")
    },
    {
      'page': CategoriesScreen(),
      'navBtn': const BottomNavigationBarItem(
          icon: Icon(IconlyLight.category), label: "Category")
    },
    {
      'page': const CartScreen(),
      'navBtn': const BottomNavigationBarItem(
          label: "Cart",
          icon: Icon(IconlyLight.buy))
    },
    {
      'page': UserScreen(),
      'navBtn': const BottomNavigationBarItem(
          icon: Icon(IconlyLight.user2), label: "User")
    }
  ];

  int _selectedIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      //used Stateful Widget coz of this changes
      _selectedIndex = index;
    });
  }

  // final List<BottomNavigationBarItem> _ <BottomNavigationBarItem>[
  //   const BottomNavigationBarItem(icon: Icon(IconlyLight.home), label: "Home"),
  //   const BottomNavigationBarItem(icon: Icon(IconlyLight.category), label: "Category"),
  //   const BottomNavigationBarItem(icon: Icon(IconlyLight.buy), label: "Cart"),
  //   const BottomNavigationBarItem(icon: Icon(IconlyLight.user2), label: "User"),
  // ];

  @override
  Widget build(BuildContext context) {
    DarkThemeProvider themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    //todo l - either using Provider.of<CartProvider>(context); OR Consumer<CartProvider> like below

    //todo learn - converting dynamic _pagesConfig into new list!
    List<BottomNavigationBarItem> listBtmNav = _pagesConfig
        .fold<List<BottomNavigationBarItem>>([], (previousValue, element) {
      if (element['navBtn'] is BottomNavigationBarItem) {
        final item = (element['navBtn'] as BottomNavigationBarItem);
        if (item.label == 'Cart') {
          element['navBtn'] = BottomNavigationBarItem(
              label: "Cart",
              icon: Consumer<CartProvider>(//todo l - will keep listening & updating on 1 widget with Consumer
                builder: (context, provider, child) {
                  return Badge(
                      toAnimate: true,
                      shape: BadgeShape.circle,
                      badgeColor: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                      badgeContent: Text(
                          provider.getCartItems.length.toString(),
                          style: const TextStyle(color: Colors.white)),
                      position: BadgePosition.topEnd(top: -5, end: -5),
                      //todo optional --> the pos can be changed
                      child: const Icon(IconlyLight.buy));
                },
              ));
        }
      }
      return List.from(previousValue)
        ..add(element['navBtn']);
    }
    );
    bool selectedCartScreen =
        listBtmNav[_selectedIndex].label.toString() == "Cart";

    return Scaffold(
      appBar: (!selectedCartScreen)
          ? AppBar(
          title: Text(listBtmNav[_selectedIndex].label.toString(),
              style: TextStyle(
                  color: !_isDark ? Colors.black87 : Colors.white)),
          backgroundColor:
          _isDark ? Theme
              .of(context)
              .cardColor : Colors.white)
          : null,
      backgroundColor: _isDark ? Theme
          .of(context)
          .cardColor : Colors.white,
      body: _pagesConfig[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // todo learn -> by default the bottonNav is shifting animation. now is just fixed plain
        unselectedItemColor: _isDark ? Colors.white12 : Colors.black26,
        selectedItemColor: _isDark ? Colors.lightBlue.shade300 : Colors.black87,
        showSelectedLabels: false,
        //todo leanr - don't want to show label name
        showUnselectedLabels: false,
        //todo leanr - don't want to show label name
        currentIndex: _selectedIndex,
        onTap: _selectedPage,
        items: listBtmNav,
      ),
    );
  }
}
