// import 'package:flutter/material.dart';
// import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

// class Reviews extends StatefulWidget {
//   const Reviews({Key? key}) : super(key: key);

//   @override
//   State<Reviews> createState() => _ReviewsState();
// }

// class _ReviewsState extends State<Reviews> {
//   final textNode = FocusNode();
//   final _textEditingController = TextEditingController();
//   final passwordFocusNode = FocusNode();
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 12.0, right: 12),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 0.0, bottom: 8),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: CircleAvatar(
//                             radius: 20,
//                             backgroundImage: AssetImage("assets/profile1.png"),
//                           ),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Debby Stanley",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w400),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Icon(
//                                     PhosphorIcons.star_fill,
//                                     color: Colors.orangeAccent,
//                                     size: 12,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Icon(
//                                     PhosphorIcons.star_fill,
//                                     color: Colors.orangeAccent,
//                                     size: 12,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Icon(
//                                     PhosphorIcons.star_fill,
//                                     color: Colors.orangeAccent,
//                                     size: 12,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Icon(
//                                     PhosphorIcons.star_fill,
//                                     color: Colors.orangeAccent,
//                                     size: 12,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Icon(
//                                     PhosphorIcons.star_fill,
//                                     color: Colors.orangeAccent,
//                                     size: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),

//                           ],
//                         ),
//                         Spacer(),
//                         Text(
//                           "08/05/23",
//                           style: TextStyle(fontSize: 12, color: Colors.black87),
//                         )
//                         // SvgPicture.asset("assets/svg/more.svg")
//                       ],
//                     ),
//                   ),
//                   Text(
//                     "Lorem ipsum dolor sit amet consectetur. Donec vulputate tristique sit quis tristique sit ut ultrices. "
//                     "Adipiscing pulvinar eros arcu scelerisque lectus scelerisque... See more",
//                     style: TextStyle(fontSize: 12, color: Colors.black54),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top:8.0, bottom: 8),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: CircleAvatar(
//                             radius: 15,
//                             backgroundImage: AssetImage("assets/profile.png"),
//                           ),
//                         ),
//                         Container(
//                           height: 35,
//                           width: MediaQuery.of(context).size.width*0.82,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               border: Border.all(
//                                   width: 1,
//                                   color: Color(0XFFE5E7EB)
//                               )
//                           ),
//                           child: TextFormField(
//                             onChanged: (value){
//                               setState(() {

//                               });
//                             },
//                             focusNode: textNode,
//                             keyboardType: TextInputType.emailAddress,
//                             controller: _textEditingController,
//                             decoration: InputDecoration(
//                               hintStyle: TextStyle(fontSize: 13),
//                               focusedBorder:OutlineInputBorder(
//                                 borderSide: BorderSide.none, // Remove the border when focused
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide.none, // Remove the border when enabled
//                               ),
//                               hintText: "Write a reply",
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Divider()
//           ],
//         ),
//         Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 12.0, right: 12),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 0.0, bottom: 8),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: CircleAvatar(
//                             radius: 20,
//                             backgroundImage: AssetImage("assets/profile1.png"),
//                           ),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Stephen Busayo",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w400),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Icon(
//                                     PhosphorIcons.star_fill,
//                                     color: Colors.orangeAccent,
//                                     size: 12,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Icon(
//                                     PhosphorIcons.star_fill,
//                                     color: Colors.orangeAccent,
//                                     size: 12,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Icon(
//                                     PhosphorIcons.star_fill,
//                                     color: Colors.orangeAccent,
//                                     size: 12,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Icon(
//                                     PhosphorIcons.star_fill,
//                                     color: Colors.orangeAccent,
//                                     size: 12,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(2.0),
//                                   child: Icon(
//                                     PhosphorIcons.star_fill,
//                                     color: Colors.orangeAccent,
//                                     size: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),

//                           ],
//                         ),
//                         Spacer(),
//                         Text(
//                           "08/05/23",
//                           style: TextStyle(fontSize: 12, color: Colors.black87),
//                         )
//                         // SvgPicture.asset("assets/svg/more.svg")
//                       ],
//                     ),
//                   ),
//                   Text(
//                     "Lorem ipsum dolor sit amet consectetur. Donec vulputate tristique sit quis tristique sit ut ultrices. "
//                         "Adipiscing pulvinar eros arcu scelerisque lectus scelerisque... See more",
//                     style: TextStyle(fontSize: 12, color: Colors.black54),
//                   ),

//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                   color: Color(0xFFf3f4f6)),
//               width: MediaQuery.of(context).size.width*0.95,
//               height: 115,
//               child: Padding(
//                 padding: const EdgeInsets.only(top:10.0, bottom: 10),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 12.0, right: 12),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 0.0, bottom: 8),
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 8.0),
//                                   child: CircleAvatar(
//                                     radius: 17,
//                                     backgroundImage: AssetImage("assets/profile1.png"),
//                                   ),
//                                 ),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Michael Traore",
//                                       style: TextStyle(
//                                           fontSize: 15, fontWeight: FontWeight.w400),
//                                     ),

//                                   ],
//                                 ),
//                                 Spacer(),
//                                 Text(
//                                   "08/05/23",
//                                   style: TextStyle(fontSize: 12, color: Colors.black87),
//                                 )
//                                 // SvgPicture.asset("assets/svg/more.svg")
//                               ],
//                             ),
//                           ),
//                           Text(
//                             "Lorem ipsum dolor sit amet consectetur. Donec vulputate tristique sit quis tristique sit ut ultrices. "
//                                 "Adipiscing pulvinar eros arcu scelerisque lectus scelerisque... See more",
//                             style: TextStyle(fontSize: 12, color: Colors.black54),
//                           ),

//                         ],
//                       ),
//                     ),

//                   ],
//                 ),
//               ),
//             ),
//             Divider()
//           ],
//         ),

//       ],
//     );
//   }
// }
