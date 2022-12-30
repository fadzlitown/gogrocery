import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ListTileWidget extends StatelessWidget {
  Icon icon;
  String title;
  String subtitle;
  VoidCallback callback;


  ListTileWidget(this.icon, this.title, this.subtitle, this.callback);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: icon,
        trailing: const Icon(IconlyBold.arrowRightCircle),
        title: Text(title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: callback);
  }
}
