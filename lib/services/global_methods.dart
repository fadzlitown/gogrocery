import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../consts/firebase_constants.dart';
import 'Utils.dart';

class GlobalMethods {
  static navigateTo({required BuildContext context, required String name}) {
    Navigator.pushNamed(context, name);
  }

  static String uuidGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  static Future<void> showOkCancelDialog(BuildContext context, String title, String subtitle, IconData iconData, {Function? positiveCallback, Function? negativeCallback}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
                children: [Icon(iconData), Text('  $title')]),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(onPressed: () {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                  positiveCallback!();
              }, child: const Text('OK'))
            ],
          );
        });
  }


   static Future<void> addProductIntoCart({required String productId, required int quantity, required BuildContext context}) async{
    final uid = auth.currentUser?.uid;
    final cartId = uuidGenerator();
    try{
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity
          }
        ])
      });
       Fluttertoast.showToast(msg: "Added in your cart");
    }catch(error){
      showOkCancelDialog(context, 'Error', error.toString(), Icons.error, positiveCallback: () {}, negativeCallback: () {});
    }
  }

}
