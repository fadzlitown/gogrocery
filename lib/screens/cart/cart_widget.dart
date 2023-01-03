import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/model/cart_model.dart';
import 'package:go_grocery/provider/products_provider.dart';
import 'package:go_grocery/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import '../../services/Utils.dart';
import '../../widgets/heart_wishlist_widget.dart';
import '../../widgets/quantity_increment_decrement.dart';
import '../feed/feed_detail_screen.dart';

class CartWidget extends StatefulWidget {
  int quantity = 1;
  String productId;

  CartWidget({required this.productId, required this.quantity});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final TextEditingController _quantityController =
      TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    _quantityController.text = '${widget.quantity}';
  }


  @override
  void dispose() {
    super.dispose();
    _quantityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);
    final provider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final product = provider.getProductById(widget.productId);
    double finalPrice = product.isOnSale ? product.salePrice : product.price;

    final cart = Provider.of<CartModel>(context);
    _quantityController.text = (cart.quantity).toString();
    double totalPrice = finalPrice * int.parse(_quantityController.text);

    return GestureDetector(
      //a widget that detects gestures, eg. any taps / pressed / drag
      onTap: () {
        Navigator.pushNamed(context, FeedDetailScreen.routeName, arguments: cart.productId);
      },
      child: Container(
        margin: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.98),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(10),
              // color: Colors.red, todo --> we cannot set for both color inside Container & BoxDecoration! Will caused error while rendering
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12)),
              child: FancyShimmerImage(
                  imageUrl: product.imageUrl,
                  height: util.getMediaSize.width * 0.20,
                  width: util.getMediaSize.width * 0.20,
                  boxFit: BoxFit.fill),
            ),
            Column(
              children: [
                Text(product.title,
                    style: TextStyle(
                        color: util.color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: util.getMediaSize.width * 0.45,
                  child: Row(
                    children: [
                      QuantityIncrementDecrement(
                          util: util,
                          icon: CupertinoIcons.minus,
                          color: Colors.red,
                          func: () {
                            setState(() {
                              if(_quantityController.text=='1'){
                                return;
                              } else {
                                cartProvider.addQuantityPlusOrMinusOne(productId: cart.productId,  isPlusOne: false);
                                setState(() {
                                  _quantityController.text=(int.parse(_quantityController.text)-1).toString();
                                });
                              }
                            });
                          }),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 7,right: 7),
                          child: TextField(
                              textAlign: TextAlign.center,
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                              ],
                              onChanged: (val){
                                setState(() {
                                  if(val.isEmpty) _quantityController.text='1';
                                  else {
                                    return;
                                  }
                                });
                              },
                              decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide()))),
                        ),
                      ),
                      QuantityIncrementDecrement(
                          util: util,
                          icon: CupertinoIcons.plus,
                          color: Colors.green,
                          func: () {
                            cartProvider.addQuantityPlusOrMinusOne(productId: cart.productId,  isPlusOne: true);
                            setState(() {
                              if(_quantityController.text=='1'){
                                _quantityController.text=(int.parse(_quantityController.text)+1).toString();
                                return;
                              } else {
                                _quantityController.text=(int.parse(_quantityController.text)+1).toString();
                              }
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: [
                  InkWell(onTap: (){
                    cartProvider.removeItem(cart.productId);
                  }, child: const Icon(CupertinoIcons.cart_badge_minus, color: Colors.red, size: 20,),),
                  const SizedBox(height: 7), //add some margin
                  HeartWishlistWidget(productId: product.id),
                  Text('\$${totalPrice.toStringAsFixed(2)}', style: TextStyle(color: util.color ),)
                ],)),
            const SizedBox(width: 8)
          ],
        ),
      ),
    );
  }
}
