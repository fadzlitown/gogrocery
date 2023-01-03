import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_grocery/screens/auth/forget_password.dart';
import 'package:go_grocery/screens/auth/register.dart';
import 'package:go_grocery/services/global_methods.dart';
import 'package:go_grocery/widgets/loading_fullscreen_widget.dart';

import '../../consts/constants.dart';
import '../../consts/firebase_constants.dart';
import '../../services/Utils.dart';
import '../../widgets/auth_button_widget.dart';
import '../../widgets/google_signin_button.dart';
import '../nav_btm_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = "/LoginScreen";


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
  }

  // void _submitOnLogin() {
  //   final isValid = _formKey.currentState!.validate();
  //   FocusScope.of(context).unfocus();
  //   if (isValid) {
  //     print('Valid Form');
  //     Navigator.pushReplacementNamed(context, NavBottomBarScreen.routeName);
  //     //todo - if success, replace the login with HOME Screen so that user can't go back to login state again
  //   }
  // }

  bool _isLoading = false;

  void _submitOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      //if form is valid then only save it
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {
        await auth.signInWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());
        print('Success register!');

        Navigator.pushReplacementNamed(context, NavBottomBarScreen.routeName);
        //todo - if success, replace the login with HOME Screen so that user can't go back to login state again

      } on FirebaseAuthException catch (error) {
        GlobalMethods.showOkCancelDialog(
            context, 'Error Occurred', '${error.message}', Icons.error,
            positiveCallback: () {
            }, negativeCallback: () {
        });
        setState(() {
          _isLoading = false;
        });
      }
      catch (error) {
        GlobalMethods.showOkCancelDialog(
            context, 'Error Occurred', '$error', Icons.error,
            positiveCallback: () {
            }, negativeCallback: () {
        });
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final util = Utils(context);
    return LoadingFullscreenWidget(
      isLoading: _isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,  //TODO L - to avoid ERROR Bottom overloaded by 213 pixels , then used this on Scaffold
        body: Stack(
          //todo -> y using Stack? bcs login screen has overlapping widgets over background
          children: [
            Swiper(
              // pagination: todo l - remove these, no dotted slider needed in login
              autoplay: true,
              duration: 800,
              //todo l - animation duration
              autoplayDelay: 6000,
              //todo l - duration for the next image
              itemCount: Constants.loginBackgroundImages.length,
              itemBuilder: (context, index) {
                return Image.asset(Constants.loginBackgroundImages[index],
                    fit: BoxFit.fitHeight);
              },
              // control: const SwiperControl(),
            ),
            Container(color: Colors.black.withOpacity(0.5)),
            //todo if using STACK, any widget overlapping at the end will be shown first,
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: util.getMediaSize.height * 0.15),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Sign in to continue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: util.getMediaSize.height * 0.05),
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(_passFocusNode);
                            },
                            controller: _emailTextController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val!.isEmpty ||
                                  !val.contains('@') ||
                                  val.length < 7) {
                                return 'Please enter a valid email address';
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white),
                                errorBorder: UnderlineInputBorder(  // when validating failed
                                    borderSide: BorderSide(color: Colors.red)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(  //when user focus on this field
                                    borderSide: BorderSide(color: Colors.blue))),
                          ), //todo focus will be moving to the next field
                          const SizedBox(height: 10),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {
                              _submitOnLogin();
                            },
                            controller: _passTextController,
                            focusNode: _passFocusNode,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscureText,
                            validator: (val) {
                              if (val!.isEmpty || val.length < 7) {
                                return 'Please enter a valid password format';
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  child: (_obscureText)
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue))),
                          ), //todo focus will be moving to the next field
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, ForgetPasswordScreen.routeName);
                            },
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.lightBlue,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          SizedBox(height: util.getMediaSize.height * 0.04),
                          AuthButtonWidget('Sign In', (){
                            _submitOnLogin();
                          }, Colors.grey.withOpacity(0.5)),
                          SizedBox(height: util.getMediaSize.height * 0.02),
                          GoogleSignInButton(),
                          SizedBox(height: util.getMediaSize.height * 0.02),
                          Row(children: const [
                            Expanded(child: Divider(color: Colors.white, thickness: 1,)),
                            SizedBox(width: 5),
                            Text('OR', style: TextStyle(color: Colors.white),),
                            SizedBox(width: 5),
                            Expanded(child: Divider(color: Colors.white, thickness: 1,)),
                          ],),
                          SizedBox(height: util.getMediaSize.height * 0.02),
                          AuthButtonWidget('Continue as a Guest', (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NavBottomBarScreen()));
                          }, Colors.black),
                          Row(
                            children: [
                              const Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16,
                                    color: Colors.white,
                                    decoration: TextDecoration.none),
                              ),
                              TextButton(
                                onPressed: () {
                                  GlobalMethods.navigateTo(context: context, name: RegisterScreen.routeName);
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16,
                                      color: Colors.lightBlue,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
