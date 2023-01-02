import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_grocery/screens/auth/forget_password.dart';
import 'package:go_grocery/widgets/back_widget.dart';

import '../../consts/constants.dart';
import '../../services/Utils.dart';
import '../../services/global_methods.dart';
import '../../widgets/auth_button_widget.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget { //todo used Stateful coz need to keep all the field state!!
  const RegisterScreen({Key? key}) : super(key: key);

  static const routeName = "/RegisterScreen";


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _fullNameTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _fullNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    super.dispose();
     _emailTextController.dispose();
     _passTextController.dispose();
     _fullNameTextController.dispose();
     _addressTextController.dispose();
     _emailFocusNode.dispose();
    _fullNameFocusNode.dispose();
     _passFocusNode.dispose();
     _addressFocusNode.dispose();
  }

  void _submitFormOnRegister() async{
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){  //if form is valid then only save it
      _formKey.currentState!.save();
      GlobalMethods.navigateTo(context: context, name: LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final util = Utils(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        backgroundColor: Colors.white.withOpacity(0.3), //You can make this transparent
        elevation: 1.0, //No shadow
      ),
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
                          onEditingComplete: () { //lepas habis focus email field pulak _emailFocusNode
                            FocusScope.of(context).requestFocus(_emailFocusNode);
                          },
                          focusNode: _fullNameFocusNode,
                          controller: _fullNameTextController,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please enter a valid name';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintText: 'Fullname',
                              hintStyle: TextStyle(color: Colors.white),
                              errorBorder: UnderlineInputBorder(  // when validating failed
                                  borderSide: BorderSide(color: Colors.red)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(  //when user focus on this field
                                  borderSide: BorderSide(color: Colors.blue))),
                        ), //todo focus will be moving to the next field

                        SizedBox(height: util.getMediaSize.height * 0.01),

                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(_passFocusNode);
                          },
                          focusNode: _emailFocusNode,
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

                        SizedBox(height: util.getMediaSize.height * 0.01),

                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(_addressFocusNode);
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

                        SizedBox(height: util.getMediaSize.height * 0.01),

                        TextFormField(
                          maxLines: 3,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () { //lepas habis focus email field pulak _emailFocusNode
                            _submitFormOnRegister();
                          },
                          focusNode: _addressFocusNode,
                          controller: _addressTextController,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val!.isEmpty && val.length<10) {
                              return 'Please enter a valid address';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintText: 'Shipping Address',
                              hintStyle: TextStyle(color: Colors.white),
                              errorBorder: UnderlineInputBorder(  // when validating failed
                                  borderSide: BorderSide(color: Colors.red)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(  //when user focus on this field
                                  borderSide: BorderSide(color: Colors.blue))),
                        ),

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
                        AuthButtonWidget('Sign Up', (){
                          _submitFormOnRegister();
                        }, Colors.grey.withOpacity(0.5)),
                        Row(
                          children: [
                            const Text(
                              'Already a user?',
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  color: Colors.white,
                                  decoration: TextDecoration.none),
                            ),
                            TextButton(
                              onPressed: () {
                                //todo l - if there's an existing screen on backstack? then uses POP or PUSH REPLACEMENT
                                Navigator.pushReplacementNamed(context, LoginScreen.routeName);

                                //OR
                                // if(Navigator.canPop(context)){
                                //   Navigator.pop(context);
                                // } else {
                                //   null;
                                // }

                              },
                              child: const Text(
                                'Sign In',
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
    );
  }
}
