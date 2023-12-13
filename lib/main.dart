
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/screens/authentication/login.dart';
import 'package:dara_app/screens/onboarding/splash.dart';
import 'package:dara_app/utils/constants.dart';
import 'package:dara_app/utils/myWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

////////////////// They need to create a project and give me access to a google console where I can get
/// the google map key so that I can Use it for this dara app
/// remember to put permission in info.plist for all dependencies

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            

            create: (context) => DataProvider(),
          ),
      ],
      child: MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Dara',
      

      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),

//getX.read(constants.GETX_IS_LOGGED_IN) == "true" ? BottomNavBar() : MyOnboarding()
      home:  Splash()
    ),);
  }
}

