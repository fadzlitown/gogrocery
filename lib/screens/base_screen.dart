import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_grocery/screens/nav_btm_bar.dart';
import 'package:provider/provider.dart';

import '../consts/firebase_constants.dart';
import '../provider/cart_provider.dart';
import '../provider/products_provider.dart';
import '../widgets/loading_fullscreen_widget.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    //todo l - to avoid this error. After initState, then direct async await.  In order to call API --> Provider / Bloc --> setState()
    //The following assertion was thrown building Builder:
    // _BaseScreenState.initState() returned a Future.

    //todo option 1 - use a outside asyncMethod func or
    // asyncMethod();

    //todo Option 2 Future.microtask like below: a future containing the result of calling async
    Future.microtask(() async {
      final productProviders = Provider.of<ProductProvider>(context, listen: false);
      await productProviders.fetchProducts(); //fetch first from background call thread

      User? user = auth.currentUser;
      final cartProviders = Provider.of<CartProvider>(context, listen: false);
      if(user!=null) {
        await cartProviders.fetchCart(); //todo l - fetch the carts for logged in users
      } else {
        cartProviders.clearCarts(); //todo l - remove the previous carts for logged in users
      }

      setState(() { //to UI thread by navigation them
         // Update your UI with the desired changes.
         _isLoading =false;
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NavBottomBarScreen()));
       });
    });
  }

  Future<void> asyncMethod() async{
    final productProviders = Provider.of<ProductProvider>(context, listen: false);
    await productProviders.fetchProducts(); //fetch first from background call thread
    setState(() { //to UI thread by navigation them
      // Update your UI with the desired changes.
      _isLoading =false;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NavBottomBarScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingFullscreenWidget(
      isLoading: _isLoading,
      child: Container(),
    );
  }
}
