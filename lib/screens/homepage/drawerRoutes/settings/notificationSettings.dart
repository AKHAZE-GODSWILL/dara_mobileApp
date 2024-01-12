import 'package:dara_app/main.dart';
import 'package:flutter/material.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool receivePushNotification = true;
  bool playSound = true;
  bool likePostAlert = true;
  bool recommendationAlert = true;
  bool hireAlert = true;
  bool messageAlert = true;

  @override
  void initState() {
    super.initState();
  }

// @override
// void dispose() {
// super.dispose();
// _controller.dispose();
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          centerTitle: false,
          titleSpacing: 0,
          title: Transform(
            transform: Matrix4.translationValues(-55, 0, 0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black12)),
                      child: Container(
                          child: Transform.scale(
                              scale: 0.5,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              )))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Notification Settings",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Spacer(),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "General",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width * 0.95,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(8),
                          //   border: Border.all(
                          //     width: 1,
                          //     color: Color(0XFFE5E7EB)
                          //   )
                          // ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 32,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Receive Push Notifications",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        width: 35,
                                        height: 20,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Container(
                                                width: 35,
                                                height: 20,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      receivePushNotification =
                                                          !receivePushNotification;
                                                    });
                                                    print("only");
                                                  },
                                                  child: Center(
                                                    child: Container(
                                                      width: 35,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color:
                                                            receivePushNotification
                                                                ? constants
                                                                    .appMainColor
                                                                : Color(
                                                                    0XFF6B7280),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color:
                                                        constants.appMainColor),
                                              ),
                                            ),
                                            AnimatedAlign(
                                              alignment: receivePushNotification
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.fastOutSlowIn,
                                              child: Container(
                                                // margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  height: 32,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Play Sound",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        width: 35,
                                        height: 20,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Container(
                                                width: 35,
                                                height: 20,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      playSound = !playSound;
                                                    });
                                                    print("only");
                                                  },
                                                  child: Center(
                                                    child: Container(
                                                      width: 35,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: playSound
                                                            ? constants
                                                                .appMainColor
                                                            : Color(0XFF6B7280),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color:
                                                        constants.appMainColor),
                                              ),
                                            ),
                                            AnimatedAlign(
                                              alignment: playSound
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.fastOutSlowIn,
                                              child: Container(
                                                // margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                        Text("Notify when someone",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          // color: Colors.red,
                          height: 240,
                          width: MediaQuery.of(context).size.width * 0.95,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(8),
                          //   border: Border.all(
                          //     width: 1,
                          //     color: Color(0XFFE5E7EB)
                          //   )
                          // ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 32,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Likes my post",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        width: 35,
                                        height: 20,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Container(
                                                width: 35,
                                                height: 20,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      likePostAlert =
                                                          !likePostAlert;
                                                    });
                                                    print("only");
                                                  },
                                                  child: Center(
                                                    child: Container(
                                                      width: 35,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: likePostAlert
                                                            ? constants
                                                                .appMainColor
                                                            : Color(0XFF6B7280),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color:
                                                        constants.appMainColor),
                                              ),
                                            ),
                                            AnimatedAlign(
                                              alignment: likePostAlert
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.fastOutSlowIn,
                                              child: Container(
                                                // margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  height: 32,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Recommends my service",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        width: 35,
                                        height: 20,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Container(
                                                width: 35,
                                                height: 20,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      recommendationAlert =
                                                          !recommendationAlert;
                                                    });
                                                    print("only");
                                                  },
                                                  child: Center(
                                                    child: Container(
                                                      width: 35,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color:
                                                            recommendationAlert
                                                                ? constants
                                                                    .appMainColor
                                                                : Color(
                                                                    0XFF6B7280),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color:
                                                        constants.appMainColor),
                                              ),
                                            ),
                                            AnimatedAlign(
                                              alignment: recommendationAlert
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.fastOutSlowIn,
                                              child: Container(
                                                // margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  height: 32,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Hires me",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        width: 35,
                                        height: 20,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Container(
                                                width: 35,
                                                height: 20,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      hireAlert = !hireAlert;
                                                    });
                                                    print("only");
                                                  },
                                                  child: Center(
                                                    child: Container(
                                                      width: 35,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: hireAlert
                                                            ? constants
                                                                .appMainColor
                                                            : Color(0XFF6B7280),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color:
                                                        constants.appMainColor),
                                              ),
                                            ),
                                            AnimatedAlign(
                                              alignment: hireAlert
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.fastOutSlowIn,
                                              child: Container(
                                                // margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              Divider(),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  height: 32,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Sends a message",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        width: 35,
                                        height: 20,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Container(
                                                width: 35,
                                                height: 20,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      messageAlert =
                                                          !messageAlert;
                                                    });
                                                    print("only");
                                                  },
                                                  child: Center(
                                                    child: Container(
                                                      width: 35,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: messageAlert
                                                            ? constants
                                                                .appMainColor
                                                            : Color(0XFF6B7280),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color:
                                                        constants.appMainColor),
                                              ),
                                            ),
                                            AnimatedAlign(
                                              alignment: messageAlert
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.fastOutSlowIn,
                                              child: Container(
                                                // margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  //Create a switch widget here that takes in a boolean

  switchWidget({required bool specificNotification}) {
    return;
  }
}
