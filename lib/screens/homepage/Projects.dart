import 'package:dara_app/screens/homepage/viewProject.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_ph/**/osphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 19),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Projects",
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
          Stack(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.95,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     !selected? InkWell(
                        onTap: (){
                          setState(() {
                            selected = true;
                          });
                          print("first");
                        },
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.425,
                            height: 50,
                            child: Center(child: Text("Ongoing"),),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color:  Color(0xFFf3f4f6)
                            ),
                          ),
                        ),
                      ):Container(),
                      selected? InkWell(
                        onTap: (){
                          print("second");
                          setState(() {
                            selected = false;
                          });
                        },
                        child: Center(
                          child: Container(
                            child: Center(child: Text("Completed"),),
                            width: MediaQuery.of(context).size.width*0.425,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color:  Color(0xFFf3f4f6)
                            ),
                          ),
                        ),
                      ):Container()
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:  Color(0xFFf3f4f6)
                  ),
                ),
              ),
              AnimatedAlign(
                alignment: selected ? Alignment.centerLeft : Alignment.centerRight,
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                  width: MediaQuery.of(context).size.width*0.45,
                  height: 40,
                  child: Center(
                    child: Text(selected?"Ongoing":"Completed",
                      style: TextStyle(color: Colors.white),),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: constants.appMainColor,
                  ),
                ),
              ),

            ],
          ),
         selected? Expanded(
           child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return ViewProject(selected: selected);
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        )
                      );

              },
              child: Column(
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
                                    padding: EdgeInsets.only(top: 3),
                                    width: MediaQuery.of(context).size.width*0.78,
                                    child: RichText(text: TextSpan(children: [
                                      TextSpan(
                                        text:  "Daniel Smith ",
                                        style: TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      ])),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "21/04/23 - 08/05/23",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.78,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            "NGN 25,0000",
                                            style: TextStyle(
                                                fontSize: 13, color: Colors.black),
                                          ),
                                        ),
                                        // Spacer(),
                                        InkWell(
                                          onTap: (){
                                           
                                          },
                                          child: Container(
                                            width:90,
                                            height: 26,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFfff9c3),
                                                borderRadius: BorderRadius.circular(200)
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Ongoing",
                                                style: TextStyle(
                                                    color:  Color(0xFFca8a03),
                                                    fontSize: 13),),
                                            ),
                                          ),
                                        ),
                                      ],
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
            );
           }),
         ):
         Expanded(
           child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index){
            return InkWell(
              onTap: (){

                Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return ViewProject(selected: selected);
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        )
                      );
              },
              child: Column(
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
                                    padding: EdgeInsets.only(top: 3),
                                    width: MediaQuery.of(context).size.width*0.78,
                                    child: RichText(text: TextSpan(children: [
                                      TextSpan(
                                        text:  "Daniel Smith ",
                                        style: TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ])),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "21/04/23 - 08/05/23",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                  ),
                                  Container(
                                   width: MediaQuery.of(context).size.width*0.78,
                                    child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            "NGN 25,0000",
                                            style: TextStyle(
                                                fontSize: 13, color: Colors.black),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                           
                                          },
                                          child: Container(
                                            width:90,
                                            height: 26,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFdcfce7),
                                                borderRadius: BorderRadius.circular(200)
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Completed",
                                                style: TextStyle(
                                                    color:  Color(0xFF21c55e),
                                                    fontSize: 13),),
                                            ),
                                          ),
                                        ),
                                      ],
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
            );
           }),
         )
        ],
      ),
    );
  }
}
