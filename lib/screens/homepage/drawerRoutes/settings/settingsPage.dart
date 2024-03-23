import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/screens/authentication/selectTier.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/wallet.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/aboutMe.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/getVerified.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/businnesInfo.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/personalInfo.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/loginSettings.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/withDrawalAccount.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/notificationSettings.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Text("")),
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
                    "Settings",
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
                          "Profile",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        (provider.userType == "serviceProvider")
                            ? Container(
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return PersonalInfo();
                                              },
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ));
                                      },
                                      child: Container(
                                          height: 32,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Personal Information",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Icon(Icons.arrow_forward_ios)
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return BusinessInfo();
                                              },
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ));
                                      },
                                      child: Container(
                                          height: 32,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Business Information",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Icon(Icons.arrow_forward_ios)
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return AboutMe();
                                              },
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ));
                                      },
                                      child: Container(
                                          height: 32,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("About me",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Icon(Icons.arrow_forward_ios)
                                            ],
                                          )),
                                    ),
                                    Divider()
                                  ],
                                ),
                              )
                            : Container(
                                height: 80,
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return PersonalInfo();
                                              },
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ));
                                      },
                                      child: Container(
                                          height: 32,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Personal Information",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Icon(Icons.arrow_forward_ios)
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                        SizedBox(height: 20),
                        Text("Security & Verification",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        (provider.userType == "serviceProvider")
                            ? Container(
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return LoginSettings();
                                              },
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ));
                                      },
                                      child: Container(
                                          height: 32,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Login Settings",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Icon(Icons.arrow_forward_ios)
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return GetVerified();
                                              },
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ));
                                      },
                                      child: Container(
                                          height: 32,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Get Verified",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Icon(Icons.arrow_forward_ios)
                                            ],
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return WalletPage();
                                              },
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ));
                                      },
                                      child: Container(
                                          height: 32,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Withdrawal account",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Icon(Icons.arrow_forward_ios)
                                            ],
                                          )),
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.push(
                                    //         context,
                                    //         PageRouteBuilder(
                                    //           pageBuilder: (context, animation,
                                    //               secondaryAnimation) {
                                    //             return NotificationSettings();
                                    //           },
                                    //           transitionsBuilder: (context,
                                    //               animation,
                                    //               secondaryAnimation,
                                    //               child) {
                                    //             return FadeTransition(
                                    //               opacity: animation,
                                    //               child: child,
                                    //             );
                                    //           },
                                    //         ));
                                    //   },
                                    //   child: Container(
                                    //       height: 32,
                                    //       width:
                                    //           MediaQuery.of(context).size.width,
                                    //       child: Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.spaceBetween,
                                    //         children: [
                                    //           Text("Notification",
                                    //               style: TextStyle(
                                    //                   fontSize: 12,
                                    //                   fontWeight:
                                    //                       FontWeight.bold)),
                                    //           Icon(Icons.arrow_forward_ios)
                                    //         ],
                                    //       )),
                                    // ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Divider(),
                                  ],
                                ),
                              )
                            : Container(
                                // color: Colors.red,
                                height: 150,
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return LoginSettings();
                                              },
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ));
                                      },
                                      child: Container(
                                          height: 32,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Login Settings",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Icon(Icons.arrow_forward_ios)
                                            ],
                                          )),
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Navigator.push(
                                    //         context,
                                    //         PageRouteBuilder(
                                    //           pageBuilder: (context, animation,
                                    //               secondaryAnimation) {
                                    //             return NotificationSettings();
                                    //           },
                                    //           transitionsBuilder: (context,
                                    //               animation,
                                    //               secondaryAnimation,
                                    //               child) {
                                    //             return FadeTransition(
                                    //               opacity: animation,
                                    //               child: child,
                                    //             );
                                    //           },
                                    //         ));
                                    //   },
                                    //   child: Container(
                                    //       height: 32,
                                    //       width:
                                    //           MediaQuery.of(context).size.width,
                                    //       child: Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.spaceBetween,
                                    //         children: [
                                    //           Text("Notification",
                                    //               style: TextStyle(
                                    //                   fontSize: 12,
                                    //                   fontWeight:
                                    //                       FontWeight.bold)),
                                    //           Icon(Icons.arrow_forward_ios)
                                    //         ],
                                    //       )),
                                    // ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Divider(),
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Personal",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          // height: 180,
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
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // InkWell(
                              //   onTap: () {
                              //     //  Navigator.push(
                              //     //   context,
                              //     //   PageRouteBuilder(
                              //     //     pageBuilder: (context, animation, secondaryAnimation) {
                              //     //       return Settings();
                              //     //     },
                              //     //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              //     //       return FadeTransition(
                              //     //         opacity: animation,
                              //     //         child: child,
                              //     //       );
                              //     //     },
                              //     //   )
                              //     // );
                              //   },
                              //   child: Container(
                              //       height: 32,
                              //       width: MediaQuery.of(context).size.width,
                              //       child: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Text("Close account",
                              //               style: TextStyle(
                              //                   fontSize: 12,
                              //                   fontWeight: FontWeight.bold)),
                              //           Icon(Icons.arrow_forward_ios)
                              //         ],
                              //       )),
                              // ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // Divider(),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              InkWell(
                                onTap: () {
                                   Navigator.pushAndRemoveUntil(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return SelectTier();
                                      },
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                    ),
                                     (route) => false,
                                  );
                                },
                                child: Container(
                                    height: 32,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Log out",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "Version 8.0.3",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
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
}
