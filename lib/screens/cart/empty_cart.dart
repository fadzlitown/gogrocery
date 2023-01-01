import 'package:flutter/material.dart';
import 'package:go_grocery/screens/feed_screen.dart';

import '../../services/Utils.dart';
import '../../services/global_methods.dart';

class EmptyScreen extends StatelessWidget {
  String title;
  String iconPath;

  bool doesButtonShown = false;

  String buttonName;
  //'No product on sale yet!
  //'assets/images/box.png' // 'assets/images/cart.png'
  EmptyScreen(this.title, this.iconPath, this.doesButtonShown, this.buttonName,
      {super.key});

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(iconPath, height: util.getMediaSize.height * 0.20),
            Text(title,
                style: TextStyle(
                    color: util.color,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: util.getMediaSize.height*0.15,),
            Visibility(
              visible: doesButtonShown,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.secondary)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700)),
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        context: context, name: FeedScreen.routeName);
                  },
                  child: Text(buttonName,
                    style: TextStyle(fontSize: 20, color: util.color),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
