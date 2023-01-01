import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_grocery/screens/wishlist/wishlist_widget.dart';

import '../../services/Utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/green_btn_widget.dart';
import '../cart/cart_widget.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  static const routeName = "/WishlistScreen";

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: const BackWidget(),
            elevation: 5,
            automaticallyImplyLeading: false,
            //todo -->
            backgroundColor:
                util.isDarkTheme ? Theme.of(context).cardColor : Colors.white,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(IconlyBroken.delete, color: util.color))
            ],
            title: Text(
              'Wishlist',
              style: TextStyle(
                  color: !util.isDarkTheme ? Colors.black87 : Colors.white),
            )),
        body: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            itemBuilder: (context, index) {
              return const WishlistWidget();
            }));
  }
}
