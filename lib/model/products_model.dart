import 'package:flutter/material.dart';

//todo l -This model ChangeNotifier will notify to all listeners. ChangeNotifierProvider will emit data /list to widget! eg. ChangeNotifierProvider.value(value: list[index], child: YourWidget())
//todo Thus, any widget subscribed /registered to Provider.of<ProductModel>(context); This widget will get notify/update the changes.
class ProductModel with ChangeNotifier {
  final String id, title, imageUrl, productCategoryName;
  final double price, salePrice;
  final bool isOnSale, isPiece;

  ProductModel(
      {
      required this.id,
      required this.title,
      required this.imageUrl,
      required this.productCategoryName,
      required this.price,
      required this.salePrice,
      required this.isOnSale,
      required this.isPiece});

  void test(){
    notifyListeners();
  }
}
