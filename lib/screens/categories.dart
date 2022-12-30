import 'package:flutter/material.dart';

import '../services/Utils.dart';

class CategoriesScreen extends StatelessWidget {

  List<Map<String, dynamic>> catList = [
    {
      'imagePath': 'assets/images/cat/fruits.png',
      'catText':'Fruits',
      'color': const Color(0xff53B175)
    },
    {
      'imagePath': 'assets/images/cat/veg.png',
      'catText':'Vegetables',
      'color': const Color(0xffF8A44C)
    },
    {
      'imagePath': 'assets/images/cat/Spinach.png',
      'catText':'Herbs',
      'color': const Color(0xffF7A593)
    },
    {
      'imagePath': 'assets/images/cat/nuts.png',
      'catText':'Nuts',
      'color': const Color(0xffD3B0E0)
    },
    {
      'imagePath': 'assets/images/cat/spices.png',
      'catText':'Spices',
      'color': const Color(0xffFDE598)
    },
    {
      'imagePath': 'assets/images/cat/grains.png',
      'catText':'Grains',
      'color': const Color(0xffB7DFF5)
    },

  ];

  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GridView.count(
        padding: const EdgeInsets.only(top: 20),
        crossAxisCount: 2,
        //Creates a scrollable, 2D array of widgets with a fixed number of tiles in the cross axis
        childAspectRatio: 240 / 250,
        crossAxisSpacing: 10, //Vertical spacing, left-right antara item
        mainAxisSpacing: 10,  //Horizontal spacing, top-bottom antara item
        children: List.generate(catList.length, (index) { // total list length & cur index while looping
          return InkWell( //Like a Material Card Android
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: (catList[index]['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 2, color: (catList[index]['color'] as Color).withOpacity(0.7))
                ),
                child: Column(
                  children: [
                    Container(
                        height: _screenWidth * 0.3,
                        width: _screenWidth * 0.3,
                        decoration:  BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(catList[index]['imagePath']),
                                fit: BoxFit.fill))),
                    Text(catList[index]['catText'], style: TextStyle(color: catList[index]['color'], fontSize: 20))
                  ],
          ),
              ),
              onTap: (){
                    print('Cat pressed');
              });
        }),
      ),
    );
  }
}
