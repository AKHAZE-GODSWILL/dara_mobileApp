import 'dart:io';
import 'mainOnboard.dart';
import 'package:dara_app/main.dart';
import '../homepage/bottomBar.dart';
import 'package:geocode/geocode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/screens/authentication/selectTier.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    late Position position;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // circularCustom(context, "Location permissions are denied");
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // circularCustom(context, "Location permissions are permanently denied, we cannot request permissions.");
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await Geolocator.getCurrentPosition();
    final currentLocation = await Geolocator.getCurrentPosition();
    final currentAddress = await GeoCode().reverseGeocoding(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude);

    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);
    dataProvider.address =
        "${currentAddress.streetAddress}";
  }

  @override
  void initState() {
    determinePosition();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 5), () async {
        return decideFirstWidget();
      });
    });
    super.initState();
  }

  Future<dynamic> decideFirstWidget() async {
    //  String user ="";

    if (getX.read(constants.GETX_LOGGED_IN) == true) {
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
        DataProvider provider =
            Provider.of<DataProvider>(context, listen: true);

        // Schedule the setUserType call after the build phase
        Future.delayed(Duration.zero, () {
          // provider.setUserType(userTier: getX.read(constants.GETX_USER_TIER ?? ""));
        });

        return Material(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/daraSplashLogo.gif",
              fit: BoxFit.cover,
            ),
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
