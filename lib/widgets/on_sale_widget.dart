import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/widgets/price_widget.dart';
import 'package:provider/provider.dart';

import '../model/products_model.dart';
import '../provider/cart_provider.dart';
import '../screens/feed/feed_detail_screen.dart';
import '../services/Utils.dart';
import 'heart_wishlist_widget.dart';

class OnSalesWidget extends StatefulWidget {
  const OnSalesWidget({Key? key}) : super(key: key);

  @override
  State<OnSalesWidget> createState() => _OnSalesWidgetState();
}

class _OnSalesWidgetState extends State<OnSalesWidget> {


  @override
  Widget build(BuildContext context) {
    //Registered Provider Model
    ProductModel product = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context); //registered provider model
    bool? isCartExisted = cartProvider.getCartItems.containsKey(product.id);

    Size size = Utils(context).getMediaSize;
    final color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.9),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: (){
            Navigator.pushNamed(context, FeedDetailScreen.routeName, arguments: product.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FancyShimmerImage(imageUrl: product.imageUrl ,height: size.width*0.20, width: size.width*0.20, boxFit: BoxFit.fill),
                        // Image.network("https://via.placeholder.com/80x80",
                        //     height: size.height*0.12, fit: BoxFit.fill),
                        const SizedBox(height: 10, width: 10,),
                        Column(children: [
                          Text(product.isPiece ? '1 piece' : '1 kg', style: TextStyle(color: color, fontSize: 18)),
                          const SizedBox(height: 6),
                          Row(children: [
                            GestureDetector(
                              child:  Icon(isCartExisted ?  IconlyBold.bag : IconlyLight.bag, size: 22, color: color),
                              onTap: (){
                                if(!isCartExisted) cartProvider.addProductIntoCart(productId: product.id, quantity: 1);
                                print('Bag pressed');
                              },
                            ),
                            HeartWishlistWidget(productId: product.id)
                          ]),
                        ]),
                      ],),
                  ],
                ),
                PriceWidget(price: product.price, salePrice: product.salePrice, textPrice: '1', isOnSale: product.isOnSale),
                const SizedBox(height: 5,),
                Text(product.title, style: TextStyle(color: color, fontSize: 16),),
                const SizedBox(height: 5,),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
