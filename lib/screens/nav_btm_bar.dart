import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/screens/cart.dart';
import 'package:go_grocery/screens/categories.dart';
import 'package:go_grocery/screens/home_screen.dart';
import 'package:go_grocery/screens/user.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class NavBottomBarScreen extends StatefulWidget {
  @override
  State<NavBottomBarScreen> createState() => _NavBottomBarScreenState();
}

class _NavBottomBarScreenState extends State<NavBottomBarScreen> {
  final List<Map<String, dynamic>> _pagesConfig = [
    {'page':const HomeScreen(), 'navBtn': const BottomNavigationBarItem(icon: Icon(IconlyLight.home), label: "Home") },
    {'page':const CategoriesScreen(), 'navBtn': const BottomNavigationBarItem(icon: Icon(IconlyLight.category), label: "Category") },
    {'page':const CartScreen(), 'navBtn': const BottomNavigationBarItem(icon: Icon(IconlyLight.buy), label: "Cart") },
    {'page':const UserScreen(), 'navBtn': const BottomNavigationBarItem(icon: Icon(IconlyLight.user2), label: "User") }
  ];

  int _selectedIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      //used Stateful Widget coz of this changes
      _selectedIndex = index;
    });
  }

  // final List<BottomNavigationBarItem> _list = <BottomNavigationBarItem>[
  //   const BottomNavigationBarItem(icon: Icon(IconlyLight.home), label: "Home"),
  //   const BottomNavigationBarItem(icon: Icon(IconlyLight.category), label: "Category"),
  //   const BottomNavigationBarItem(icon: Icon(IconlyLight.buy), label: "Cart"),
  //   const BottomNavigationBarItem(icon: Icon(IconlyLight.user2), label: "User"),
  // ];

  @override
  Widget build(BuildContext context) {
    DarkThemeProvider themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;

    //todo learn - converting dynamic _pagesConfig into new list!
    List<BottomNavigationBarItem> listBtmNav = _pagesConfig.fold<List<BottomNavigationBarItem>>([], (previousValue, element) => List.from(previousValue)..add(element['navBtn']));

    return Scaffold(
      appBar: AppBar(
          title: Text(listBtmNav[_selectedIndex].label.toString(),
              style: TextStyle(color: !_isDark ? Colors.black87 : Colors.white)), backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white),
      backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
      body: _pagesConfig[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // todo learn -> by default the bottonNav is shifting animation. now is just fixed plain
        unselectedItemColor: _isDark ? Colors.white12 : Colors.black26,
        selectedItemColor: _isDark ? Colors.lightBlue.shade300 : Colors.black87,
        showSelectedLabels: false, //todo leanr - don't want to show label name
        showUnselectedLabels: false, //todo leanr - don't want to show label name
        currentIndex: _selectedIndex,
        onTap: _selectedPage,
        items: listBtmNav,
      ),
    );
  }
}
