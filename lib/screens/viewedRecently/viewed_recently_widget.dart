import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/model/viewed_model.dart';
import 'package:go_grocery/provider/products_provider.dart';
import 'package:provider/provider.dart';

import '../../consts/firebase_constants.dart';
import '../../provider/cart_provider.dart';
import '../../provider/viewed_provider.dart';
import '../../services/Utils.dart';
import '../../services/global_methods.dart';
import '../../widgets/price_widget.dart';
import '../../widgets/quantity_increment_decrement.dart';
import '../feed/feed_detail_screen.dart';

class ViewedRecentlyWidget extends StatefulWidget {
  const ViewedRecentlyWidget({Key? key}) : super(key: key);

  @override
  State<ViewedRecentlyWidget> createState() => _ViewedRecentlyWidgetState();
}

class _ViewedRecentlyWidgetState extends State<ViewedRecentlyWidget> {
  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final viewedProduct = Provider.of<ViewedModel>(context);
    final product = productProvider.getProductById(viewedProduct.productId);
    double finalPrice = product.isOnSale ? product.salePrice : product.price;

    final cartProvider = Provider.of<CartProvider>(context); //registered provider model
    bool? isCartExisted = cartProvider.getCartItems.containsKey(product.id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, FeedDetailScreen.routeName, arguments: product.id);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: util.getMediaSize.height * 0.15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
            border: Border.all(color: util.color, width: 0.5)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                      PriceWidget(
                        price: finalPrice,
                        salePrice: product.salePrice,
                        textPrice: '1',
                        isOnSale: product.isOnSale,
                      ),
                    ],
                  ),
                  const Spacer(),
                  QuantityIncrementDecrement(
                      util: util,
                      icon: isCartExisted ?  CupertinoIcons.check_mark : CupertinoIcons.plus,
                      color: Colors.green,
                      func: () {
                        if(!isCartExisted){
                          if (isCurrentUserLogged(context))  cartProvider.addProductIntoCart(productId: product.id, quantity: 1);
                        }
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
