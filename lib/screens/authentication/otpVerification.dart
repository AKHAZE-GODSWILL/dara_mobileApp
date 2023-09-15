import 'dart:async';

import 'package:dara_app/main.dart';
import 'package:dara_app/screens/authentication/addFingerPrint.dart';
import 'package:dara_app/screens/authentication/personal_info.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class OtpVerification extends StatefulWidget {
  OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {

 final pinController = TextEditingController();
 bool temporarilyShowCharacter = false;
 bool isMaxPin = false;
 int pinLength = 4;
 Timer ?_timer;
  int _start = 100;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Column(
          // padding: EdgeInsets.zero,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                    SizedBox(height: MediaQuery.of(context).size.width*0.15,),
      
                    Container(
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width*0.3,
                      height: MediaQuery.of(context).size.width*0.1,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/daraLogo.png"),
                        fit: BoxFit.cover)
                        ,
                      ),
                    ),

                    SizedBox(height: 20,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10),
                      child: Text("Number Verification",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: Text("A 4-digit code has been sent to +234 800000000 by SMS. Please enter the code that was sent to you.",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                      ),
                    )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: PinCodeTextField(
                  autofocus: true,
                  hideCharacter: !temporarilyShowCharacter,
                  // highlight: true,

                  highlightColor: constants.appMainColor,
                  pinBoxColor: Color(0xFFEEEEEE),
                  defaultBorderColor: Color(0xFFEEEEEE),
                  hasTextBorderColor: constants.appMainColor,
                  // highlightPinBoxColor: Colors.orange,
                  maxLength: pinLength,
                  // hasError: hasError,
                  // maskCharacter: "😎",
                  onTextChanged: (text) {
                    if (text.isEmpty) {
                      // The clear button was pressed
                      clearPinOneByOne();
                    } else {
                      // Handle PIN input changes
                      // handlePinInput();
                    }
                    // provider.setOTP(text);
                    // // setState(() {
                    // // hasError = false;
                    // // });
                  },
                  onDone: (text) {

                    setState(() {
                      isMaxPin = true;
                    });
                    // print("DONE $text");
                    // print("DONE CONTROLLER ${controller.text}");
                  },
                  controller: pinController,
                  pinBoxWidth: 50,
                  pinBoxHeight: 50,
                  hasUnderline: false,
                  wrapAlignment: WrapAlignment.spaceAround,
                  pinBoxDecoration:
                      ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                  pinTextStyle: TextStyle(fontSize: 22.0),
                  pinTextAnimatedSwitcherTransition:
                      ProvidedPinBoxTextAnimation.scalingTransition,
                  pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                  highlight: true,
                  highlightAnimationBeginColor: Colors.black,
                  highlightAnimationEndColor: Colors.white12,
                  pinBoxBorderWidth: 0.5,
                  pinBoxRadius: 7,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),

             Container(
              width: 225,
              child: _start != 0
                  ? Text("Code expires in ${_start} sec")
                  : SizedBox()
            ),

            SizedBox(height: 50,),

             InkWell(
                onTap: (){
                  /////////////////// Push to the next page after user has selected a tier
                  
                  if(isMaxPin){
                    ///// Navigation.push to the OTP screen
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Personal_Info())
                    );
                  }

                  //will save this parameter to state management later
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: 50,
                  decoration: BoxDecoration(
                    color: (!isMaxPin)? Color(0XFFF3F4F6): constants.appMainColor,
                    borderRadius: BorderRadius.circular(200)
                  ),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        color: (!isMaxPin)? Color(0XFF6B7280):Colors.white,
                        fontSize: 14),),
                  ),
                ),
              ),

              SizedBox(height: 30,),

             (_start == 0)? Center(
                    child: InkWell(
                        onTap: () {

                          print("The Resend code button clicked");
                          // FirebaseAuth.instance
                          //     .verifyPhoneNumber(
                          //   phoneNumber: widget.number,
                          //   verificationCompleted: (credential) async {
                          //     await auth
                          //         .signInWithCredential(credential)
                          //         .then((value)async {
                              
                          //       print(">>>>>>>>>>>>>>>>> About to print the value");
                              
                          //       print(value);
                              
                          //       SharedPreferences prefs = await SharedPreferences.getInstance();
                          //       prefs.setString("token", "1");
                              
                          //       // make a request here. If you get the user data then you move to home page
                          //       // if not, you move to signup
                          //       // DatabaseReference newUserRef = FirebaseDatabase.instance.reference().child('users/${provider.userid}');
                              
                          //       widget.page == "signup"
                          //           ? Navigator.pushReplacement(
                          //               context,
                          //               PageRouteBuilder(
                          //                 pageBuilder: (context, animation,
                          //                     secondaryAnimation) {
                          //                   return Email();
                          //                 },
                          //                 transitionsBuilder: (context,
                          //                     animation,
                          //                     secondaryAnimation,
                          //                     child) {
                          //                   return FadeTransition(
                          //                     opacity: animation,
                          //                     child: child,
                          //                   );
                          //                 },
                          //               ),
                          //             )
                          //           : Navigator.pushReplacement(
                              
                          //         context,
                          //         PageRouteBuilder(
                          //           pageBuilder: (context, animation, secondaryAnimation) {
                          //             return MainPage();
                          //           },
                          //           transitionsBuilder:
                          //               (context, animation, secondaryAnimation, child) {
                          //             return FadeTransition(
                          //               opacity: animation,
                          //               child: child,
                          //             );
                          //           },
                          //         ),
                          //       );
                          //       // network.login(context: context, scaffoldKey: scaffoldKey);
                          //     });
                          //   },
                          //   verificationFailed:
                          //       (FirebaseAuthException e) async {
                          //     Navigator.pop(context);
                          //     await showTextToast(
                          //       text: e.toString(),
                          //       context: context,
                          //     );
                          //   },
                          //   timeout: Duration(seconds: 120),
                          //   codeSent: (String verificationId,
                          //       int ?resendToken) async {
                          //     Navigator.pop(context);
                          //     widget.verificationID = verificationId;
                          //     await showTextToast(
                          //       text: 'Code Sent',
                          //       context: context,
                          //     );
                          //   },
                          //   codeAutoRetrievalTimeout:
                          //       (String verificationId) {},
                          // )
                          //     .then((value) {
                          //   setState(() {
                          //     _start = 100;
                          //     startTimer();
                          //   });
                          // });
                        },
                        child: Container(
                          width: 100,
                          child: Center(
                            child: Text('Resend Code',
                            style: TextStyle(color: constants.appMainColor),),
                          )),
                      ),
                  ): SizedBox(),

           


          ],
        ),
      ),
    );
  }

  void clearPinOneByOne() {
    if (pinController.text.isNotEmpty) {
      setState(() {
        pinController.text = pinController.text.substring(0, pinController.text.length - 1);
      });
    }
  }

  void handlePinInput() {
    // Temporarily show the character for a short duration
    setState(() {
      temporarilyShowCharacter = true;
    });

    // After a brief delay, toggle back to hiding the character
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        temporarilyShowCharacter = false;
      });
    });
  }
}
