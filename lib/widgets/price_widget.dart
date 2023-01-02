import 'package:flutter/material.dart';

import '../services/Utils.dart';

class PriceWidget extends StatelessWidget {
  final double salePrice, price;
  final String textPrice;
  final bool isOnSale;


  PriceWidget({required this.salePrice, required this.price, required this.textPrice, required this.isOnSale});

  @override
  Widget build(BuildContext context) {
    final util = Utils(context);
    double userPrice = isOnSale ? salePrice : price;

    return FittedBox(
      //FittedBox the image is stretched to fill the entire [Container]
      child: Row(
        children:   [
          Text(
            '\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.green, fontSize: 22),
          ),
          const SizedBox(width: 5),
          Visibility( //todo --> this Visibility widget will shown based on visible check
            visible: isOnSale ? true : false,
            child: Text(
              '\$${(price * int.parse(textPrice)).toStringAsFixed(2)}',
              style: const TextStyle(
                  color: Colors.red,
                  fontSize: 22,
                  decoration: TextDecoration.lineThrough),
            ),
          )
        ],
      ),
    );
  }
}
