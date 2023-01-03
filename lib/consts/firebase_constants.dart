import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/global_methods.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

final User? user = auth.currentUser;

final uid = user?.uid;

bool isCurrentUserLogged(BuildContext context) {
  if (auth.currentUser == null) {
    GlobalMethods.showOkCancelDialog(
        context, 'Unknown User', 'Please login first', Icons.error,
        positiveCallback: () {
        if(Navigator.canPop(context)) Navigator.pop(context);
    }, negativeCallback: () {
        if(Navigator.canPop(context)) Navigator.pop(context);
    });
    return false;
  }
  return true;
}
