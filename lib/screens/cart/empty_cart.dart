import 'package:flutter/material.dart';

import '../../services/Utils.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils util = Utils(context);
    return Padding(
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
    );
  }
}
