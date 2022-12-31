import 'package:flutter/material.dart';

class GlobalMethods {
  static navigateTo({required BuildContext context, required String name}){
    Navigator.pushNamed(context, name);
  }
}