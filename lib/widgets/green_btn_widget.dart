import 'package:flutter/material.dart';

class GreenButtonWidget extends StatelessWidget {
  final String name;
  final bool isBold;
  Function function;

  GreenButtonWidget(this.name, this.isBold, this.function);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            function();
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            ),
          ),
        ));
  }
}
