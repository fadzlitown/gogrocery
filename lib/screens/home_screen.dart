import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:go_grocery/provider/dark_theme_provider.dart';
import 'package:go_grocery/services/Utils.dart';
import 'package:provider/provider.dart';

import '../widgets/on_sale_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<String> _landingImage = [
    "assets/images/landing/buy-on-laptop.jpg",
    "assets/images/landing/grocery-cart.jpg",
    "assets/images/landing/store.jpg",
    "assets/images/landing/buyfood.jpg",
    "assets/images/landing/buy-through.png",
    "assets/images/landing/vergtablebg.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);

    return Consumer<DarkThemeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
            body: Column(children: [
          SizedBox(
              height: util.getMediaSize.height * 0.33,
              child: Swiper(
                itemCount: _landingImage.length,
                itemBuilder: (context, index) {
                  return Image.asset(_landingImage[index], fit: BoxFit.fill);
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
              onPressed: () {},
              child: const Text(
                'View All',
                style: TextStyle(color: Colors.blue, fontSize: 20),
                maxLines: 1,
              )),
          const SizedBox(
            height: 6,
          ),
          Row(    //todo Row cannot wrap ListView due to same row axis with ListView - RenderBox was not laid out: RenderRepaintBoundary#ca7ea relayoutBoundary=up7 NEEDS-PAINT
              // todo HENCE, Flexible required here to wrap inside ListView
            children: [
              RotatedBox(
                quarterTurns: 135,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: const [
                    Text('ON SALES ', style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),),
                    Icon(IconlyLight.discount, color: Colors.red),
                  ],),
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
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //todo can use this for spacing or //Spacer() between the widgets
                  children: const [
                  Text('Our Product', style: TextStyle(color: Colors.black, fontSize: 25)),
                  //Spacer(), or use the mainAxis spaceBetween
                  Text('Browse all', style: TextStyle(color: Colors.blue, fontSize: 18)),
                ],),
              )
        ]));
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
