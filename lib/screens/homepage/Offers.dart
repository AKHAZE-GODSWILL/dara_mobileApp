import 'package:flutter/material.dart';
// import 'package:flutter_ph/**/osphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
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
                  Text(
                    "Offers",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black12)),
                      child: Container(
                          child: Transform.scale(
                              scale: 0.5,
                              child: SvgPicture.asset("assets/svg/more.svg")))),
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
                                        radius: 22,
                                        backgroundImage:
                                            AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 32),
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
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.81,
                                      child: RichText(text: TextSpan(children: [
                                        TextSpan(
                                          text:  "Daniel Smith ",
                                          style: TextStyle(fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                        TextSpan(
                                        text:  "sent a request to hire ypour services for a project",
                                        style: TextStyle(fontSize: 12, color: Colors.black54),
                                      )])),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "6h",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),

                          Row(children: [
                            SizedBox(width: MediaQuery.of(context).size.width*0.125,),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                width: 100,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: constants.appMainColor,
                                    borderRadius: BorderRadius.circular(200)
                                ),
                                child: Center(
                                  child: Text(
                                    "View Details",
                                    style: TextStyle(
                                        color:  Colors.white,
                                        fontSize: 14),),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  width: 100,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: constants.appMainColor, width: 2),
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(
                                          color:   constants.appMainColor,
                                          fontSize: 14),),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  width: 90,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Decline",
                                      style: TextStyle(
                                          color:   Colors.red,
                                          fontSize: 14),),
                                  ),
                                ),
                              ),
                            ),
                          ],)

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
                                        radius: 22,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 32),
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
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.81,
                                      child: RichText(text: TextSpan(children: [
                                        TextSpan(
                                          text:  "Daniel Smith ",
                                          style: TextStyle(fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                        TextSpan(
                                          text:  "sent a request to hire ypour services for a project",
                                          style: TextStyle(fontSize: 12, color: Colors.black54),
                                        )])),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "6h",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),

                          Row(children: [
                            SizedBox(width: MediaQuery.of(context).size.width*0.125,),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                width: 100,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: constants.appMainColor,
                                    borderRadius: BorderRadius.circular(200)
                                ),
                                child: Center(
                                  child: Text(
                                    "View Details",
                                    style: TextStyle(
                                        color:  Colors.white,
                                        fontSize: 14),),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  width: 100,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: constants.appMainColor, width: 2),
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(
                                          color:   constants.appMainColor,
                                          fontSize: 14),),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  width: 90,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Decline",
                                      style: TextStyle(
                                          color:   Colors.red,
                                          fontSize: 14),),
                                  ),
                                ),
                              ),
                            ),
                          ],)

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
                                        radius: 22,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 32),
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
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.81,
                                      child: RichText(text: TextSpan(children: [
                                        TextSpan(
                                          text:  "Daniel Smith ",
                                          style: TextStyle(fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                        TextSpan(
                                          text:  "sent a request to hire ypour services for a project",
                                          style: TextStyle(fontSize: 12, color: Colors.black54),
                                        )])),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "6h",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),

                          Row(children: [
                            SizedBox(width: MediaQuery.of(context).size.width*0.125,),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                width: 100,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: constants.appMainColor,
                                    borderRadius: BorderRadius.circular(200)
                                ),
                                child: Center(
                                  child: Text(
                                    "View Details",
                                    style: TextStyle(
                                        color:  Colors.white,
                                        fontSize: 14),),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  width: 100,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: constants.appMainColor, width: 2),
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(
                                          color:   constants.appMainColor,
                                          fontSize: 14),),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  width: 90,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Decline",
                                      style: TextStyle(
                                          color:   Colors.red,
                                          fontSize: 14),),
                                  ),
                                ),
                              ),
                            ),
                          ],)

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
                                        radius: 22,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 32),
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
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.81,
                                      child: RichText(text: TextSpan(children: [
                                        TextSpan(
                                          text:  "Daniel Smith ",
                                          style: TextStyle(fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                        TextSpan(
                                          text:  "sent a request to hire ypour services for a project",
                                          style: TextStyle(fontSize: 12, color: Colors.black54),
                                        )])),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "6h",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),

                          Row(children: [
                            SizedBox(width: MediaQuery.of(context).size.width*0.125,),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                width: 100,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: constants.appMainColor,
                                    borderRadius: BorderRadius.circular(200)
                                ),
                                child: Center(
                                  child: Text(
                                    "View Details",
                                    style: TextStyle(
                                        color:  Colors.white,
                                        fontSize: 14),),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  width: 100,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: constants.appMainColor, width: 2),
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(
                                          color:   constants.appMainColor,
                                          fontSize: 14),),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  width: 90,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Decline",
                                      style: TextStyle(
                                          color:   Colors.red,
                                          fontSize: 14),),
                                  ),
                                ),
                              ),
                            ),
                          ],)

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
                                        radius: 22,
                                        backgroundImage:
                                        AssetImage("assets/profile1.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 32),
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
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.81,
                                      child: RichText(text: TextSpan(children: [
                                        TextSpan(
                                          text:  "Daniel Smith ",
                                          style: TextStyle(fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                        TextSpan(
                                          text:  "sent a request to hire ypour services for a project",
                                          style: TextStyle(fontSize: 12, color: Colors.black54),
                                        )])),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "6h",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),



                              ],
                            ),
                          ),

                          Row(children: [
                            SizedBox(width: MediaQuery.of(context).size.width*0.125,),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                width: 100,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: constants.appMainColor,
                                    borderRadius: BorderRadius.circular(200)
                                ),
                                child: Center(
                                  child: Text(
                                    "View Details",
                                    style: TextStyle(
                                        color:  Colors.white,
                                        fontSize: 14),),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  width: 100,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: constants.appMainColor, width: 2),
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(
                                          color:   constants.appMainColor,
                                          fontSize: 14),),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  width: 90,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Decline",
                                      style: TextStyle(
                                          color:   Colors.red,
                                          fontSize: 14),),
                                  ),
                                ),
                              ),
                            ),
                          ],)

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
