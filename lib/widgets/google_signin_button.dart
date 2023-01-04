import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../consts/firebase_constants.dart';
import '../screens/base_screen.dart';
import '../screens/nav_btm_bar.dart';
import '../services/global_methods.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  Future<void> googleSignIn(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount =
        await googleSignIn.signIn(); //signIn return future then used await

    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
        if(googleAuth.accessToken!=null && googleAuth.idToken!=null){
          try {
            await auth.signInWithCredential(GoogleAuthProvider.credential(
                    idToken: googleAuth.idToken,
                    accessToken: googleAuth.accessToken));

            //todo l - A widget is mounted if it has state. If the widget is no longer mounted,
            // todo i.e it has been closed or disposed, its state can no longer be updated. Therefore, we check if a widget is mounted to determine its state can still be updated.
            if (!mounted) return;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BaseScreen()));
            //todo - if success, replace the login with HOME Screen so that user can't go back to login state again
          } on FirebaseAuthException catch (error) {
            if (!mounted) return;
            GlobalMethods.showOkCancelDialog(
                context, 'Error Occurred', '${error.message}', Icons.error,
                positiveCallback: () {
                }, negativeCallback: () {
            });
          } catch (error) {
            if (!mounted) return;
            GlobalMethods.showOkCancelDialog(
                context, 'Error Occurred', '$error', Icons.error,
                positiveCallback: () {
                }, negativeCallback: () {
            });
          }
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                // TODO: Add method call to the Google Sign-In authentication
                googleSignIn(context);

                setState(() {
                  _isSigningIn = false;
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Image(
                      image: AssetImage("assets/images/google.png"),
                      height: 35.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
