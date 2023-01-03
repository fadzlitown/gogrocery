import 'package:flutter/cupertino.dart';
import 'package:go_grocery/model/wishlist_model.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishListItems = {};

  Map<String, WishlistModel> get getWishItems {
    return _wishListItems;
  }

  bool isExisted(String productId) {
    return _wishListItems.containsKey(productId);
  }

  void addRemoveWishItemToList(String productId){
    if(_wishListItems.containsKey(productId)){
      _wishListItems.remove(productId);
    } else {
      _wishListItems.putIfAbsent(productId, () => WishlistModel(id: DateTime.now().toString(), productId: productId));
    }
    notifyListeners();
  }

  void removeItem(String productId){
    _wishListItems.remove(productId);
    notifyListeners();
  }

  void clearWishlist(){
    _wishListItems.clear();
    notifyListeners();  //immediately clear in current state
  }

}
