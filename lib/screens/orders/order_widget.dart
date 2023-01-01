

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../services/Utils.dart';
import '../../services/global_methods.dart';
import '../../widgets/price_widget.dart';
import '../feed/feed_detail_screen.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({Key? key}) : super(key: key);

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
                          imageUrl: 'https://via.placeholder.com/80x80',
                          boxFit: BoxFit.fill)),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product name x10',
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
                  ),
                  const Spacer(),
                  Text('03/07/2022',
                      style: TextStyle(
                          color: util.color,
                          fontSize: 15,
                          fontWeight: FontWeight.normal))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}