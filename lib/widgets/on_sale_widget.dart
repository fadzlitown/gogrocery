import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/widgets/price_widget.dart';

import '../services/Utils.dart';
import 'feed_item_widget.dart';

class OnSalesWidget extends StatefulWidget {
  const OnSalesWidget({Key? key}) : super(key: key);

  @override
  State<OnSalesWidget> createState() => _OnSalesWidgetState();
}

class _OnSalesWidgetState extends State<OnSalesWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getMediaSize;
    final isDarkTheme = Utils(context).isDarkTheme;
    final color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.9),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: (){},
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
                        FancyShimmerImage(imageUrl: 'https://via.placeholder.com/80x80',height: size.width*0.20, width: size.width*0.20, boxFit: BoxFit.fill),
                        // Image.network("https://via.placeholder.com/80x80",
                        //     height: size.height*0.12, fit: BoxFit.fill),
                        SizedBox(height: 10, width: 10,),
                        Column(children: [
                          Text('2KG', style: TextStyle(color: color, fontSize: 22)),
                          SizedBox(height: 6),
                          Row(children: [
                            GestureDetector(
                              child: Icon(IconlyLight.bag, size: 22, color: color),
                              onTap: (){
                                print('Bag pressed');
                              },
                            ),
                            GestureDetector(
                              child: Icon(IconlyLight.heart, size: 22, color: color),
                              onTap: (){
                                print('Heart pressed');
                              },
                            )]),
                        ]),
                      ],),
                  ],
                ),
                PriceWidget(price: 5.9, salePrice: 2.99, textPrice: '1', isOnSale: true),
                const SizedBox(height: 5,),
                Text('Product title', style: TextStyle(color: color, fontSize: 16),),
                const SizedBox(height: 5,),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
