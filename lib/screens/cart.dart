import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/screens/cart/cart_widget.dart';
import 'package:go_grocery/screens/cart/empty_cart.dart';
import 'package:go_grocery/widgets/green_btn_widget.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../services/Utils.dart';
import '../services/global_methods.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);
    final cartProvider = Provider.of<CartProvider>(context); //registered provider model
    final cartItemsList = cartProvider.getCartItems.values.toList().reversed.toList();
    bool isEmpty = cartItemsList.isEmpty;

    return Scaffold(
        appBar: AppBar(
            actions: [
              Visibility(
                visible: !isEmpty,
                child: IconButton(
                    onPressed: () {
                      GlobalMethods.showOkCancelDialog(context, 'Empty Cart',
                          'Are you sure? ', IconlyLight.delete,
                          positiveCallback: () {
                            cartProvider.clearCarts();
                          }, negativeCallback: () {
                            if(Navigator.canPop(context)) Navigator.pop(context);
                          });
                    },
                    icon: Icon(IconlyBroken.delete, color: util.color)),
              )
            ],
            elevation: 5,
            backgroundColor:
                util.isDarkTheme ? Theme.of(context).cardColor : Colors.white,
            title: Text(
              'Cart (${cartItemsList.length})',
              style: TextStyle(
                  color: !util.isDarkTheme ? Colors.black87 : Colors.white),
            )),
        body: (isEmpty) ? EmptyScreen('Your cart is empty', 'assets/images/cart.png', true, 'Shop Now!') : Column(
          children: [
            _orderNowWidget(context),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: cartItemsList[index],
                    child: CartWidget(
                      quantity: cartItemsList[index].quantity, productId: cartItemsList[index].productId,
                    ),
                  );
                },
                itemCount: cartItemsList.length,
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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        //todo symmetric - horizontal padding between start & end / left & right
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GreenButtonWidget('Order Now', true, () {}),
            // Spacer(), todo l: remove this spacer then directly used --> MainAxisAlignment.spaceBetween
            Text('Total: \$0.522',
                style: TextStyle(
                    color: util.color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
          ],
        ));
  }
}
