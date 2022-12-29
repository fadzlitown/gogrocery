import 'package:flutter/material.dart';
import 'package:go_grocery/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
            body: Center(
                child: SwitchListTile(
                  title: const Text('Theme '),
                  secondary: Icon(provider.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                  value: provider.getDarkTheme,
                  onChanged: (bool value) {
                    provider.setDarkTheme = value;
                  },
                )));
      },
    );
  }


  //TODO or alternatively can used STATEFUL WIDGET using Provider.of<DarkThemeProvider>(context);
/*
*   final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Center(
          child: SwitchListTile(
        title: Text('Theme'),
        secondary: Icon(themeState.getDarkTheme
            ? Icons.dark_mode_outlined
            : Icons.light_mode_outlined),
        onChanged: (bool value) {
         setState(() {
            themeState.setDarkTheme = value;
         });
        },
        value: themeState.getDarkTheme,
      )),
    );
* */
}
