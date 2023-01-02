import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/model/products_model.dart';
import 'package:go_grocery/services/Utils.dart';
import 'package:go_grocery/widgets/price_widget.dart';
import 'package:provider/provider.dart';

class FeedItemWidget extends StatefulWidget {

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  final TextEditingController _kgProductItemController =
      TextEditingController(text: "1");

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getMediaSize;
    final color = Utils(context).color;
    final product = Provider.of<ProductModel>(context); //registered provider model

    return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                FancyShimmerImage(
                    imageUrl: product.imageUrl,
                    height: size.width * 0.20,
                    width: size.width * 0.20,
                    boxFit: BoxFit.fill),
                Flexible(   // TODO l --> NAME COULD BE LENGTHY, so to avoid UI OVERFLOWED USE --> FLEXIBLE - ROW - EXPANDED
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(product.title,
                            style: TextStyle(
                                color: color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Icon(IconlyLight.heart, color: color)
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceWidget(salePrice: product.salePrice, price: product.price, textPrice: '1', isOnSale:  product.isOnSale),
                    Spacer(),
                    Flexible(
                      child: TextFormField(
                          maxLines: 1,
                          key: const ValueKey('10'),
                          keyboardType: TextInputType.number,
                          enabled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                          ],
                          //todo used regex
                          onChanged: (val) {
                            if(val.isEmpty) { //todo stg wrong here for validation
                              val='1';
                            }
                            print(val+" "+_kgProductItemController.text);
                          },
                          onSaved: (value) {},
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          cursorColor: Colors.green,
                          controller: _kgProductItemController),
                    ),
                    Text(
                      product.isPiece ? 'piece' : 'kg ',
                      style: TextStyle(color: color, fontSize: 15),
                    ),
                  ],
                ),

                ///todo - other option to placed editable kg widget here
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //   Spacer(flex: 3),
                //   Flexible(
                //     child: TextFormField(
                //         maxLines: 1,
                //         key: const ValueKey('10'),
                //         keyboardType: TextInputType.number,
                //         enabled: true,
                //         inputFormatters: [
                //           FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                //         ],
                //         //todo used regex
                //         onChanged: (val) {
                //           if(val.isEmpty) { //todo stg wrong here for validation
                //             val='1';
                //           }
                //           print(val+" "+_kgProductItemController.text);
                //         },
                //         onSaved: (value) {},
                //         decoration: const InputDecoration(
                //           focusedBorder: UnderlineInputBorder(
                //             borderSide: BorderSide(),
                //           ),
                //         ),
                //         textAlign: TextAlign.center,
                //         cursorColor: Colors.green,
                //         controller: _kgProductItemController),
                //   ),
                //   Text(
                //     'Kg ', textAlign: TextAlign.end,
                //     style: TextStyle(color: color, fontSize: 18),
                //   ),
                //   ],),

                TextButton(onPressed: () {}, child: Text('Add to cart'))
              ],
            ),
          ),
        ));
  }
}
