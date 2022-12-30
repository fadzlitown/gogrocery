import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_grocery/provider/dark_theme_provider.dart';
import 'package:go_grocery/services/Utils.dart';
import 'package:provider/provider.dart';

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
            body: SizedBox(
              height: util.getMediaSize.height * 0.33,
                child: Swiper(itemCount: _landingImage.length,
                  itemBuilder: (context,  index){
                  return Image.asset(_landingImage[index], fit:  BoxFit.fill);
                  },
                  pagination:  SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(color: util.isDarkTheme ? Colors.white : Colors.black, activeColor: Colors.red)
                  ),
                  // control: const SwiperControl(),
                )));
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
