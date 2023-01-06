import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/provider/dark_theme_provider.dart';
import 'package:go_grocery/screens/auth/forget_password.dart';
import 'package:go_grocery/screens/orders/orders_screen.dart';
import 'package:go_grocery/screens/viewedRecently/viewed_recently_screen.dart';
import 'package:go_grocery/screens/wishlist/wishlist_screen.dart';
import 'package:go_grocery/services/global_methods.dart';
import 'package:go_grocery/widgets/loading_fullscreen_widget.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_constants.dart';
import '../widgets/ListTileWidget.dart';
import 'auth/login_screen.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");
  bool _isLoading = false;
  String? _userEmail, _userName, _userAddress="";

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  //todo l - before Widget build UI get render, this method need to call the API first in INITSTATE!!
  Future<void> getUserData() async {
    setState(() => _isLoading = true);

    if (user == null) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final _uid = user?.uid;
      final DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();

      if (userData == null) return;

      _userEmail = userData.get('email');
      _userName = userData.get('name');
      _userAddress = userData.get('shippingAddress');
      _addressTextController.text = _userAddress.toString();
    } catch (error) {
      GlobalMethods.showOkCancelDialog(
          context, 'Error Occurred', '$error', Icons.error,
          positiveCallback: () {}, negativeCallback: () {});
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<DarkThemeProvider>(context);
    return LoadingFullscreenWidget(
      isLoading: _isLoading,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //will push to left start
              mainAxisAlignment: MainAxisAlignment.center,
              children: _listWidget(context)),
        ),
      )),
    );
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
              text: '$_userName',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: FontWeight.normal),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('$_userName');
                }),
        ])));
    llist.add(Text('$_userEmail',
        style: const TextStyle(
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
          _userAddress.toString(),
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
        "content": [
          auth.currentUser != null ? "Logout" : "Login",
          "Subtitle Logout",
          auth.currentUser != null
              ? const Icon(IconlyBold.logout)
              : const Icon(IconlyBold.login)
        ]
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
      case "Address":
        {
          print('Address');
          if (context != null) {
            await _showAddressDialog(name, _addressTextController.text);
          }
          break;
        }
      case "Wishlist":
        {
          GlobalMethods.navigateTo(
              context: context!, name: WishlistScreen.routeName);
          break;
        }
      case "Orders":
        {
          GlobalMethods.navigateTo(
              context: context!, name: OrdersScreen.routeName);
          break;
        }
      case "Viewed":
        {
          GlobalMethods.navigateTo(
              context: context!, name: ViewedRecentlyScreen.routeName);
          break;
        }
      case "Forget":
        {
          Navigator.of(context!).push(MaterialPageRoute(
              builder: (context) => const ForgetPasswordScreen()));
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
          if (context != null) {
            if (auth.currentUser == null) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
              return;
            }
            await GlobalMethods.showOkCancelDialog(
                context,
                'Sign out',
                'Do you wanna sign out?',
                IconlyLight.logout, positiveCallback: () async {
              await auth.signOut().then((value) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginScreen()));
              });
              //todo l - if there's an existing screen on backstack? then uses POP or PUSH REPLACEMENT
              // GlobalMethods.navigateTo(context: context, name: LoginScreen.routeName);
              // Navigator.pushNamed(context, LoginScreen.routeName);
            }, negativeCallback: () {});
          }
          break;
        }
      case "Login":
        {
          if (context != null) {
            if (auth.currentUser == null) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
              return;
            }
          }
          break;
        }
    }
  }

  Future<void> _showAddressDialog(String name, [String? address]) async {
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
                decoration:
                    const InputDecoration(hintText: "Enter your address here")),
            actions: [
              TextButton(
                  onPressed: () async {
                    String uid = user!.uid;
                    try {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .update(
                              {'shippingAddress': _addressTextController.text});

                      setState(() { //update the address UI too
                        _userAddress = _addressTextController.text;
                      });
                      if (!mounted) return;
                      Navigator.pop(context);
                    } catch (error) {
                      GlobalMethods.showOkCancelDialog(
                          context, 'Error Occurred', '$error', Icons.error,
                          positiveCallback: () {}, negativeCallback: () {});
                    }
                  },
                  child: const Text('Update'))
            ],
          );
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
