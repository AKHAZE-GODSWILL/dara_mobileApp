import 'dart:async';
import '../../../../main.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class ReceivedCallsScreen extends StatefulWidget {
  const ReceivedCallsScreen(
      {Key? key,
      required this.call_token,
      required this.channel_name,
      required this.caller_img,
      required this.caller_name})
      : super(key: key);

  final call_token;
  final channel_name;
  final caller_img;
  final caller_name;
  @override
  State<ReceivedCallsScreen> createState() => _ReceivedCallsScreenState();
}

class _ReceivedCallsScreenState extends State<ReceivedCallsScreen> {
  late RtcEngine _engine;
  String appId = "d988f4a94f5a428284809ba1361df8ed";
  String device_token = "";
  String call_in_progress = "";
  String is_calling = "";
  bool callTimerInit = false;
  int? _remoteUid;
  bool _localUserJoined = false;

  // If call is accepted by the receiving end
  bool callAccepted = false;

  /// the remote user id.
  int? remoteUid;

  /// if microphone is opened.
  bool openMicrophone = true;

  /// if the speaker is enabled.
  bool enableSpeaker = false;

  /// Audio Player initializer

  // late AudioPlayer caller_player;

  int activeContainerIndex = 0;
  Timer? timer;

  void switchSpeakerPhone() {
    _engine?.setEnableSpeakerphone(!enableSpeaker).then((value) {
      setState(() {
        enableSpeaker = !enableSpeaker;
      });
    }).catchError((err) {});
  }

  void switchMicrophone() {
    _engine?.enableLocalAudio(!openMicrophone).then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    }).catchError((err) {});
  }

  String time = "Calling...";
  late Timer call_in_session_timer;

  String toMMSS(int minuteHand, int secondHand) {
    return "${minuteHand.toString().padLeft(2, '0')}:${secondHand.toString().padLeft(2, '0')}";
  }

  int minuteHand = 0;
  int secondHand = 0;

  late Timer before_call_is_accepted_timer;

  void counttimer() {
    // before_call_is_accepted_timer.cancel();

    call_in_session_timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        time = toMMSS(minuteHand, secondHand);
        callTimerInit = true;
      });
      if (secondHand >= 59) {
        secondHand = 0;
        minuteHand++;
      } else {
        secondHand++;
      }
    });
  }

  Future<void> acceptCall() async {
    var provider = Provider.of<DataProvider>(context, listen: false);
    var documentReference = FirebaseFirestore.instance.collection("users").doc(
        (provider.userType == "serviceProvider")
            ? "${provider.sp_user_id}"
            : "${provider.client_user_id}");
    // retrieve permissions
    await Permission.microphone.request();

    //create the engine
    _engine = await RtcEngine.create(appId);
    _engine.enableAudio();
    _engine.setDefaultAudioRouteToSpeakerphone(false);

    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) async {
         
          setState(() {
            _localUserJoined = true;
            // counttimer();
          });
        },
        leaveChannel: (stats) {
        
          documentReference.update(
              {"call_in_progress": false, "is_calling": false}).then((value) {
            _engine.leaveChannel();
            Navigator.pop(context);
          });
        },
        userJoined: (int uid, int elapsed) {
        
          setState(() {
            _remoteUid = uid;
            callAccepted = true;
            counttimer();
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          
          setState(() {
            _remoteUid = null;
          });
          documentReference.update(reset).then((value) {
            _engine.leaveChannel();
          });
        },
      ),
    );

    await _engine.joinChannel(
      widget.call_token,
      widget.channel_name,
      '',
      0,
    );
  }

  Map<String, dynamic> reset = {
    // "_id": "",
    "call_in_progress": false,
    "is_calling": false,
    "designation": "",
    "channel_name": "",
    "call_token": "",
    "caller_name": "",
    "caller_img": ""
  };

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
    acceptCall();
    ////////////////////// weeeeeeeeeeeeeee

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
          // centerTitle: false,
          // titleSpacing: 0,
          title: Text(
            "Outgoing Call",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
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
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              height: 234,
                              width: 168,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      AnimatedOpacity(
                                        duration: Duration(milliseconds: 1000),
                                        opacity: activeContainerIndex == 2
                                            ? 1.0
                                            : 0.0,
                                        child: DottedBorder(
                                          borderType: BorderType.Circle,
                                          color: Color(0XFF9CA3AF),
                                          radius: Radius.circular(8),
                                          dashPattern: [10, 10],
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
                                        opacity: activeContainerIndex == 1
                                            ? 1.0
                                            : 0.0,
                                        child: DottedBorder(
                                          borderType: BorderType.Circle,
                                          color: Color(0XFFD1D5DB),
                                          radius: Radius.circular(8),
                                          dashPattern: [10, 10],
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
                                        opacity: activeContainerIndex == 0
                                            ? 1.0
                                            : 0.0,
                                        child: DottedBorder(
                                          borderType: BorderType.Circle,
                                          radius: Radius.circular(8),
                                          color: Color(0XFFE5E7EB),
                                          dashPattern: [10, 10],
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

                                      CachedNetworkImage(
                                        imageUrl: widget.caller_img,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        placeholder: (context, url) => Container(
                                            width: 60,
                                            height: 60,
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.person,
                                                size: 50, color: Colors.grey),
                                      ),

                                      // Container(
                                      //   width: 120,
                                      //   height: 120,
                                      //   padding: EdgeInsets.symmetric(horizontal: 20),
                                      //   decoration: BoxDecoration(
                                      //     shape: BoxShape.circle,
                                      //     image: DecorationImage(
                                      //       image: AssetImage("assets/profile.png"),
                                      //     fit: BoxFit.cover)
                                      //     ,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Text(
                                    time,
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0XFF374151)),
                                  ),
                                  Text(
                                    widget.caller_name,
                                    style: TextStyle(
                                        fontSize: 18, color: Color(0XFF121212)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 40,
                  ),
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
                              color: Colors.white.withOpacity(0.3)),
                          child: IconButton(
                            // handles the action performed anytime you press the send button
                            onPressed: () {
                              // sendPicture(context);
                              setState(() {
                                switchMicrophone();
                              });
                            },

                            icon: (openMicrophone)
                                ? Icon(
                                    Icons.mic_none_outlined,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.mic_off,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0XFFEF4444)),
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
                              color: Colors.white.withOpacity(0.3)),
                          child: IconButton(
                            // handles the action performed anytime you press the send button
                            onPressed: () {
                              // sendPicture(context);
                              setState(() {
                                switchSpeakerPhone();
                              });
                            },

                            icon: (enableSpeaker)
                                ? Icon(
                                    Icons.volume_up,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                : Icon(
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
            )));
  }
}
