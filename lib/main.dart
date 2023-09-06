
import 'package:dara_app/screens/onboarding/mainOnboard.dart';
import 'package:dara_app/screens/onboarding/onBoard1.dart';
import 'package:dara_app/screens/onboarding/onBoard2.dart';
import 'package:dara_app/screens/onboarding/onBoard3.dart';
import 'package:dara_app/screens/onboarding/onBoard4.dart';
import 'package:dara_app/utils/constants.dart';
import 'package:dara_app/utils/myWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

final getX = GetStorage();
Constants constants = Constants();
 Mywidget mywidgets = Mywidget();

Future <void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  
  MyApp();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Dara',
      

      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),

//getX.read(constants.GETX_IS_LOGGED_IN) == "true" ? BottomNavBar() : MyOnboarding()
      home: MainOnboard()
    );
  }
}

