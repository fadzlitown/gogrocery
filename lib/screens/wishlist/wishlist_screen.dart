import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_grocery/provider/wishlist_provider.dart';
import 'package:go_grocery/screens/cart/empty_cart.dart';
import 'package:go_grocery/screens/wishlist/wishlist_widget.dart';
import 'package:provider/provider.dart';

import '../../services/Utils.dart';
import '../../services/global_methods.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/green_btn_widget.dart';
import '../cart/cart_widget.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  static const routeName = "/WishlistScreen";

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final list = wishlistProvider.getWishItems.values.toList().reversed.toList();
    bool isEmpty = list.isEmpty;

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
              Visibility(
                visible: !isEmpty,
                child: IconButton(
                    onPressed: () {
                      GlobalMethods.showOkCancelDialog(
                          context,
                          'Empty Wishlist',
                          'Are you sure? ',
                          IconlyLight.delete,
                          positiveCallback: () {
                            wishlistProvider.clearWishlist();
                          },
                          negativeCallback: () {
                            if(Navigator.canPop(context)) Navigator.pop(context);
                          });
                    },
                    icon: Icon(IconlyBroken.delete, color: util.color)),
              )
            ],
            title: Text(
              'Wishlist',
              style: TextStyle(
                  color: !util.isDarkTheme ? Colors.black87 : Colors.white),
            )),
        body: (isEmpty)
            ? EmptyScreen('Your wishlist is empty',
                'assets/images/wishlist.png', true, 'Add a wish now!')
            : MasonryGridView.count(
                itemCount: list.length,
                crossAxisCount: 1,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: list[index],
                    child: WishlistWidget(productId: list[index].productId),
                  );
                }));
  }
}
