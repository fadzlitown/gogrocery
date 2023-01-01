import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/provider/dark_theme_provider.dart';
import 'package:go_grocery/screens/orders/orders_screen.dart';
import 'package:go_grocery/screens/viewedRecently/viewed_recently_screen.dart';
import 'package:go_grocery/screens/wishlist/wishlist_screen.dart';
import 'package:go_grocery/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../widgets/ListTileWidget.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //will push to left start
            mainAxisAlignment: MainAxisAlignment.center,
            children: _listWidget(context)),
      ),
    ));
  }

  // final List<Map<String, dynamic>> _list2 = [
  List<Widget> _listWidget(BuildContext context) {
    DarkThemeProvider themeProvider = Provider.of<DarkThemeProvider>(context);

    List<Widget> llist = List.empty(growable: true);
    llist.add(RichText(
        text: TextSpan(
            text: 'Hi,  ',
            style: const TextStyle(
                color: Colors.cyan, fontSize: 27, fontWeight: FontWeight.bold),
            children: <TextSpan>[
          TextSpan(
              text: 'Fadzli',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: FontWeight.normal),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('My name');
                }),
        ])));
    llist.add(const Text('fadzli@gmail.com',
        style: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.normal)));
    llist.add(const SizedBox(height: 50));
    llist.add(const Divider());
    llist.add(SwitchListTile(
      subtitle:
          themeProvider.getDarkTheme ? const Text('Dark') : const Text('Light'),
      title: themeProvider.getDarkTheme
          ? const Text('Theme',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
          : const Text('Theme',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      secondary: Icon(themeProvider.getDarkTheme
          ? Icons.dark_mode_outlined
          : Icons.light_mode_outlined),
      value: themeProvider.getDarkTheme,
      onChanged: (bool value) {
        themeProvider.setDarkTheme = value;
      },
    ));
    //todo normal map filtering cannot find the index
    // return _list.map( (e) => _listTiles(title: _list[0]['content'][0], subtitle: _list[0]['content'][1], icon: _list[0]['content'][2])).toList();

    final List<Map<String, dynamic>> list = [
      {
        "item": "Address",
        "content": [
          "Address",
          "Subtitle Address",
          const Icon(IconlyBold.user2)
        ],
      },
      {
        "item": "Orders",
        "content": ["Orders", "Subtitle Orders", const Icon(IconlyBold.buy)]
      },
      {
        "item": "Wishlist",
        "content": [
          "Wishlist",
          "Subtitle Wishlist",
          const Icon(IconlyBold.heart)
        ]
      },
      {
        "item": "Viewed",
        "content": ["Viewed", "Subtitle Viewed", const Icon(IconlyBold.hide)]
      },
      {
        "item": "Forget password",
        "content": ["Forget", "Subtitle Forget", const Icon(IconlyBold.lock)]
      },
      {
        "item": "Logout",
        "content": ["Logout", "Subtitle Logout", const Icon(IconlyBold.logout)]
      },
    ];

    List<Widget> widgets = list
        .asMap()
        .entries
        .map((entry) => _listTile(
            title: list[entry.key]['content'][0],
            subtitle: list[entry.key]['content'][1],
            icon: list[entry.key]['content'][2],
            context: context))
        .toList();

    widgets.map((e) => llist.add(e)).toList();
    return llist;

    //this is repetitive approach
    // return [
    //   _listTiles(title: _list[0]['content'][0], subtitle: _list[0]['content'][1], icon: _list[0]['content'][2]),
    //   _listTiles(title: _list[1]['content'][0], subtitle: _list[0]['content'][1], icon: _list[0]['content'][2]),
    //   _listTiles(title: _list[2]['content'][0], subtitle: _list[0]['content'][1], icon: _list[0]['content'][2]),
    //   _listTiles(title: _list[3]['content'][0], subtitle: _list[0]['content'][1], icon: _list[0]['content'][2]),
    // ];
  }

  Widget _listTile(
      {required String title,
      required String subtitle,
      required Icon icon,
      required BuildContext context}) {
    return ListTileWidget(icon, title, subtitle, () {
       onFunction(title, context);
    });
  }

  void onFunction(String name, BuildContext? context) async {
    switch (name) {
      case "Address": {
          print('Address');
          if (context != null) {
           await _showAddressDialog(name);
          }

          break;
        }
      case "Wishlist":{
          if(context!=null) GlobalMethods.navigateTo(context: context, name: WishlistScreen.routeName);
          break;
        }
      case "Orders":{
        if(context!=null) GlobalMethods.navigateTo(context: context, name: OrdersScreen.routeName);
        break;
      }
      case "Viewed":{
        if(context!=null) GlobalMethods.navigateTo(context: context, name: ViewedRecentlyScreen.routeName);
        break;
      }
      case "Theme":
        {
          //todo func
          print('Theme');
          break;
        }
      case "Logout":
        {
          //todo func
          if (context != null) {
            await GlobalMethods.showOkCancelDialog(context, 'Sign out', 'Do you wanna sign out?', IconlyLight.logout ,positiveCallback: (){}, negativeCallback:(){});
          }
          break;
        }
    }
  }

  Future<void> _showAddressDialog(String name) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(name),
            content: TextField(
                // onChanged: (val){
                //   val=_addressTextController.text;
                //   print(_addressTextController.text);
                // },
                controller: _addressTextController,
                maxLines: 5,
                decoration: const InputDecoration(
                    hintText: "Enter your address here")),
            actions: [
              TextButton(onPressed: (){
              }, child: const Text('Update'))
            ],);
        });
  }


  // Future<void> _showLogoutDialog(String name) async {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Row(children:[const Icon(IconlyLight.logout), Text('  $name')] ),
  //           content: const Text('Do you wanna sign out?'),
  //           actions: [
  //             TextButton(onPressed: (){
  //               if(Navigator.canPop(context)) Navigator.pop(context);
  //             }, child: const Text('Cancel')),
  //             TextButton(onPressed: (){
  //             }, child: const Text('OK'))
  //           ],);
  //       });
  // }

  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }
}
