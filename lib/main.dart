import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/utils/myWidget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dara_app/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dara_app/Firebase/Utils/utils.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/Firebase/Utils/Provider.dart';
import 'package:dara_app/screens/onboarding/splash.dart';
import 'package:dara_app/screens/authentication/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

////////////////// They need to create a project and give me access to a google console where I can get
/// the google map key so that I can Use it for this dara app
/// remember to put permission in info.plist for all dependencies

String device_token = "";

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('1', '1',
          channelDescription: '1',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
      message.notification!.body, notificationDetails,
      payload: 'item x');
  // message.data["status"]
}

final getX = GetStorage();
Constants constants = Constants();
Mywidget mywidgets = Mywidget();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging? _firebaseMessaging;

  void onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  initFirebase() async {
    await Firebase.initializeApp();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    _firebaseMessaging?.requestPermission();
    _firebaseMessaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
   
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('your channel id', 'your channel name',
              channelDescription: 'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher');
      const DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails();
      const NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, iOS: darwinNotificationDetails);
      await flutterLocalNotificationsPlugin.show(0, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: 'item x');
    });

    _firebaseMessaging!.getToken().then((token) async {
      void onDidReceiveNotificationResponse(
          NotificationResponse notificationResponse) async {
        final String? payload = notificationResponse.payload;
        if (notificationResponse.payload != null) {
       
        }
        // await Navigator.push(
        //   context,
        //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
        // );
      }

      device_token = token.toString();
      


      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
      // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

      final DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings(
              onDidReceiveLocalNotification: onDidReceiveLocalNotification);
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      final LinuxInitializationSettings initializationSettingsLinux =
          LinuxInitializationSettings(defaultActionName: 'Open notification');
      final InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              linux: initializationSettingsLinux);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    });
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
    // check();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Utils(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataProviders(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dara',
          theme: ThemeData(
              textTheme: GoogleFonts.interTextTheme(),
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity),

//getX.read(constants.GETX_IS_LOGGED_IN) == "true" ? BottomNavBar() : MyOnboarding()
          home: Splash()),
    );
  }
}
