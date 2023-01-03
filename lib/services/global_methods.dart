import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class GlobalMethods {
  static navigateTo({required BuildContext context, required String name}) {
    Navigator.pushNamed(context, name);
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
}
