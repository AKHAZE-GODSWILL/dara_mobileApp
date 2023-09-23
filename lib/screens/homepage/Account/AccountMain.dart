import 'package:dara_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';

import 'Overview.dart';
import 'Posts.dart';
import 'Reviews.dart';

enum TypeSelected { OVERVIEW, POST, REVIEW }

class AccountMain extends StatefulWidget {
  const AccountMain({Key? key}) : super(key: key);

  @override
  State<AccountMain> createState() => _AccountMainState();
}

class _AccountMainState extends State<AccountMain> {
  TypeSelected selected = TypeSelected.OVERVIEW;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                                      borderRadius: BorderRadius.circular(100),
                                      border:
                                          Border.all(color: Colors.white38)),
                                  child: Container(
                                      child: Transform.scale(
                                          scale: 0.5,
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                            size: 30,
                                          )))),
                              Spacer(),
                              Container(
                                  height: 42,
                                  width: 42,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border:
                                          Border.all(color: Colors.white38)),
                                  child: Container(
                                      child: Transform.scale(
                                          scale: 0.5,
                                          child: SvgPicture.asset(
                                              "assets/svg/moreWhite.svg")))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10,
                              top: MediaQuery.of(context).size.height * 0.13),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: SvgPicture.asset("assets/svg/camera2.svg"),
                          ),
                        ),
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
                          top: MediaQuery.of(context).size.height * 0.26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage("assets/profile.png"),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.white,
                          ),
                          SvgPicture.asset("assets/svg/edit.svg")
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.34,
                          left: 75),
                      child: SvgPicture.asset("assets/svg/camera.svg"),
                    ),
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
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text:
                        "Laundry Perfectionist at your Servioce! Discover the Art of Flawless laundry",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  TextSpan(
                    text:
                        " #CleanFreaks #Laundrymargic #StainRemoval #LAundryGuru #CustomerSatisfaction",
                    style:
                        TextStyle(fontSize: 13, color: constants.appMainColor),
                  )
                ])),
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
                      "4.8/5.0",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Client Ratings",
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
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        selected != TypeSelected.OVERVIEW
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = TypeSelected.OVERVIEW;
                                  });
                                  print("first");
                                },
                                child: Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: 50,
                                    child: Center(
                                      child: Text("OverView"),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xFFf3f4f6)),
                                  ),
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                        selected != TypeSelected.POST
                            ? InkWell(
                                onTap: () {
                                  print("second");
                                  setState(() {
                                    selected = TypeSelected.POST;
                                  });
                                },
                                child: Center(
                                  child: Container(
                                    child: Center(
                                      child: Text("Posts"),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xFFf3f4f6)),
                                  ),
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                        selected != TypeSelected.REVIEW
                            ? InkWell(
                                onTap: () {
                                  print("second");
                                  setState(() {
                                    selected = TypeSelected.REVIEW;
                                  });
                                },
                                child: Center(
                                  child: Container(
                                    child: Center(
                                      child: Text("Reviews"),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xFFf3f4f6)),
                                  ),
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                              )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFf3f4f6)),
                  ),
                ),
                AnimatedAlign(
                  alignment: selected == TypeSelected.OVERVIEW
                      ? Alignment.centerLeft
                      : selected == TypeSelected.POST
                          ? Alignment.center
                          : Alignment.centerRight,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn,
                  child: Container(
                    margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 40,
                    child: Center(
                      child: Text(
                        selected == TypeSelected.OVERVIEW
                            ? "Overview"
                            : selected == TypeSelected.POST
                                ? "Posts"
                                : "Reviews",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: constants.appMainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(),


          selected == TypeSelected.OVERVIEW
              ? Overview()
              : selected == TypeSelected.POST
                  ? Posts()
                  : Reviews()
        ],
      ),
    );
  }
}
