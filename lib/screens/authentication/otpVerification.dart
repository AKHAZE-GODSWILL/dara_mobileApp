import 'dart:async';

import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/main.dart';
import 'package:dara_app/screens/authentication/personal_info.dart';
import 'package:dara_app/utils/apiRequest.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

class OtpVerification extends StatefulWidget {
  OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {

 final pinController = TextEditingController();
 bool temporarilyShowCharacter = false;
 bool isMaxPin = false;
 bool isLoading = false;
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
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
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
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10),
                      child: (provider.userType == "serviceProvider")?Text("A 4-digit code has been sent to ${provider.sp_countryCallCode} ${provider.serviceProviderPhone} by SMS. Please enter the code that was sent to you.",
                      style: GoogleFonts.inter(fontSize: 12),
                      textAlign: TextAlign.center,
                      )
                      :Text("A 4-digit code has been sent to your Email. Please enter the code that was sent to you.",
                      style: GoogleFonts.inter(fontSize: 12),
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
                  hideCharacter: false,
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
                  pinTextStyle: GoogleFonts.inter(fontSize: 22.0),
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
                  ? Text("Code expires in ${_start} sec", 
                      style: GoogleFonts.inter(fontSize: 12, color: Color(0XFF6B7280)),)
                  : SizedBox()
            ),

            SizedBox(height: 50,),

             InkWell(
                onTap: (){
                  /////////////////// Push to the next page after user has selected a tier
                  
                  if(isMaxPin){
                    setState(() {
                      isLoading = true;
                    });

                    // mywidgets.displayToast(msg: "${provider.sp_countryCallCode}${provider.serviceProviderPhone}");
                    print("The Pin controller text is ${provider.sp_countryCallCode}${provider.serviceProviderPhone}");
                    
                    // makes the request here
                         (provider.userType == "serviceProvider")? verifyServiceProvider(otp: pinController.text.trim(), phoneNumber: "${provider.sp_countryCallCode}${provider.serviceProviderPhone}").then((value) {

                            print("The final Value of what was resulted from the request was :$value");

                            if(value["status"]== true){
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Personal_Info())
                              );

                            }
                            else if(value["status"] == "Network Error"){
                              mywidgets.displayToast(msg: "Network Error. Check your Network Connection and try again");
                            }
                            else{
                              mywidgets.displayToast(msg: value["message"]);
                            }

                            setState(() {
                              isLoading = false;
                            });
                          })
                          :verifyClient(otp: pinController.text.trim(), email: provider.client_email).then((value) {

                            print("The final Value of what was resulted from the request was :$value");

                            if(value["status"]== true && value['message'] == "Your email address has been verified."){
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Personal_Info())
                              );

                            }
                            else if(value["status"] == "Network Error"){
                              mywidgets.displayToast(msg: "Network Error. Check your Network Connection and try again");
                            }
                            else{
                              mywidgets.displayToast(msg: value["message"]);
                            }

                            setState(() {
                              isLoading = false;
                            });
                          });
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
                    child: (isLoading)? CircularProgressIndicator(color: Colors.white,) 
                    :Text(
                      "Continue",
                      style: GoogleFonts.inter(
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

                          // makes the request here
                          registerServiceProvider(countryCallCode: provider.sp_countryCallCode,phoneNumber: provider.serviceProviderPhone).then((value) {

                            print("The final Value of what was resulted from the request was :$value");

                            if(value["status"]== true){

                              setState(() {
                                _start = 100;
                              startTimer();

                              });
                            }
                            else if(value == "Network Error"){
                              mywidgets.displayToast(msg: "Network Error. Check your Network Connection and try again");
                            }
                            else{
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
                            child: Text('Resend Code',
                            style: GoogleFonts.inter(color: constants.appMainColor),),
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
