import 'dart:io';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/main.dart';
import 'package:dara_app/screens/authentication/selectTier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homepage/bottomBar.dart';
import 'mainOnboard.dart';




class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_)  {
      Future.delayed(Duration(seconds: 5), () async {
        return decideFirstWidget();
      });

    });
    super.initState();

  }


  Future<dynamic> decideFirstWidget() async {
  //  String user ="";

    if (getX.read(constants.GETX_LOGGED_IN)== true) {
      return Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SelectTier();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
            (route) => false,
      );
    } else {

      return Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return MainOnboard();
              // MainOnboard();
            // HomePageWidget();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
  return Builder(
    builder: (context) {
      // Access the provider using the context
      DataProvider provider = Provider.of<DataProvider>(context, listen: true);

      // Schedule the setUserType call after the build phase
      Future.delayed(Duration.zero, () {
        // provider.setUserType(userTier: getX.read(constants.GETX_USER_TIER ?? ""));
      });

      return Material(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset("assets/daraSplashLogo.gif", fit: BoxFit.cover,),
        ),
      );
    },
  );
}

  // Widget build(BuildContext context) {
  //   DataProvider provider = Provider.of<DataProvider>(context, listen: false);
  //   provider.setUserType(userTier: getX.read(constants.GETX_USER_TIER?? ""));
  //   return  Material(
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       height: MediaQuery.of(context).size.height,
  //       child: Image.asset("assets/daraSplashLogo.gif", fit: BoxFit.cover,),
  //     ),
  //   );
  // }
}
