import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/widgets/on_sale_widget.dart';

import '../services/Utils.dart';
import '../widgets/back_widget.dart';

class OnSaleScreen extends StatelessWidget {
  const OnSaleScreen({Key? key}) : super(key: key);
  static const routeName = "/OnSaleScreen";

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);
    bool _isListEmpty = true;

    return Scaffold(
        appBar: AppBar(
            leading: const BackWidget(),
            title: Text('On Sale',
                style: TextStyle(
                    color: !util.isDarkTheme ? Colors.black87 : Colors.white)),
            backgroundColor:
                util.isDarkTheme ? Theme.of(context).cardColor : Colors.white),
        body: _isListEmpty
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Image.asset('assets/images/box.png',
                        height: util.getMediaSize.height * 0.20),
                    Text(
                      'No product on sale yet!',
                      style: TextStyle(
                      color: util.color,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                    )
                  ]),
                ),
              )
            : GridView.count(
                ///todo If this widget handling single list, then remove physics & shrinkWrap
                crossAxisCount: 2,
                padding: const EdgeInsets.all(5),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio:
                    util.getMediaSize.width / (util.getMediaSize.height * 0.45),
                //todo if any child having out bound pixel, hence, adjusting mediaSize & ratio are required!!
                children: List.generate(10, (index) {
                  return const OnSalesWidget();
                })));
  }
}
