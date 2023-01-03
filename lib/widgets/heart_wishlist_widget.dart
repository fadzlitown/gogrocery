import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

class HeartWishlistWidget extends StatelessWidget {
  String productId;

  HeartWishlistWidget({ required this.productId});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return GestureDetector(
      child:  Icon(IconlyBold.heart,
          size: 25, color: wishlistProvider.isExisted(productId) ? Colors.red : Colors.black),
      onTap: () {
        wishlistProvider.addRemoveWishItemToList(productId);
        print('Heart pressed');
      },
    );
  }
}
