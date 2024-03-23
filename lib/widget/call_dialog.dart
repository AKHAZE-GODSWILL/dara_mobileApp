import 'package:flutter/material.dart';
import 'package:dara_app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/callsScreen.dart';

callDialog({context, target_id, target_name, target_img, phone}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (builder) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          child: AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: new StatefulBuilder(builder: (context, setState) {
              return new Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    child: Container(
                      color: Colors.transparent,
                      height: 260,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40)),
                                  color: Colors.white),
                              height: 350.0,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // SizedBox(
                                        //   width: MediaQuery.of(context).size.width*0.3,
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 25.0,
                                          ),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                              'Contact Options',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, left: 10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Text(
                                        'Carrier rates may apply. call via direct call',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       top: 10.0, left: 20, right: 20),
                                  //   child: ElevatedButton(
                                  //     style: ButtonStyle(
                                  //         backgroundColor:
                                  //             MaterialStateProperty.all(
                                  //                 Constants().appMainColor),
                                  //         shape: MaterialStateProperty.all<
                                  //                 RoundedRectangleBorder>(
                                  //             RoundedRectangleBorder(
                                  //           borderRadius:
                                  //               BorderRadius.circular(54.0),
                                  //         ))),
                                  //     child: Container(
                                  //       width: 250,
                                  //       height: 55,
                                  //       alignment: Alignment.center,
                                  //       decoration: BoxDecoration(
                                  //           borderRadius:
                                  //               BorderRadius.circular(40)),
                                  //       child: Text(
                                  //         'CALL IN-APP',
                                  //         style: TextStyle(color: Colors.white),
                                  //       ),
                                  //     ),
                                  //     onPressed: () {
                                  //       Navigator.pop(context);
                                  //       Navigator.push(
                                  //           context,
                                  //           PageRouteBuilder(
                                  //             pageBuilder: (context, animation,
                                  //                 secondaryAnimation) {
                                  //               return CallsScreen(
                                  //                   target_id: target_id,
                                  //                   target_name: target_name,
                                  //                   target_img: target_img);
                                  //             },
                                  //             transitionsBuilder: (context,
                                  //                 animation,
                                  //                 secondaryAnimation,
                                  //                 child) {
                                  //               return FadeTransition(
                                  //                 opacity: animation,
                                  //                 child: child,
                                  //               );
                                  //             },
                                  //           ));
                                  //     },
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, left: 20, right: 20),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Constants().appMainColor),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(54.0),
                                          ))),
                                      child: Container(
                                        width: 250,
                                        height: 55,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Text(
                                          'CALL BY PHONE',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);

                                        final Uri _url =
                                            Uri.parse("tel:${phone}");
                                        Future<void> _launchUrl() async {
                                          if (!await launchUrl(_url)) {
                                            throw Exception(
                                                'Could not launch $_url');
                                          }
                                        }

                                        _launchUrl();
                                      },
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
            }),
          ),
        );
      });
}
