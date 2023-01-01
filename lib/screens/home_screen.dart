import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/provider/dark_theme_provider.dart';
import 'package:go_grocery/screens/feed_screen.dart';
import 'package:go_grocery/screens/onsale_screen.dart';
import 'package:go_grocery/services/Utils.dart';
import 'package:provider/provider.dart';

import '../consts/constants.dart';
import '../services/global_methods.dart';
import '../widgets/feed_item_widget.dart';
import '../widgets/on_sale_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);

    return Consumer<DarkThemeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
            body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
                height: util.getMediaSize.height * 0.33,
                child: Swiper(
                  itemCount: Constants.landingImages.length,
                  itemBuilder: (context, index) {
                    return Image.asset(Constants.landingImages[index], fit: BoxFit.fill);
                  },
                  pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                          color: util.isDarkTheme ? Colors.white : Colors.black,
                          activeColor: Colors.red)),
                  // control: const SwiperControl(),
                )),
            const SizedBox(
              height: 6,
            ),
            TextButton(
                onPressed: () {
                  GlobalMethods.navigateTo(context: context, name: OnSaleScreen.routeName);
                },
                child: const Text(
                  'View All',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                  maxLines: 1,
                )),
            const SizedBox(
              height: 6,
            ),
            Row(
              //todo Row cannot wrap ListView due to same row axis with ListView - RenderBox was not laid out: RenderRepaintBoundary#ca7ea relayoutBoundary=up7 NEEDS-PAINT
              // todo HENCE, Flexible required here to wrap inside ListView
              children: [
                RotatedBox(   //todo RotatedBox --> to rotate any widget by angle!!
                  quarterTurns: 135,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      children: const [
                        Text(
                          'ON SALES ',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(IconlyLight.discount, color: Colors.red),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: util.getMediaSize.height * 0.25,
                    //must defined the sizedBox to wrap the listView
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        return const OnSalesWidget();
                      },
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //todo can use this for spacing or //Spacer() between the widgets
                children:  [
                  const Text('Our Product',
                      style: TextStyle(color: Colors.black, fontSize: 25)),
                  //Spacer(), or use the mainAxis spaceBetween
                  TextButton(onPressed: (){
                    GlobalMethods.navigateTo(context: context, name: FeedScreen.routeName);
                  }, child:
                  const Text('Browse all',
                      style: TextStyle(color: Colors.blue, fontSize: 18))),
                ],
              ),
            ),
            GridView.count(
              //todo If Children has a combination of list like this home screen
              ///todo w/out physics & shrinkWrap --> getting this error RenderBox was not laid out: RenderRepaintBoundary#a664d relayoutBoundary=up15 NEEDS-PAINT. Thus,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                padding: const EdgeInsets.all(5),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: util.getMediaSize.width / (util.getMediaSize.height*0.55),  //todo if any child having out bound pixel, hence, adjusting mediaSize & ratio are required!!
                children: List.generate(10, (index) {
                  return  FeedItemWidget(salePrice: 2, price: 5.00, textPrice: "1",isOnSale: true,);
                }))
          ]),
        ));
      },
    );
  }

//TODO or alternatively can used STATEFUL WIDGET using Provider.of<DarkThemeProvider>(context);
/*
*   final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Center(
          child: SwitchListTile(
        title: Text('Theme'),
        secondary: Icon(themeState.getDarkTheme
            ? Icons.dark_mode_outlined
            : Icons.light_mode_outlined),
        onChanged: (bool value) {
         setState(() {
            themeState.setDarkTheme = value;
         });
        },
        value: themeState.getDarkTheme,
      )),
    );
* */
}
