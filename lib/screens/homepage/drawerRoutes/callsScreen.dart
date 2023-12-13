

import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../main.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({Key? key}) : super(key: key);

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {

  int activeContainerIndex = 0;
  Timer? timer;

  bool enableSpeaker = false;
  bool openMicrophone = true;

  void startAnimation() {
    timer = Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
      // Change the active container and trigger the animation.
      setState(() {
        activeContainerIndex = (activeContainerIndex + 1) % 3;
      });
    });
  }

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

@override
void dispose() {
super.dispose();
timer!.cancel();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border:
                          Border.all(color: Colors.black12)),
                      child: Container(
                          child: Transform.scale(
                              scale: 0.5,
                              child: IconButton(
                
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              )))),
                ),
        // centerTitle: false,
        // titleSpacing: 0,
        title: Text(
          "Outgoing Call",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: constants.appMainColor,
        child: SingleChildScrollView(
          child: Column(
          children: [
            Container(
              height:MediaQuery.of(context).size.height*0.7,
              width:MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 234,
                      width: 168,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 1000),
                                opacity: activeContainerIndex == 2 ? 1.0 : 0.0,
                                child: DottedBorder(
                                  borderType: BorderType.Circle,
                                  color: Color(0XFF9CA3AF),
                                  radius: Radius.circular(8),
                                  dashPattern: [10,10],
                                  strokeWidth: 2,
                                  child: Container(
                                    width: 168,
                                    height: 168,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 1000),
                                opacity: activeContainerIndex == 1 ? 1.0 : 0.0,
                                child: DottedBorder(
                                  borderType: BorderType.Circle,
                                  color: Color(0XFFD1D5DB),
                                  radius: Radius.circular(8),
                                  dashPattern: [10,10],
                                  strokeWidth: 2,
                                  child: Container(
                                    width: 152,
                                    height: 152,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 1000),
                                opacity: activeContainerIndex == 0 ? 1.0 : 0.0,
                                child: DottedBorder(
                                  borderType: BorderType.Circle,
                                  radius: Radius.circular(8),
                                  color: Color(0XFFE5E7EB),
                                  dashPattern: [10,10],
                                  strokeWidth: 2,
                                  child: Container(
                                    width: 136,
                                    height: 136,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),

                              Container(
                                width: 120,
                                height: 120,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("assets/profile.png"),
                                  fit: BoxFit.cover)
                                  ,
                                ),
                              ),
                            ],
                          ),
                          

                        Text(
                              'Calling...',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0XFF374151)
                              ),
                        ),

                        Text(
                              'Daniel Smith',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0XFF121212)
                              ),
                        ),



                        ],
                      ),
                    ),
                  ),
                ],
              )
            ),
              
            SizedBox(height: 40,),

            Container(
              height: 48,
              width: 240,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.3)
                    ),
                    child: IconButton(
                            // handles the action performed anytime you press the send button
                            onPressed: () {
                              // sendPicture(context);
                              setState(() {
                                openMicrophone = !openMicrophone;
                              });
                            },
                        
                            icon: (openMicrophone)? Icon(
                              Icons.mic_none_outlined,
                              color: Colors.white,
                            ):Icon(
                              Icons.mic_off,
                              color: Colors.white,
                            ),
                          ),
                  ),

                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFFEF4444)
                    ),
                    child: IconButton(
                            // handles the action performed anytime you press the send button
                            onPressed: () {
                              Navigator.pop(context);
                            },
                        
                            icon: Icon(
                              PhosphorIcons.phone,
                              color: Colors.white,
                            ),
                          ),
                  ),

                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.3)
                    ),
                    child: IconButton(
                            // handles the action performed anytime you press the send button
                            onPressed: () {
                              // sendPicture(context);
                              setState(() {
                                enableSpeaker = !enableSpeaker;
                              });
                            },
                        
                            icon: (enableSpeaker)?Icon(
                              Icons.volume_up,
                              color: Colors.white,
                              size: 30,
                            ): Icon(
                              Icons.volume_down,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            )
            
          ],
            ),
        )
      )
    );
  }
  
  
}
