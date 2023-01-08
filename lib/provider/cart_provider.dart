import 'dart:developer';

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

  Future<void> fetchCart() async {
    final _uid = user?.uid;
    final DocumentSnapshot userCarts =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();

    if (userCarts == null) return;

    final total = userCarts.get('userCart').length;
    for (int i = 0; i < total; i++) {
      _cartItems.putIfAbsent(
          userCarts.get('userCart')[i]['productId'],
          () => CartModel(
              id: userCarts.get('userCart')[i]['cartId'],
              productId: userCarts.get('userCart')[i]['productId'],
              quantity: userCarts.get('userCart')[i]['quantity']));
    }
    notifyListeners();
  }

  Future<void> addQuantityPlusOrMinusOne(
      {required String productId, required bool isPlusOne, required Function function} )  async {

    final _uid = user?.uid;
    var oldQuantity = 0;
    CartModel updateCart = _cartItems.update(
        productId,
        (val){
          oldQuantity = val.quantity;
          return CartModel(
            id: val.id,
            productId: productId,
            quantity: isPlusOne ? val.quantity + 1 : val.quantity - 1);
        });

    //TODO - As of now, remove &  update cart but the process was a bit expensive! need to refactor this!
    await FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'userCart': FieldValue.arrayRemove([
        {'cartId': updateCart.id, 'productId': productId, 'quantity': oldQuantity}
      ])
    }).then((value) async {
      await FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'userCart': FieldValue.arrayUnion([
          {'cartId': updateCart.id, 'productId': productId, 'quantity': updateCart.quantity}
        ])
      });
    }).then((value){
      function();
      notifyListeners();
    });


  }

  Future<void> removeItem(
      {required String productId,
      required String cartID,
      required int quantity}) async {
    final _uid = user?.uid;
    await FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'userCart': FieldValue.arrayRemove([
        {'cartId': cartID, 'productId': productId, 'quantity': quantity}
      ])
    });

    _cartItems.remove(productId);
    await fetchCart();
    notifyListeners();
  }

  Future<void> clearRemoteCarts() async {
    final _uid = user?.uid;
    await FirebaseFirestore.instance.collection('users').doc(_uid).update({
      'userCart': []
      // used [] to keep userCart empty value instead of FieldValue.delete() --> will delete the whole thing
    });
    _cartItems.clear(); //update clear list
    notifyListeners(); //immediately clear UI in current state
  }

  void clearLocalCarts() {
    _cartItems.clear();
    notifyListeners(); //immediately clear in current state
  }
}
