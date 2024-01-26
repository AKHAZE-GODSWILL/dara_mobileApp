//
// import 'package:dara_app/main.dart';
// import 'package:dara_app/screens/home/homePage.dart';
// import 'package:dara_app/screens/home/offersPage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class BottomNavBar extends StatefulWidget{
//
//   const BottomNavBar({Key? key}) : super(key: key);
//   State<BottomNavBar> createState()=> _BottomNavBar();
// }
//
// class _BottomNavBar extends State<BottomNavBar>{
//
//     int current_index = 0;
//
//     @override
//     void initState() {

//     super.initState();
//     }
//
//
//   // ignore: non_constant_identifier_names
//   void update_index(int value) {
//     setState(() {
//       current_index = value;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context){
//
//
//         List screens = [
//           HomePage(),
//           OffersPage(),
//           HomePage(),
//           HomePage(),
//           HomePage()
//         ];
//
//         return Scaffold(
//
//             body: screens[current_index],
//
//             bottomNavigationBar: BottomNavigationBar(
//           enableFeedback: false,
//           iconSize: 17,
//           backgroundColor: Colors.grey.shade200,
//           type: BottomNavigationBarType.fixed,
//           currentIndex: current_index,
//           onTap: update_index,
//           unselectedItemColor: Colors.grey,
//           unselectedLabelStyle: const TextStyle(
//             overflow: TextOverflow.visible,
//             fontSize: 10,
//             fontWeight: FontWeight.w400,
//           ),
//           showUnselectedLabels: true,
//           selectedItemColor: constants.appMainColor,
//           selectedLabelStyle: const TextStyle(
//             overflow: TextOverflow.visible,
//             fontSize: 10,
//           ),
//           items: [
//             BottomNavigationBarItem(
//               icon:  Padding(
//                 padding: EdgeInsets.only(bottom: 7, top: 6),
//                 child: Container(
//                   height: 24,
//                   width: 24,
//                   child: Image.asset("assets/homeIcon.png"))
//               ),
//               activeIcon: Padding(
//                 padding: const EdgeInsets.only(bottom: 5, top: 3),
//                 child: Container(
//                   height: 24,
//                   width: 24,
//                   child: Image.asset("assets/homeIconHighlighted.png"))
//               ),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Container(
//                 height: 24,
//                 width: 24,
//                 child: Image.asset("assets/offersIcon.png")),
//               activeIcon: Container(
//                 height: 24,
//                 width: 24,
//                 child: Image.asset("assets/offersIconHighlighted.png")),
//               label: 'Offers',
//             ),
//             BottomNavigationBarItem(
//               icon:  Padding(
//                 padding: EdgeInsets.only(bottom: 7, top: 6),
//                 child: Container(
//                   height: 24,
//                   width: 24,
//                   child: Image.asset("assets/postIcon.png")),
//
//                 // Icon(Icons.history_outlined,
//                 //     size: 24, color: Color.fromRGBO(0, 0, 0, 0.5)),
//               ),
//               activeIcon: Padding(
//                 padding: const EdgeInsets.only(bottom: 5, top: 3),
//                 child: Container(
//                   height: 24,
//                   width: 24,
//                   child: Image.asset("assets/postIcon.png")),
//
//                 // CircleAvatar(
//                 //     minRadius: 15,
//                 //     backgroundColor: Constants().primaryColor,
//                 //     child: Icon(Icons.history,
//                 //         size: 24, color: Constants().primaryBackgroundColor)),
//               ),
//
//
//               label: 'Post',
//             ),
//             BottomNavigationBarItem(
//               icon:  Padding(
//                 padding: EdgeInsets.only(bottom: 7, top: 6),
//                 child: Container(
//                   height: 24,
//                   width: 24,
//                   child: Image.asset("assets/projectsIcon.png")),
//
//                 // Icon(Icons.history_outlined,
//                 //     size: 24, color: Color.fromRGBO(0, 0, 0, 0.5)),
//               ),
//               activeIcon: Padding(
//                 padding: const EdgeInsets.only(bottom: 5, top: 3),
//                 child: Container(
//                   height: 24,
//                   width: 24,
//                   child: Image.asset("assets/projectsIcon.png")),
//
//                 // CircleAvatar(
//                 //     minRadius: 15,
//                 //     backgroundColor: Constants().primaryColor,
//                 //     child: Icon(Icons.history,
//                 //         size: 24, color: Constants().primaryBackgroundColor)),
//               ),
//
//
//               label: 'Projects',
//             ),
//             BottomNavigationBarItem(
//               icon:  Padding(
//                 padding: EdgeInsets.only(bottom: 7, top: 6),
//                 child: Container(
//                   height: 24,
//                   width: 24,
//                   child: Image.asset("assets/accountsIcon.png")),
//
//                 // Icon(Icons.history_outlined,
//                 //     size: 24, color: Color.fromRGBO(0, 0, 0, 0.5)),
//               ),
//               activeIcon: Padding(
//                 padding: const EdgeInsets.only(bottom: 5, top: 3),
//                 child: Container(
//                   height: 24,
//                   width: 24,
//                   child: Image.asset("assets/accountsIcon.png")),
//
//                 // CircleAvatar(
//                 //     minRadius: 15,
//                 //     backgroundColor: Constants().primaryColor,
//                 //     child: Icon(Icons.history,
//                 //         size: 24, color: Constants().primaryBackgroundColor)),
//               ),
//
//
//               label: 'Account',
//             ),
//
//           ]),
//
//         );
//   }
// }