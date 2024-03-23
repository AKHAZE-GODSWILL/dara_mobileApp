import '../../main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dara_app/widget/custom_circle.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/screens/homepage/viewOffers.dart';
import 'package:dara_app/screens/authentication/login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/wallet.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/shareApp.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/chatHistory.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/daraSupport.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/settingsPage.dart';


// import 'package:flutter_ph/**/osphor_icons/flutter_phosphor_icons.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key, required this.userType}) : super(key: key);

  final userType;
  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List? offers;
  bool isLoading = false;

  makeOfferRequest() {
    // mywidgets.displayToast(msg: "In the Make offer method and the user type is ${widget.userType}");

    // DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    setState(() {
      isLoading = true;
    });
    DataProvider dataProvider = Provider.of(context, listen: false);

    // (widget.userType == "serviceProvider")
    // ?
    getOffers(context).then((value) {
    

      if (value["status"] == true) {
        setState(() {
          offers = value["data"];
        });
      } else if (value["status"] == "Network Error") {
        mywidgets.displayToast(
            msg: "Network Error. Check your Network Connection and try again");
      } else {
        offers = [];
        mywidgets.displayToast(msg: value["message"]);
      }

      setState(() {
        isLoading = false;
      });
    });
    // : ();
  }

  void refreshOfferPage({required offerIndex}) {
    // mywidgets.displayToast(msg: "Offer Index initiated");
    setState(() {
      offers!.removeAt(offerIndex);
    });
  }

  @override
  initState() {
    makeOfferRequest();
    // mywidgets.displayToast(msg: "After the make offer method in the initstate");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    // color: Colors.blue,
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: (provider.userType == "serviceProvider")
                          ? provider.sp_profile_image!
                          : provider.client_profile_image!,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.person, size: 50, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Text(
                          (provider.userType == "serviceProvider")
                              ? "${provider.sp_first_name} ${provider.sp_last_name}"
                              : "${provider.client_first_name} ${provider.client_last_name}",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        "${provider.value["user_object"]["personal_information"]["kyc"]}"
                                    .toString() ==
                                "approved"
                            ? SvgPicture.asset("assets/svg/verified-badge.svg")
                            : Container()
                      ],
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/svg/ranking.svg"),
                          Text(
                            " Rising Star",
                            style: GoogleFonts.inter(
                                color: Color(0xFFf97315),
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          )
                        ],
                      ),
                      height: 24,
                      width: 85,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFf97315)),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        if (provider.userType == "serviceProvider") {
                          provider.setUserType(userTier: "client");
                        } else {
                          provider.setUserType(userTier: "serviceProvider");
                        }

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Login()),
                          (route) => false,
                        );
                      },
                      child: Text(
                        (provider.userType == "serviceProvider")
                            ? "Use Dara as client"
                            : "Use Dara as a Service Provider",
                        style: GoogleFonts.inter(
                            color: constants.appMainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ],
                )),
            ListTile(
              leading: SvgPicture.asset("assets/svg/wallet.svg"),
              title: Text(
                  (provider.userType == "serviceProvider")
                      ? 'Wallet'
                      : 'Wallet (Available Soon)',
                  style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              onTap: () {
                (provider.userType == "serviceProvider")
                    ? Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return WalletPage();
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ))
                    : ();
              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/svg/chat-history.svg"),
              title: Text('Chat History',
                  style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              onTap: () {
                // Navigator.pop(context); // Close the drawer
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return ChatHistory();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ));
              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/svg/settings.svg"),
              title: Text('Settings',
                  style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return Settings();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ));
              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/svg/support.svg"),
              title: Text('Support',
                  style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              onTap: () async {
                // Add your settings page navigation logic here
                Future<void> _launchUrl() async {
                  final Uri _url =
                      Uri.parse('https://wa.me/message/MX5JENZMK2BBI1');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                }

                _launchUrl();
                // Navigator.push(
                //     context,
                //     PageRouteBuilder(
                //       pageBuilder: (context, animation, secondaryAnimation) {
                //         return DaraSupport();
                //       },
                //       transitionsBuilder:
                //           (context, animation, secondaryAnimation, child) {
                //         return FadeTransition(
                //           opacity: animation,
                //           child: child,
                //         );
                //       },
                //     ));
              },
            ),
            Divider(),
            ListTile(
              leading: SvgPicture.asset("assets/svg/share.svg"),
              title: Text('Share the App',
                  style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              onTap: () {
                Future<void> _launchUrl() async {
                  final Uri _url = Uri.parse('https://usedara.com/');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                }

                _launchUrl();
                // Navigator.push(
                //     context,
                //     PageRouteBuilder(
                //       pageBuilder: (context, animation, secondaryAnimation) {
                //         return ShareApp();
                //       },
                //       transitionsBuilder:
                //           (context, animation, secondaryAnimation, child) {
                //         return FadeTransition(
                //           opacity: animation,
                //           child: child,
                //         );
                //       },
                //     ));
              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/svg/about-us.svg"),
              title: Text('About Us',
                  style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              onTap: () {
                // https://usedara.com/about-us
                Future<void> _launchUrl() async {
                  final Uri _url = Uri.parse('https://usedara.com/about-us');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                }

                _launchUrl();

                // Add your settings page navigation logic here
                // Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/svg/logout.svg"),
              title: Text('Log Out',
                  style: GoogleFonts.inter(
                      fontSize: 12, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => Login()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: (isLoading)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ],
              )
            : offers!.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                      Center(
                        child: Text(
                          "No offers Found",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                    ],
                  )
                :
                
                
                 Column(
                    children: [
                      SizedBox(height: 19),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Offers",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                // Scaffold.of(context).openDrawer();
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              child: Stack(
                                children: [
                                  Container(
                                      height: 42,
                                      width: 42,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color: Colors.black12)),
                                      child: Container(
                                          child: Transform.scale(
                                              scale: 0.5,
                                              child: SvgPicture.asset(
                                                  "assets/svg/more.svg")))),
                                  Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Container(
                                      height: 15,
                                      width: 23,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "9+",
                                        style: GoogleFonts.inter(
                                            color: Colors.white, fontSize: 13),
                                      )),
                                    ),
                                  ),
                                ],
                              ),

                              // Container(
                              //     height: 42,
                              //     width: 42,
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(100),
                              //         border: Border.all(color: Colors.black12)),
                              //     child:

                              //     Container(
                              //         child: Transform.scale(
                              //             scale: 0.5,
                              //             child: SvgPicture.asset("assets/svg/more.svg")))),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: offers!.length,
                          itemBuilder: (context, index) {
                            return (provider.userType == "serviceProvider")
                                ? serviceProviderOfferWidget(index: index)
                                : clientOfferWidget(index: index);
                          })
                    ],
                  ),
     
     
     
      ),
    );
  }

  Widget serviceProviderOfferWidget({required index}) {
    return Column(
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
                          CachedNetworkImage(
                            imageUrl: offers![index]["sender_profile_image"]??'',
                            imageBuilder: (context, imageProvider) => Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.person,
                                    size: 50, color: Colors.grey)),
                            errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 32),
                            child: Container(
                              child: Text(""),
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  color: Colors.green),
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
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: offers![index]["sender"]??"",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text:
                                  "\t sent a request to hire your services for a project",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            )
                          ])),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                             "${GetTimeAgo.parse(DateTime.parse(offers![index]["created_at"]))}",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.125,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return ViewOffers(
                                offerDetail: offers![index],
                                refreshOfferPage: refreshOfferPage,
                                offerIndex: index,
                              );
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ));
                    },
                    child: Container(
                      width: 88,
                      height: 32,
                      decoration: BoxDecoration(
                          color: constants.appMainColor,
                          borderRadius: BorderRadius.circular(200)),
                      child: Center(
                        child: Text(
                          "View Details",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: InkWell(
                      onTap: () {
                        circularCustom(context);
                        acceptOffers(offer_id: offers![index]["offer_id"]??"")
                            .then((value) {
                          // mywidgets.displayToast(msg: "making the request");

                          if (value["status"] == "true") {
                            Navigator.pop(context);
                            setState(() {
                              // refreshOfferPage(offerIndex: index);
                              offers!.removeAt(index);

                              CustomSuccessDialog();
                            });
                          } else if (value["status"] == "Network Error") {
                            Navigator.pop(context);
                            mywidgets.displayToast(
                                msg:
                                    "Network Error. Check your Network Connection and try again");
                          } else {
                            Navigator.pop(context);
                            mywidgets.displayToast(msg: value["message"]??"");
                          }

                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      child: Container(
                        width: 88,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: constants.appMainColor, width: 2),
                            borderRadius: BorderRadius.circular(200)),
                        child: Center(
                          child: Text(
                            "Accept",
                            style: TextStyle(
                                color: constants.appMainColor, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: InkWell(
                      onTap: () {
                        circularCustom(context);
                        rejectOffers(offer_id: offers![index]["offer_id"]??"")
                            .then((value) {
                          // mywidgets.displayToast(msg: "making the request");

                          if (value["status"] == true) {
                            Navigator.pop(context);
                            setState(() {
                              // refreshOfferPage(offerIndex: index);
                              offers!.removeAt(index);
                              CustomAcknowledgedDialog();
                            });
                          } else if (value["status"] == "Network Error") {
                            Navigator.pop(context);
                            mywidgets.displayToast(
                                msg:
                                    "Network Error. Check your Network Connection and try again");
                          } else {
                            Navigator.pop(context);
                            mywidgets.displayToast(msg: value["message"]??"");
                          }

                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      child: Container(
                        width: 88,
                        height: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200)),
                        child: Center(
                          child: Text(
                            "Decline",
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Divider(),
        )
      ],
    );
  }

  Widget clientOfferWidget({required index}) {
    return Column(
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
                          CachedNetworkImage(
                            imageUrl: offers![index]["service_provider_profile_image"]??"",
                            imageBuilder: (context, imageProvider) => Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                                width: 60,
                                height: 60,
                                child: Icon(Icons.person,
                                    size: 50, color: Colors.grey)),
                            errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 32),
                            child: Container(
                              child: Text(""),
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  color: Colors.green),
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
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: (index % 2 == 0)
                              ? RichText(
                                  text: TextSpan(children: [
                                  TextSpan(
                                    text: "You sent a request to hire ",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "${offers![index]["service_provider_name"]??""} ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "services for a project",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                ]))
                              : RichText(
                                  text: TextSpan(children: [
                                  TextSpan(
                                    text: "${offers![index]["service_provider_name"]??""} ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text:
                                        "sent a request to confirm that your project was completed",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  )
                                ])),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            "${GetTimeAgo.parse(DateTime.parse(offers![index]["created_at"]))}",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.125,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return ViewOffers(
                                offerDetail: offers![index],
                                refreshOfferPage: refreshOfferPage,
                                offerIndex: index,
                              );
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ));
                    },
                    child: Container(
                      width: 139,
                      height: 32,
                      decoration: BoxDecoration(
                          color: constants.appMainColor,
                          borderRadius: BorderRadius.circular(200)),
                      child: Center(
                        child: Text(
                          "View Details",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  // (index % 2 == 0)
                  //     ? Padding(
                  //         padding: const EdgeInsets.only(left: 10.0),
                  //         child: InkWell(
                  //           onTap: () {

                  //           },
                  //           child: Container(
                  //             width: 139,
                  //             height: 32,
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 border: Border.all(
                  //                     color: constants.appMainColor, width: 2),
                  //                 borderRadius: BorderRadius.circular(200)),
                  //             child: Center(
                  //               child: Text(
                  //                 "Confirm",
                  //                 style: TextStyle(
                  //                     color: constants.appMainColor,
                  //                     fontSize: 14),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     : Container()
              
              
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Divider(),
        )
      ],
    );
  }

  ////////////////// Success Dialog
  CustomSuccessDialog() {
    return showDialog(
        barrierColor: Color(0XFF121212).withOpacity(0.7),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.9,
                    // height: 338,
                    // width: 320,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 105,
                          width: 105,
                          decoration: BoxDecoration(
                              color: Color(0XFF22C55E), shape: BoxShape.circle),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 80,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Confirmed",
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Project hire has been Accepted",
                          style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: Color(0XFF374151),
                              decoration: TextDecoration.none),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 50,
                              decoration: BoxDecoration(
                                  // color: (_textEditingController!.text.isEmpty)? Color(0XFFF3F4F6): constants.appMainColor,
                                  color: constants.appMainColor,
                                  borderRadius: BorderRadius.circular(200)),
                              child: Center(
                                child: Text(
                                  "Done",
                                  style: GoogleFonts.inter(
                                      // color: (_textEditingController!.text.isEmpty)? Color(0XFF6B7280):Colors.white,
                                      color: Colors.white,
                                      fontSize: 14,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  /////////////////// Acknowledged dialogue
  CustomAcknowledgedDialog() {
    return showDialog(
        barrierColor: Color(0XFF121212).withOpacity(0.7),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.9,
                    // height: 338,
                    // width: 320,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 105,
                          width: 105,
                          child: Center(
                              child: SvgPicture.asset(
                                  "assets/svg/acknowledged.svg")),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Acknowledged",
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Project hire has been declined",
                          style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: Color(0XFF374151),
                              decoration: TextDecoration.none),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 50,
                              decoration: BoxDecoration(
                                  // color: (_textEditingController!.text.isEmpty)? Color(0XFFF3F4F6): constants.appMainColor,
                                  color: constants.appMainColor,
                                  borderRadius: BorderRadius.circular(200)),
                              child: Center(
                                child: Text(
                                  "Done",
                                  style: GoogleFonts.inter(
                                      // color: (_textEditingController!.text.isEmpty)? Color(0XFF6B7280):Colors.white,
                                      color: Colors.white,
                                      fontSize: 14,
                                      decoration: TextDecoration.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}
