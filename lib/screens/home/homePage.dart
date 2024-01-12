// import 'dart:io';
//
// import 'package:dara_app/main.dart';
// import 'package:flutter/material.dart';
//
// class HomePage extends StatefulWidget{
//   HomePage({Key? key}): super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePage();
// }
//
// class _HomePage extends State<HomePage>{
//   String imgPath = "";
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         leading: Container(),
//         centerTitle: false,
//         titleSpacing: 0,
//         title: Transform(
//           transform: Matrix4.translationValues(-40, 0, 0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               (imgPath.isEmpty)? Container(
//               width: 48,
//               height: 48,
//               decoration: BoxDecoration(
//                 color: Color(0XFFF3F4F6),
//                 shape: BoxShape.circle
//               ),
//               child: Icon(Icons.person_rounded,
//                 size: 50,
//                 color: Colors.grey,),
//                                 )
//               :Container(
//                 width: 48,
//                 height:48,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle
//                 ),
//                 child: ClipOval(
//                   child: Image.file(
//                     File(imgPath),
//                     fit: BoxFit.cover
//                   ),
//                 )
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 5),
//                 child: Container(
//                   // color: Colors.yellow,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Hi Micheal",
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Icon(Icons.location_on_outlined,size:12,color:Colors.black, ),
//                           Text("Lagos",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey
//                             )
//                           ),
//                           SizedBox(width: 5,),
//                           Text("Nigeria",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey
//                             )
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: InkWell(
//               child: Container(
//                 height: 48,
//                 width: 48,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Colors.grey
//                   )
//                 ),
//                 child: Icon(Icons.notifications_none_outlined, color: Colors.black,),
//               ),
//
//             ),
//           )
//         ],
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Container(
//         child: ListView.separated(
//           // physics: NeverScrollableScrollPhysics(),
//           itemCount: 3,
//           separatorBuilder: (context, index) {
//             return Divider();
//           },
//           itemBuilder: (context, index){
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical:5),
//               child: Container(
//                 height: 420,
//                 width: MediaQuery.of(context).size.width*0.9,
//                 child: Column(
//                   children: [
//                     Container(
//                       // color: Colors.red,
//                       height: 50,
//                       width: MediaQuery.of(context).size.width*0.9,
//                       child: Row(
//                         children: [
//                           (imgPath.isEmpty)? Container(
//                             width: 48,
//                             height: 48,
//                             decoration: BoxDecoration(
//                               color: Color(0XFFF3F4F6),
//                               shape: BoxShape.circle
//                             ),
//                             child: Icon(Icons.person_rounded,
//                               size: 50,
//                               color: Colors.grey,),
//                                               )
//                             :Container(
//                               width: 48,
//                               height:48,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle
//                               ),
//                               child: ClipOval(
//                                 child: Image.file(
//                                   File(imgPath),
//                                   fit: BoxFit.cover
//                                 ),
//                               )
//                             ),
//
//                             SizedBox(width: 10,),
//
//                           Container(
//                             // color: Colors.blue,
//                             width: 200,
//                             height: 60,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("Daniel Smith",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.black),
//                                 ),
//                                 Container(
//                                   // color: Colors.green,
//                                   width: 120,
//                                   height: 20,
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.star,size: 12, color: Colors.amber,),
//                                       Text("4.8",
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.grey
//                                         )
//                                       ),
//                                       SizedBox(width: 10,),
//                                       Text("Plumber",
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.grey
//                                         )
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 Text("8h",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey
//                                       )
//                                     )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 10,),
//
//                     //The message and the Image comes  here and are all in one container
//                     Container(
//                       height: 48,
//                       width: MediaQuery.of(context).size.width*0.9,
//                       child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec lectus vel erat viverra elementum. Vivamus euismod eget nulla sed consequat. Nulla facilisi. Sed in diam elit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.",
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 3,
//                       ),
//
//                       ),
//
//                     Container(
//                       height: 272,
//                       width: MediaQuery.of(context).size.width*0.9,
//                       child: Image.asset("assets/plumber.png")
//                     ),
//
//                     SizedBox(height: 10,),
//
//                     Container(
//                       height: 20,
//                       width: MediaQuery.of(context).size.width*0.9,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             height: 20,
//                             width: 70,
//                             child: Row(
//                               children: [
//                                 Icon(Icons.favorite_border_outlined),
//                                 SizedBox(width: 5,),
//                                 Text("267")
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 20,
//                             width: 70,
//                             child: Row(
//                               children: [
//                                 Icon(Icons.remove_red_eye_outlined),
//                                 SizedBox(width: 5,),
//                                 Text("5,326")
//                               ],
//                             ),
//                           ),
//
//                           Icon(Icons.ios_share_outlined, size: 20,)
//                         ],
//                       ),
//                     )
//
//                   ],
//                 ),
//               ),
//             );
//           }),
//       ),
//     );
//   }
//
// }