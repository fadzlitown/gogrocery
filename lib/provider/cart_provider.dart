import 'package:flutter/cupertino.dart';
import 'package:go_grocery/model/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  void addProductIntoCart({required String productId, required int quantity}) {
    _cartItems.putIfAbsent(
        productId,
        () => CartModel(
            id: DateTime.now().toString(),
            productId: productId,
            quantity: quantity));
    notifyListeners();
  }

  void addQuantityPlusOrMinusOne({required String productId, required bool isPlusOne}) {
    _cartItems.update(productId,
            (val) => CartModel(
            id: val.id,
            productId: productId,
            quantity: isPlusOne ? val.quantity+1 : val.quantity-1));
    notifyListeners();
  }

  void removeItem(String productId){
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCarts(){
    _cartItems.clear();
    notifyListeners();  //immediately clear in current state
  }

}
