import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 19),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border:
                          Border.all(color: Colors.black12)),
                      child: Container(
                          child: Transform.scale(
                              scale: 0.5,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 30,
                              )))),
                  Padding(
                    padding: const EdgeInsets.only(left:12.0),
                    child: Text(
                      "Notifications",
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                 Text("")
                ],
              ),
            ),
            Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12.0, right: 12),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 38),
                                        child: Container(
                                          child: Text(""),
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              border: Border.all(color: Colors.white, width: 2),
                                              color: Colors.green
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.65,
                                          child: RichText(text: TextSpan(children: [
                                            TextSpan(
                                              text:  "Daniel Smith ",
                                              style: TextStyle(fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                            TextSpan(
                                              text:  "gave you review on your successful project completion",
                                              style: TextStyle(fontSize: 12, color: Colors.black54),
                                            )])),
                                        ),
                                        SizedBox(width:MediaQuery.of(context).size.width*0.08),
                                        SvgPicture.asset("assets/svg/more.svg")
                                      ],
                                    ),
                                    
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "2m",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12.0, right: 12),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 38),
                                        child: Container(
                                          child: Text(""),
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              border: Border.all(color: Colors.white, width: 2),
                                              color: Colors.green
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.65,
                                          child: RichText(text: TextSpan(children: [
                                            TextSpan(
                                              text:  "Daniel Smith ",
                                              style: TextStyle(fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                            TextSpan(
                                              text:  "gave you review on your successful project completion",
                                              style: TextStyle(fontSize: 12, color: Colors.black54),
                                            )])),
                                        ),
                                        SizedBox(width:MediaQuery.of(context).size.width*0.08),
                                        SvgPicture.asset("assets/svg/more.svg")
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "2m",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(),
                    )
                  ],
                ),

                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12.0, right: 12),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 38),
                                        child: Container(
                                          child: Text(""),
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              border: Border.all(color: Colors.white, width: 2),
                                              color: Colors.green
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.65,
                                          child: RichText(text: TextSpan(children: [
                                            TextSpan(
                                              text:  "Daniel Smith ",
                                              style: TextStyle(fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                            TextSpan(
                                              text:  "gave you review on your successful project completion",
                                              style: TextStyle(fontSize: 12, color: Colors.black54),
                                            )])),
                                        ),
                                        SizedBox(width:MediaQuery.of(context).size.width*0.08),
                                        SvgPicture.asset("assets/svg/more.svg")
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "2m",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(),
                    )
                  ],
                ),

                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12.0, right: 12),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 38),
                                        child: Container(
                                          child: Text(""),
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              border: Border.all(color: Colors.white, width: 2),
                                              color: Colors.green
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.65,
                                          child: RichText(text: TextSpan(children: [
                                            TextSpan(
                                              text:  "Daniel Smith ",
                                              style: TextStyle(fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                            TextSpan(
                                              text:  "gave you review on your successful project completion",
                                              style: TextStyle(fontSize: 12, color: Colors.black54),
                                            )])),
                                        ),
                                        SizedBox(width:MediaQuery.of(context).size.width*0.08),
                                        SvgPicture.asset("assets/svg/more.svg")
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "2m",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
