import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_grocery/model/cart_model.dart';

import '../consts/firebase_constants.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  // void addProductIntoCart({required String productId, required int quantity}) {
  //   _cartItems.putIfAbsent(
  //       productId,
  //       () => CartModel(
  //           id: DateTime.now().toString(),
  //           productId: productId,
  //           quantity: quantity));
  //   notifyListeners();
  // }

  Future<void> fetchCart() async{
    final _uid = user?.uid;
    final DocumentSnapshot userCarts = await FirebaseFirestore.instance.collection('users').doc(_uid).get();

    if(userCarts==null) return;

    final total = userCarts.get('userCart').length;
    for(int i=0; i<total; i++){
      _cartItems.putIfAbsent(userCarts.get('userCart')[i]['productId'], () =>
      CartModel(
          id: userCarts.get('userCart')[i]['cartId'],
          productId: userCarts.get('userCart')[i]['productId'],
          quantity: userCarts.get('userCart')[i]['quantity']));
    }
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
