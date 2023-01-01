import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/widgets/back_widget.dart';

import '../../services/Utils.dart';
import '../../services/global_methods.dart';
import 'order_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routeName = "/OrdersScreen";


  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);

    return Scaffold(
        appBar: AppBar(
          leading: const BackWidget(),
            actions: [
              IconButton(
                  onPressed: () {
                    GlobalMethods.showOkCancelDialog(context, 'Empty Orders',
                        'Are you sure? ', IconlyLight.delete,
                        positiveCallback: () {}, negativeCallback: () {});
                  },
                  icon: Icon(IconlyBroken.delete, color: util.color))
            ],
            elevation: 5,
            backgroundColor:
                util.isDarkTheme ? Theme.of(context).cardColor : Colors.white,
            title: Text(
              'Your order(s)',
              style: TextStyle(
                  color: !util.isDarkTheme ? Colors.black87 : Colors.white),
            )),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return const OrderWidget();
          },
          itemCount: 10,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: util.color, thickness: 0.5);
          },
        ));
  }
}
