import 'package:flutter/material.dart';

import '../services/Utils.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    double _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        //Creates a scrollable, 2D array of widgets with a fixed number of tiles in the cross axis
        childAspectRatio: 240 / 250,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: List.generate(10, (index) {
          return InkWell( //Like a Material Card Android
              child: Column(
                children: [
                  Container(
                      height: _screenWidth * 0.3,
                      width: _screenWidth * 0.3,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/cat/fruits.png'),
                              fit: BoxFit.fill))),
                  Text('Fruits', style: TextStyle(color: color, fontSize: 20))
                ],
          ),
          onTap: (){
                print('Cat pressed');
          });
        }),
      ),
    );
  }
}
