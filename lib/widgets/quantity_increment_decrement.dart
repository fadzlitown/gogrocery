import 'package:flutter/material.dart';

import '../services/Utils.dart';

class QuantityIncrementDecrement extends StatelessWidget {
  final Utils util;
  final IconData icon;
  final Color color;
  final Function func;

   const QuantityIncrementDecrement({required this.util,
  required  this.icon,
  required  this.color,
  required  this.func});


  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: util.getMediaSize.width * 0.08,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            func(); // will trigger this func
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(icon, color: Colors.white, size: 20,)),
        ),
      ),
    );
  }
}
