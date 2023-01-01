import 'package:flutter/material.dart';

import '../services/Utils.dart';

class AuthButtonWidget extends StatelessWidget {

  final String name;
  final Color color;
  Function function;

  AuthButtonWidget(this.name, this.function, this.color);

  @override
  Widget build(BuildContext context) {
    final util = Utils(context);

    return Material(
        color: color,
        borderRadius: BorderRadius.zero,
        child: SizedBox(
          width: double.infinity,
          child: InkWell(
            onTap: () {
              function();
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ));
  }
}
