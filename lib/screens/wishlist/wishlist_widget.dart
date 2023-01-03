import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/model/wishlist_model.dart';
import 'package:go_grocery/provider/products_provider.dart';
import 'package:go_grocery/provider/wishlist_provider.dart';
import 'package:go_grocery/screens/feed/feed_detail_screen.dart';
import 'package:go_grocery/services/global_methods.dart';
import 'package:go_grocery/widgets/heart_wishlist_widget.dart';
import 'package:provider/provider.dart';

import '../../consts/firebase_constants.dart';
import '../../provider/cart_provider.dart';
import '../../services/Utils.dart';
import '../../widgets/price_widget.dart';

class WishlistWidget extends StatelessWidget {
  String productId;

   WishlistWidget({required this.productId});

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final product = productProvider.getProductById(productId);

    final cartProvider = Provider.of<CartProvider>(context); //registered provider model
    bool? isCartExisted = cartProvider.getCartItems.containsKey(product.id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, FeedDetailScreen.routeName, arguments: productId);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: util.getMediaSize.height * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
            border: Border.all(color: util.color, width: 0.5)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Spacer(),
                GestureDetector(
                  child:  Icon(isCartExisted ?  IconlyBold.bag : IconlyLight.bag, size: 22, color: util.color),
                  onTap: (){
                    if(!isCartExisted){
                      if (isCurrentUserLogged(context)) cartProvider.addProductIntoCart(productId: product.id, quantity: 1);
                    }
                  },
                ),
                SizedBox(width: util.getMediaSize.width * 0.05),
                HeartWishlistWidget(productId: productId)
              ]),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 1, right: 1),
                      width: util.getMediaSize.width * 0.2,
                      height: util.getMediaSize.width * 0.2,
                      child: FancyShimmerImage(
                          imageUrl: product.imageUrl,
                          boxFit: BoxFit.fill)),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title,
                          style: TextStyle(
                              color: util.color,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: util.getMediaSize.height*0.02),
                      PriceWidget(
                        price: product.price,
                        salePrice: product.salePrice,
                        textPrice: '1',
                        isOnSale: product.isOnSale,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
