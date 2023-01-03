import 'package:flutter/cupertino.dart';
import 'package:go_grocery/model/viewed_model.dart';
import 'package:go_grocery/model/wishlist_model.dart';

class ViewedProvider with ChangeNotifier {
  final Map<String, ViewedModel> _viewedListItems = {};

  Map<String, ViewedModel> get getViewedList {
    return _viewedListItems;
  }

  bool isExisted(String productId) {
    return _viewedListItems.containsKey(productId);
  }

  void addWishItemToList(String productId){
    _viewedListItems.putIfAbsent(productId, () => ViewedModel(id: DateTime.now().toString(), productId: productId));
    notifyListeners();
  }

  void clearViewedList(){
    _viewedListItems.clear();
    notifyListeners();  //immediately clear in current state
  }

}
