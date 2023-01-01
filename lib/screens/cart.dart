import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/screens/cart/cart_widget.dart';

import '../services/Utils.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);

    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(IconlyBroken.delete, color: util.color))
            ],
            elevation: 5,
            backgroundColor:
                util.isDarkTheme ? Theme.of(context).cardColor : Colors.white,
            title: Text(
              'Cart (2)',
              style: TextStyle(
                  color: !util.isDarkTheme ? Colors.black87 : Colors.white),
            )),
        body: Column(
          children: [
            _orderNowWidget(context),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CartWidget(
                    quantity: 10,
                  );
                },
                itemCount: 10,
              ),
            ),
          ],
        ));
  }

  Widget _orderNowWidget(BuildContext context) {
    Utils util = Utils(context);

    return Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: util.getMediaSize.height * 0.1,
        padding: const EdgeInsets.symmetric(horizontal: 15),  //todo symmetric - horizontal padding between start & end / left & right
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Order Now',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )),
            // Spacer(), todo l: remove this spacer then directly used --> MainAxisAlignment.spaceBetween
            Text('Total: \$0.522', style: TextStyle(color: util.color, fontSize: 18, fontWeight: FontWeight.bold))
          ],
        ));
  }
}


