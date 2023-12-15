import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dara_app/main.dart';
import 'package:dara_app/screens/homepage/Account/clientAccount.dart';
import 'package:dara_app/screens/homepage/createPost.dart';
import 'package:dara_app/screens/homepage/discoverPage.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/receivedCallScreen.dart';
import 'package:dara_app/screens/homepage/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
// import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/Provider/DataProvider.dart';
// import 'package:svg_flutter/svg.dart';
import 'Account/AccountMain.dart';
import 'Offers.dart';
import 'Projects.dart';

class Bottombar extends StatefulWidget {
  final initial;
  final userType;
  final user_id;

  Bottombar({this.initial, required this.userType, required this.user_id});

  @override
  _BottombarState createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  PageController? controller;
  late StreamSubscription<DocumentSnapshot> subscription;
  final GlobalKey<_BottombarState> key = GlobalKey<_BottombarState>(); 

  show_incoming_call_kit(var firestoreData) async {

    // DataProvider provider = Provider.of<DataProvider>(key.currentContext!, listen: true);
    var documentReference = FirebaseFirestore.instance
      .collection((widget.userType == "serviceProvider")? "serviceProviders":"clients")
      .doc((widget.userType == "serviceProvider")? widget.user_id:widget.user_id);
      
    // _pageManager.pause();
  CallKitParams params = CallKitParams(
    appName: 'UseDara',
    id: firestoreData['channel_name'],
    nameCaller: firestoreData['caller_name'],
    avatar: firestoreData['caller_img'],
    // 'handle': number, //	Phone number/Email/Any.
    type: 0, //0 - Audio Call, 1 - Video Call
    duration: 60000, //30000 == 30secs
    extra: <String, dynamic>{
      'userId': firestoreData['channel_name'],
    },
    android: AndroidParams(
      isCustomNotification: true,
      isShowLogo: false, //Show logo app inside full screen. /android/src/main/res/drawable-xxxhdpi/ic_logo.png
      ringtonePath: 'system_ringtone_default',
      // 'ringtonePath': 'ringtone_default',
      backgroundColor: '#000000',
      backgroundUrl: '',
      actionColor: '#4CAF50'
  ),
  );
  await FlutterCallkitIncoming.showCallkitIncoming(params);



  FlutterCallkitIncoming.onEvent.listen((event) {
    
    if (event?.event == Event.actionCallAccept) {
      print('>>>>>>>>>>>>>>>>>>>>>>> CALL ACCEPTED');
      
      //.......................................................... MAKE SURE YOU PUSH TO THE CALL SCREEN ...........................
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ReceivedCallsScreen(call_token: firestoreData['call_token'], channel_name: firestoreData['channel_name'], caller_name: firestoreData['caller_name'], caller_img: firestoreData['caller_img']); //SignUpAddress();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        )
      );


    } else if (event?.event == Event.actionCallDecline) {
      print('>>>>>>>>>>>>>>>>>>>>>>> ACTION_CALL_DECLINE');
      // Future.delayed(Duration(seconds: 2)).then((value) {
      //   print('>>>>>>>>>>>>>>>>>>>>>>> AFTER 2 SECS ');
      //   // FlutterCallkitIncoming.startCall(params);
      //   FlutterCallkitIncoming.endCall(params);
      // });

      // FlutterCallkitIncoming.endCall(params);
      documentReference.update(reset);
    } else if (event?.event == Event.actionCallTimeout) {
      print('>>>>>>>>>>>>>>>>>>>>>>> ACTION_CALL_TIMEOUT');

      // FlutterCallkitIncoming.endCall(params);
      documentReference.update(reset);
    } else if (event?.event == Event.actionCallEnded) {
      print('>>>>>>>>>>>>>>>>>>>>>>> ACTION_CALL_ENDED');
      documentReference.update(reset);
    }
    //other actions exist, check the package for details
  });
// }
}

Map<String, dynamic> reset = {
  "call_in_progress": false,
  "channel_name": "",
  "caller_name": "",
  "caller_img": "",
  "is_calling": false,
  "call_token": "",
};

  @override
  void initState() {
    // TODO: implement initState
    

    // DataProvider provider = Provider.of<DataProvider>(key.currentContext!, listen: true);
    var documentReference = FirebaseFirestore.instance
      .collection((widget.userType == "serviceProvider")? "serviceProviders":"clients")
      .doc((widget.userType == "serviceProvider")? widget.user_id:widget.user_id);

    subscription = documentReference.snapshots().listen((event) {

      if (event['is_calling'] == false && event['call_in_progress'] == false) {
        print('>>>>>>>>>>>>>>>>>>>>>>> NO CALLS COMING IN YET ');
        FlutterCallkitIncoming.endAllCalls();
        // player.stop();
      }

      if(event.exists){

        if (event['is_calling'] == true && event['call_in_progress'] == false) {
        

        show_incoming_call_kit(event);
        FlutterForegroundTask.wakeUpScreen(); 
      }
      }
      else{
        print("Document does not exist");
      }
    });
    super.initState();

    controller = PageController(
        viewportFraction: 1,
        initialPage: widget.initial == null ? 0 : widget.initial);
  }

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    // DataProvider dataProvider =
    //     Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      key: key,
      resizeToAvoidBottomInset: false,
      body: pageIndex == 0
          ? HomePage(userType: provider.userType!,)
          : pageIndex == 1
              ? Offers()
              : (pageIndex == 2)? (provider.userType == "serviceProvider")?CreatePost(backToHome: backToHome,): DiscoverPage()
                  : pageIndex == 3
                      ? Projects()
                      : (provider.userType == "serviceProvider")?AccountMain(backToHome: backToHome):ClientAccount(backToHome: backToHome),
      bottomNavigationBar: buildMyNavBar(context,

          // dataProvider
      ),
    );
  }

  BottomNavigationBar buildMyNavBar(
      BuildContext context
      // DataProvider dataProvider
      ) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
          // dataProvider.setValue(index);
        },
        enableFeedback: false,
        useLegacyColorScheme: false,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black),

        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black),
        fixedColor: Colors.black38,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/homeBold.svg",color: Colors.black,),
            activeIcon: SvgPicture.asset("assets/svg/homeOutline.svg"),
            label: "Home",
            
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/noteBold.svg",color: Colors.black,),
              activeIcon: SvgPicture.asset("assets/svg/noteOut.svg"),
              label: "Offers"),
          BottomNavigationBarItem(
              icon: (provider.userType == "serviceProvider")? SvgPicture.asset("assets/svg/postOut.svg",color: Colors.black,): SvgPicture.asset("assets/svg/discover.svg",color: Colors.black,),
              activeIcon: (provider.userType == "serviceProvider")? SvgPicture.asset("assets/svg/postOut.svg",color: constants.appMainColor,): SvgPicture.asset("assets/svg/discover-blue.svg"),
              label: (provider.userType == "serviceProvider")? "Post": "Discover",
              ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/projectOut.svg",color: Colors.black,),
              activeIcon: SvgPicture.asset("assets/svg/project.svg"),
              label: "Projects"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/profile.svg",color: Colors.black,),
              activeIcon:  SvgPicture.asset("assets/svg/profileOut.svg"),
              label: "Account"),
        ]);
  }

  void backToHome({required int index}){
    setState(() {
      pageIndex = index;
    });
  }
}
