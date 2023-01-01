import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/screens/feed/feed_detail_screen.dart';
import 'package:go_grocery/services/global_methods.dart';

import '../../services/Utils.dart';
import '../../widgets/price_widget.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);
    return GestureDetector(
      onTap: () {
        GlobalMethods.navigateTo(
            context: context, name: FeedDetailScreen.routeName);
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
                  child: Icon(IconlyLight.bag, size: 25, color: util.color),
                  onTap: () {
                    print('Bag pressed');
                  },
                ),
                SizedBox(width: util.getMediaSize.width * 0.05),
                GestureDetector(
                  child: const Icon(IconlyLight.heart,
                      size: 25, color: Colors.red),
                  onTap: () {
                    print('Heart pressed');
                  },
                )
              ]),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 1, right: 1),
                      width: util.getMediaSize.width * 0.2,
                      height: util.getMediaSize.width * 0.2,
                      child: FancyShimmerImage(
                          imageUrl: 'https://via.placeholder.com/80x80',
                          boxFit: BoxFit.fill)),
                  const Spacer(),
                  Column(
                    children: [
                      Text('Name..',
                          style: TextStyle(
                              color: util.color,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      PriceWidget(
                        price: 3.00,
                        salePrice: 2.00,
                        textPrice: '1',
                        isOnSale: false,
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
