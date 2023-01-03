import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/provider/viewed_provider.dart';
import 'package:go_grocery/screens/cart/empty_cart.dart';
import 'package:go_grocery/screens/viewedRecently/viewed_recently_widget.dart';
import 'package:go_grocery/widgets/back_widget.dart';
import 'package:provider/provider.dart';

import '../../services/Utils.dart';
import '../../services/global_methods.dart';
import '../orders/order_widget.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  static const routeName = "/ViewedRecentlyScreen";

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);

    final provider = Provider.of<ViewedProvider>(context);
    final list = provider.getViewedList.values.toList().reversed.toList();
    bool isEmpty = list.isEmpty;

    return Scaffold(
        appBar: AppBar(
            leading: const BackWidget(),
            actions: [
              Visibility(
                visible: !isEmpty,
                child: IconButton(
                    onPressed: () {
                      GlobalMethods.showOkCancelDialog(
                          context,
                          'Empty Viewed Items',
                          'Are you sure? ',
                          IconlyLight.delete,
                          positiveCallback: () {
                            provider.clearViewedList();
                          },
                          negativeCallback: () {
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
              'Viewed item(s)',
              style: TextStyle(
                  color: !util.isDarkTheme ? Colors.black87 : Colors.white),
            )),
        body: isEmpty ? EmptyScreen('Your history is empty', 'assets/images/history.png', true, 'Browse Now!') : ListView.builder(
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
                value: list[index],
                child: const ViewedRecentlyWidget());
          },
          itemCount: list.length,
        ));
  }
}
