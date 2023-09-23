import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

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
   String user ="";

    if (user == null || user == 'null' || user == '') {
      return Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return MainOnboard();
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
    return  Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset("assets/daraSplashLogo.gif", fit: BoxFit.cover,),
      ),
    );
  }
}
