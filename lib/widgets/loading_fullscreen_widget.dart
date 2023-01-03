import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingFullscreenWidget extends StatelessWidget {

  final bool isLoading;
  final Widget child;

  LoadingFullscreenWidget({required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      isLoading ? Container(color: Colors.black.withOpacity(0.7),) : Container(),
      // isLoading ? Center(child:  CircularProgressIndicator( color: Colors.white,)) : Container()
      isLoading ? const Center(child:  SpinKitFadingFour( color: Colors.white,)) : Container()
    ],);
  }
}
