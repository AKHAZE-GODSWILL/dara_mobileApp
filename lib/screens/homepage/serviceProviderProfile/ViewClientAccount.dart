import 'package:dara_app/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/personalInfo.dart';

class ViewClientAccount extends StatefulWidget {
  const ViewClientAccount({Key? key}) : super(key: key);
  @override
  State<ViewClientAccount> createState() => _ViewClientAccountState();
}

class _ViewClientAccountState extends State<ViewClientAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 260,
              child: Stack(
                children: [
                  Stack(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 210,
                          child: Image.asset(
                            "assets/accBg.png",
                            fit: BoxFit.cover,
                          )),
                      Column(
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border:
                                            Border.all(color: Colors.white38)),
                                    child: Container(
                                        child: Transform.scale(
                                            scale: 0.5,
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.arrow_back,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                            )))),
                                Spacer(),
                                Container(
                                    height: 42,
                                    width: 42,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border:
                                            Border.all(color: Colors.white38)),
                                    child: Container(
                                        child: Transform.scale(
                                            scale: 0.5,
                                            child: SvgPicture.asset(
                                                "assets/svg/moreWhite.svg")))),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: MediaQuery.of(context).size.height * 0.23),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      AssetImage("assets/profile.png"),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.white,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Michael Traore",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "156",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Completed Projects",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 35,
                      width: 0.5,
                      decoration: BoxDecoration(color: Colors.black26),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "98",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Recommended",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Ranking: "),
                                SvgPicture.asset("assets/svg/ranking.svg"),
                                Text(
                                  " Rising Star",
                                  style: TextStyle(
                                      color: Color(0xFFf97315),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFFf3f4f6)),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width:
                                      MediaQuery.of(context).size.width * 0.68,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFFf97315)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Complete 20 more projects to become an expert guru",
                              style: TextStyle(
                                  color: Colors.black26, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.93,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFf97315)),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 15, right: 15),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                    child: Row(
                      children: [
                        Icon(
                          PhosphorIcons.map_pin,
                          size: 20,
                          color: Colors.blue,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Lagos, Nigeria",
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
