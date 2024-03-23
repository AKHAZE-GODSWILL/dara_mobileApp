import 'dart:async';
import 'package:dara_app/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dara_app/widget/custom_circle.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:dara_app/screens/authentication/personal_info.dart';
import 'package:dara_app/screens/authentication/resetPassword.dart';

class ForgotPassword extends StatefulWidget {
  String? email;
  ForgotPassword({required this.email});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final pinController = TextEditingController();
  bool temporarilyShowCharacter = false;
  bool isMaxPin = false;
  int pinLength = 4;
  Timer? _timer;
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
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Text("")),
        centerTitle: false,
        titleSpacing: 0,
        title: Transform(
          transform: Matrix4.translationValues(-55, 0, 0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black12)),
                    child: Container(
                        child: Transform.scale(
                            scale: 0.5,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 30,
                              ),
                            )))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // Spacer(),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          // padding: EdgeInsets.zero,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Code Verification",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10),
                    child: Text(
                      "A 4-digit code has been sent to ${widget.email}. Please enter the code that was sent to you.",
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
                    : SizedBox()),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                /////////////////// Push to the next page after user has selected a tier

                if (isMaxPin) {
                  ///// Navigation.push to the OTP screen

                  circularCustom(context);
                  verifyServiceProvider(
                          otp: pinController.text.trim(),
                          phoneNumber: widget.email)
                      .then((value) {
                    Navigator.pop(context);
                    if (value["status"] == true) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResetPassword(email:  widget.email.toString())));
                    } else if (value["status"] == "Network Error") {
                      mywidgets.displayToast(
                          msg:
                              "Network Error. Check your Network Connection and try again");
                    } else {
                      mywidgets.displayToast(msg: value["message"]);
                    }
                  });
                }

                //will save this parameter to state management later
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 50,
                decoration: BoxDecoration(
                    color: (!isMaxPin)
                        ? Color(0XFFF3F4F6)
                        : constants.appMainColor,
                    borderRadius: BorderRadius.circular(200)),
                child: Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        color: (!isMaxPin) ? Color(0XFF6B7280) : Colors.white,
                        fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            (_start == 0)
                ? Center(
                    child: InkWell(
                      onTap: () {
                        resendEmail(email: widget.email).then((value) {
                          if (value["status"] == true) {
                            setState(() {
                              _start = 100;
                              startTimer();
                            });
                          } else if (value == "Network Error") {
                            mywidgets.displayToast(
                                msg:
                                    "Network Error. Check your Network Connection and try again");
                          } else {
                            mywidgets.displayToast(msg: value["message"]);
                          }

                          // setState(() {
                          //   isLoading = false;
                          // });
                        });
                      },
                      child: Container(
                          width: 100,
                          child: Center(
                            child: Text(
                              'Resend Code',
                              style: TextStyle(color: constants.appMainColor),
                            ),
                          )),
                    ),
                  )
                : SizedBox(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Need help? ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                        text: 'Reach out to our support team',
                        style: TextStyle(
                          color: constants.appMainColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle the tap gesture for 'World!'

                          Future<void> _launchUrl() async {
                  final Uri _url =
                      Uri.parse('https://wa.me/message/MX5JENZMK2BBI1');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                }

                _launchUrl();
                          }),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  void clearPinOneByOne() {
    if (pinController.text.isNotEmpty) {
      setState(() {
        pinController.text =
            pinController.text.substring(0, pinController.text.length - 1);
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
