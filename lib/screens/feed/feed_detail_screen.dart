import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../services/Utils.dart';
import '../../widgets/back_widget.dart';
import '../../widgets/green_btn_widget.dart';
import '../../widgets/price_widget.dart';
import '../../widgets/quantity_increment_decrement.dart';

class FeedDetailScreen extends StatefulWidget {
  static const routeName = "/FeedDetailScreen";

  int quantity = 1;

  FeedDetailScreen({super.key, required this.quantity});


  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {

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

    return  Scaffold(appBar: AppBar(
        elevation: 5,
        backgroundColor:
        util.isDarkTheme ? Theme.of(context).cardColor : Colors.white,
        leading: const BackWidget(),
        title: Text(
          'Detail',
          style: TextStyle(
              color: !util.isDarkTheme ? Colors.black87 : Colors.white),
        )),
      body: Column(
        children: [
        FancyShimmerImage(
            imageUrl: 'https://via.placeholder.com/120x120',
            height: util.getMediaSize.width * 0.5,
            width: double.infinity,
            boxFit: BoxFit.fill),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Product Name', style: TextStyle(color: util.color, fontSize: 20, fontWeight: FontWeight.bold)),
              GestureDetector(
                child: Icon(IconlyLight.heart, size: 22, color: util.color),
                onTap: (){
                  print('Heart pressed');
                },
              )            ],
          ),
        ),
          Padding(
            padding:  const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    PriceWidget(price: 3.00,salePrice: 2.00,textPrice: '1', isOnSale: false,),
                    Text('/kg', style: TextStyle(color: util.color, fontSize: 20, fontWeight: FontWeight.normal)),
                  ],
                ),
                GreenButtonWidget('Free Delivery', true, (){}),
              ],
            ),
          ),
          Padding(
            padding:  const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: util.getMediaSize.width * 0.2,),
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
                SizedBox(width: util.getMediaSize.width * 0.2,),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding:  const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.normal)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PriceWidget(price: 3.00,salePrice: 2.00,textPrice: _quantityController.text, isOnSale: false,),
                        Text('/kg', style: TextStyle(color: util.color, fontSize: 20, fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ],
                ),
                GreenButtonWidget('Add to cart', true, (){
                }),
              ],
            ),
          ),
        ],),
    );
  }
}
