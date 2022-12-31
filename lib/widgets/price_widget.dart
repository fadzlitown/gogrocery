import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      //FittedBox the image is stretched to fill the entire [Container]
      child: Row(
        children:  const [
          Text(
            '1.50\$',
            style: TextStyle(color: Colors.green, fontSize: 22),
          ),
          SizedBox(width: 5),
          Text(
            '3.50\$',
            style: TextStyle(
                color: Colors.red,
                fontSize: 22,
                decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
}
