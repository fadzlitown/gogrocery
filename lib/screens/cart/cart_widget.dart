import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/services/global_methods.dart';

import '../../services/Utils.dart';
import '../../widgets/quantity_increment_decrement.dart';
import '../feed/feed_detail_screen.dart';

class CartWidget extends StatefulWidget {
  int quantity = 1;

  CartWidget({required this.quantity});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final TextEditingController _quantityController =
      TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    _quantityController.text = '${widget.quantity}';
  }


  @override
  void dispose() {
    super.dispose();
    _quantityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);

    return GestureDetector(
      //a widget that detects gestures, eg. any taps / pressed / drag
      onTap: () {
        GlobalMethods.navigateTo(context: context, name: FeedDetailScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.98),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(10),
              // color: Colors.red, todo --> we cannot set for both color inside Container & BoxDecoration! Will caused error while rendering
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12)),
              child: FancyShimmerImage(
                  imageUrl: 'https://via.placeholder.com/80x80',
                  height: util.getMediaSize.width * 0.20,
                  width: util.getMediaSize.width * 0.20,
                  boxFit: BoxFit.fill),
            ),
            Column(
              children: [
                Text('Title',
                    style: TextStyle(
                        color: util.color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: util.getMediaSize.width * 0.45,
                  child: Row(
                    children: [
                      QuantityIncrementDecrement(
                          util: util,
                          icon: CupertinoIcons.minus,
                          color: Colors.red,
                          func: () {
                            if(_quantityController.text=='1'){
                              return;
                            } else {
                              setState(() {
                                _quantityController.text=(int.parse(_quantityController.text)-1).toString();
                              });
                            }

                          }),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 7,right: 7),
                          child: TextField(
                              textAlign: TextAlign.center,
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                              ],
                              onChanged: (val){
                                setState(() {
                                  if(val.isEmpty) _quantityController.text='1';
                                  else {
                                    return;
                                  }
                                });
                              },
                              decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide()))),
                        ),
                      ),
                      QuantityIncrementDecrement(
                          util: util,
                          icon: CupertinoIcons.plus,
                          color: Colors.green,
                          func: () {
                            if(_quantityController.text=='1'){
                              setState(() {
                                _quantityController.text=(int.parse(_quantityController.text)+1).toString();
                              });
                              return;
                            } else {
                              setState(() {
                                _quantityController.text=(int.parse(_quantityController.text)+1).toString();
                              });
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: [
                  InkWell(onTap: (){
                  }, child: const Icon(CupertinoIcons.cart_badge_minus, color: Colors.red, size: 20,),),
                  const SizedBox(height: 7), //add some margin
                  Icon(IconlyLight.heart, color: util.color),
                  Text('\$0.50', style: TextStyle(color: util.color ),)
                ],)),
            const SizedBox(width: 8)
          ],
        ),
      ),
    );
  }
}
