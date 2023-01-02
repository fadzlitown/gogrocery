import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../consts/constants.dart';
import '../../services/Utils.dart';
import '../../widgets/auth_button_widget.dart';
import '../../widgets/back_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {

  const ForgetPasswordScreen({Key? key}) : super(key: key);
  static const routeName = "/ForgetPasswordScreen";


  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
  }

  void _submitForget() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      print('Valid Form');
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
                  'Forget Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: util.getMediaSize.height * 0.05),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          onEditingComplete: () {
                            _submitForget();
                          },
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
                        AuthButtonWidget('Reset Now', (){
                          _submitForget();
                        }, Colors.grey.withOpacity(0.5)),
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );  }
}