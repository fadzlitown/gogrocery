import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/model/products_model.dart';
import 'package:go_grocery/provider/cart_provider.dart';
import 'package:go_grocery/provider/products_provider.dart';
import 'package:provider/provider.dart';

import '../../model/cart_model.dart';
import '../../services/Utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/green_btn_widget.dart';
import '../../widgets/price_widget.dart';
import '../../widgets/quantity_increment_decrement.dart';

class FeedDetailScreen extends StatefulWidget {
  static const routeName = "/FeedDetailScreen";

  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {

  final TextEditingController _quantityController =
  TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _quantityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final provider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final product = provider.getProductById(productId);
    bool? isCartExisted = cartProvider.getCartItems.containsKey(product.id);
    if(isCartExisted){
      _quantityController.text = (cartProvider.getCartItems[productId]?.quantity).toString();
    }

    double finalPrice = product.isOnSale ? product.salePrice : product.price;
    double totalPrice = finalPrice * int.parse(_quantityController.text);

    return  Scaffold(appBar: AppBar(
        elevation: 5,
        backgroundColor:
        util.isDarkTheme ? Theme.of(context).cardColor : Colors.white,
        leading: const BackWidget(),
        title: Text('Detail',
          style: TextStyle(
              color: !util.isDarkTheme ? Colors.black87 : Colors.white),
        )),
      body: Column(
        children: [
        FancyShimmerImage(
            imageUrl: product.imageUrl,
            height: util.getMediaSize.width * 0.5,
            width: double.infinity,
            boxFit: BoxFit.fitHeight),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(product.title, style: TextStyle(color: util.color, fontSize: 20, fontWeight: FontWeight.bold)),
              GestureDetector(
                child: Icon(IconlyLight.heart, size: 22, color: util.color),
                onTap: (){
                  print('Heart pressed');
                },
              )            ],
          ),
        ),
          Padding(
            padding:  const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '\$${finalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.green, fontSize: 22),
                    ),
                    // PriceWidget(price: product.price,salePrice: product.salePrice,textPrice: '1', isOnSale: product.isOnSale,),
                    Text(product.isPiece ? '/piece  ':'/kg  ', style: TextStyle(color: util.color, fontSize: 20, fontWeight: FontWeight.normal)),
                    Visibility(
                      visible: product.isOnSale,
                      child: Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(color: util.color, fontSize: 17, decoration: TextDecoration.lineThrough ),
                      ),
                    )
                  ],
                ),
                GreenButtonWidget('Free Delivery', true, (){}),
              ],
            ),
          ),
          Padding(
            padding:  const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: util.getMediaSize.width * 0.2,),
                QuantityIncrementDecrement(
                    util: util,
                    icon: CupertinoIcons.minus,
                    color: Colors.red,
                    func: () {
                      if(_quantityController.text=='1'){
                        return;
                      } else {
                        if(isCartExisted) cartProvider.addQuantityPlusOrMinusOne(productId: productId,  isPlusOne: false);
                        setState(() {
                          _quantityController.text=(int.parse(_quantityController.text)-1).toString();
                        });
                      }
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
                            if(val.isEmpty) {
                              _quantityController.text='1';
                            } else {
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
                      if(isCartExisted) cartProvider.addQuantityPlusOrMinusOne(productId: productId,  isPlusOne: true);
                      setState(() {
                        if(_quantityController.text=='1'){
                          _quantityController.text=(int.parse(_quantityController.text)+1).toString();
                          return;
                        } else {
                          _quantityController.text=(int.parse(_quantityController.text)+1).toString();
                        }
                      });
                    }),
                SizedBox(width: util.getMediaSize.width * 0.2,),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding:  const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.normal)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.green, fontSize: 22),
                        ),
                        // PriceWidget(price: product.price ,salePrice: product.salePrice ,textPrice: _quantityController.text, isOnSale: product.isOnSale,),
                        Text(product.isPiece ? '/${_quantityController.text} piece':'/${_quantityController.text} kg', style: TextStyle(color: util.color, fontSize: 20, fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ],
                ),
                GreenButtonWidget(isCartExisted? 'In cart' : 'Add to cart', true, (){
                  if(!isCartExisted) cartProvider.addProductIntoCart(productId: product.id, quantity: int.parse(_quantityController.text));
                }),
              ],
            ),
          ),
        ],),
    );
  }
}
