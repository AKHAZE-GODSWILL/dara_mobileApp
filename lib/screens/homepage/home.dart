import 'dart:convert';
import 'package:dara_app/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:dara_app/Firebase/Utils/Provider.dart';
import 'package:dara_app/screens/homepage/editPost.dart';
import 'package:dara_app/screens/authentication/login.dart';
import 'package:dara_app/screens/homepage/Notification.dart';
import 'package:dara_app/screens/homepage/searchScreen.dart';
import 'package:dara_app/screens/homepage/categoriesPage.dart';
import 'package:dara_app/screens/homepage/categoryDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/wallet.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/shareApp.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/chatHistory.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/daraSupport.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/settingsPage.dart';
import 'package:dara_app/screens/homepage/serviceProviderProfile/ServiceProviderAccount.dart';

List skill = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.userType}) : super(key: key);
  final String userType;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int activeIndex = 0;
  bool isConversations = true;
  bool isDrawerOpened = false;
  // bool isLoading = false;
  List<dynamic> posts = [];
  List<dynamic>? categories;
  ScrollController? scrollController;
  ScrollController? scrollController2;

  sendLocationData() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    sendLocation(latitude: position.latitude, longitude: position.longitude);
  }

  refreshUser() {
    setState(() {
      posts = getX.read((widget.userType == "serviceProvider")
              ? constants.GETX_SP_FEEDS
              : constants.GETX_CLIENT_FEEDS) ??
          [];
      // isLoading = true;
    });

    reloadUserObject().then((value) {
      if (value["status"] == true) {
        setState(() {
          getX.write(
              (widget.userType == "serviceProvider")
                  ? constants.GETX_SP_FEEDS
                  : constants.GETX_CLIENT_FEEDS,
              value["user_object"]["posts"]);
          posts = value["user_object"]["posts"];
        });
      } else if (value["status"] == "Network Error") {
        mywidgets.displayToast(
            msg: "Network Error. Check your Network Connection and try again");
      } else {
        mywidgets.displayToast(msg: value["message"]);
      }

      setState(() {
        // isLoading = false;
      });
    });
  }

  List? notification;
  var user_object;

  @override
  void initState() {
    DataProvider provider = Provider.of<DataProvider>(context, listen: false);
    reloadUserObject().then((value) {
      setState(() {
        user_object = value;
      });
      if ((provider.userType == "serviceProvider")) {
        provider.set_sp_login_info(
            value: value,
            firstName: value["user_object"]["personal_information"]
                ["first_name"],
            lastName: value["user_object"]["personal_information"]["last_name"],
            email: value["user_object"]["personal_information"]["email"],
            id: value["user_object"]["personal_information"]["id"].toString(),
            access_token: value["access_token"],
            profile_image: (value["user_object"]["address_information"] != null)
                ? value["user_object"]["address_information"]["profile_image"]
                : "");
      } else {
        provider.set_client_login_info(
            value: value,
            firstName: value["user_object"]["personal_information"]
                ["first_name"],
            lastName: value["user_object"]["personal_information"]["last_name"],
            email: value["user_object"]["personal_information"]["email"],
            id: value["user_object"]["personal_information"]["id"].toString(),
            access_token: value["access_token"],
            profile_image: (value["user_object"]["address_information"] != null)
                ? value["user_object"]["address_information"]["profile_image"]
                : "");
      }
    });

    getCategories().then((value) {
      setState(() {
        for (var i in value) {
          skill.add(i["name"]);
        }
      });
    });
    sendUpdatedViews();
    scrollController = ScrollController();
    scrollController2 = ScrollController();
    getNotifications().then((value) {
      print(value);
      if (value.toString() == "false") {
        setState(() {
          notification = [];
        });
      } else {
        setState(() {
          notification = value;
          notification = notification!
              .where((element) => element["status"] == "0")
              .toList();
        });
      }
    });
    sendLocationData();
    refreshUser();
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);
    getCategories().then((value) {
      {
        setState(() {
          categories = value;
          dataProvider.services = value;
          // isLoading = true;
        });
      }
    });

    super.initState();
  }

  bool isItemInView(int index) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    double listViewTop = renderBox.localToGlobal(Offset.zero).dy;
    double listViewBottom =
        renderBox.localToGlobal(Offset(0.0, renderBox.size.height)).dy;

    double itemTop = scrollController!.position.viewportDimension * index / 100;
    double itemBottom =
        scrollController!.position.viewportDimension * (index + 1) / 100;

    // Check if the item is currently in view
    return (itemTop >= listViewTop && itemTop <= listViewBottom) ||
        (itemBottom >= listViewTop && itemBottom <= listViewBottom);
  }

  bool isItemInView2(int index) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    double listViewTop = renderBox.localToGlobal(Offset.zero).dy;
    double listViewBottom =
        renderBox.localToGlobal(Offset(0.0, renderBox.size.height)).dy;

    double itemTop =
        scrollController2!.position.viewportDimension * index / 100;
    double itemBottom =
        scrollController2!.position.viewportDimension * (index + 1) / 100;

    // Check if the item is currently in view
    return (itemTop >= listViewTop && itemTop <= listViewBottom) ||
        (itemBottom >= listViewTop && itemBottom <= listViewBottom);
  }

  List views = [];
  updateList(index) {
    if (!views.contains(index)) {
      views.add(index);
      getX.write("views", views);
    }
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
     
     
     
     
      body: notification == null || user_object == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (posts.length == 0)
              ? Center(child: Text("No Feeds yet"))
              : Column(
                  children: [
                    // Text(provider.value.toString()),
                    SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 8, right: 8),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // Scaffold.of(context).openDrawer();
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child:
                                    // CircleAvatar(
                                    //   radius: 25,
                                    //   backgroundImage: AssetImage("assets/profile.png"),
                                    // ),

                                    CachedNetworkImage(
                                  imageUrl:
                                      (provider.userType == "serviceProvider")
                                          ? provider.sp_profile_image!
                                          : provider.client_profile_image!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.grey),
                                )),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (provider.userType == "serviceProvider")
                                    ? "Hi ${provider.sp_first_name}!"
                                    : "Hi ${provider.client_first_name}!",
                                style: GoogleFonts.inter(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    PhosphorIcons.map_pin,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    "${provider.address}",
                                    style: GoogleFonts.inter(
                                        fontSize: 13, color: Color(0XFF374151)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          (provider.userType == "client")
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return SearchPage();
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
                                      height: 48,
                                      width: 48,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color: Colors.black12)),
                                      child: SvgPicture.asset(
                                          "assets/svg/search.svg"),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return Notifications();
                                      // MainOnboard();
                                      // HomePageWidget();
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
                            child: Stack(
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border:
                                          Border.all(color: Colors.black12)),
                                  child: Icon(
                                    PhosphorIcons.bell,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),
                                notification!.length == 0
                                    ? SizedBox()
                                    : Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Container(
                                          height: 15,
                                          width: 23,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.red,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "${notification!.length}+",
                                            style: GoogleFonts.inter(
                                                color: Colors.white,
                                                fontSize: 9),
                                          )),
                                        ),
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: (provider.userType == "client") ? 5 : 0,
                    ),
                    (provider.userType == "client")
                        ? Stack(
                            children: [
                              Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      !isConversations
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isConversations = true;
                                                });
                                              },
                                              child: Center(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.425,
                                                  height: 50,
                                                  child: Center(
                                                    child: Text("Conversations",
                                                        style:
                                                            GoogleFonts.inter(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      // border: Border.all(
                                                      //     color:
                                                      //         Colors.black12),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: constants
                                                          .appMainColor),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      isConversations
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isConversations = false;
                                                });
                                              },
                                              child: Center(
                                                child: Container(
                                                  child: Center(
                                                    child: Text(
                                                      "Explore",
                                                      style: GoogleFonts.inter(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.425,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      // border: Border.all(
                                                      //     color:
                                                      //         const Color.fromRGBO(0, 0, 0, 0.122)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: constants
                                                          .appMainColor),
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: constants.appMainColor,
                                  ),
                                ),
                              ),
                              AnimatedAlign(
                                alignment: isConversations
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.fastOutSlowIn,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 5, left: 15, right: 15),
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      isConversations
                                          ? "Conversations"
                                          : "Explore",
                                      style: GoogleFonts.inter(
                                          color: constants.appMainColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: (provider.userType == "client") ? 10 : 0,
                    ),
                    (provider.userType == "serviceProvider")
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.746,
                            child: ListView.builder(
                                controller: scrollController2,
                                physics: BouncingScrollPhysics(),
                                itemCount: posts.length,
                                itemBuilder: (context, index) {
                                  // Check if the item is currently in view
                                  bool inView = isItemInView2(index);

                                  updateList(index);
                                  return expandableWidget(postIndex: index);
                                }),
                          )
                        : (isConversations == true)
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.68,
                                child: ListView.builder(
                                    controller: scrollController,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: posts.length,
                                    itemBuilder: (context, index) {
                                      // Check if the item is currently in view
                                      bool inView = isItemInView(index);

                                      updateList(index);
                                      return expandableWidget(postIndex: index);
                                    }),
                              )

                            ////////////////////////////////////////// If the explore option is picked this widget should run
                            /// this widget should contain a carousel that has different Id's
                            /// when ever a carousel is picked, fetch the details from the backend and display.
                            /// Each carousel must have the same specific format
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.68,
                                child: SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      CarouselSlider.builder(
                                        options: CarouselOptions(
                                            height: 134,
                                            autoPlay: true,
                                            autoPlayInterval:
                                                Duration(seconds: 5),
                                            onPageChanged: (index, reason) {
                                              setState(
                                                  () => activeIndex = index);
                                            },
                                            viewportFraction: 1,
                                            enlargeCenterPage: true,
                                            enlargeStrategy:
                                                CenterPageEnlargeStrategy
                                                    .height),
                                        itemCount: 3,
                                        itemBuilder:
                                            (context, index, realIndex) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10, bottom: 5),
                                            child: Container(
                                                height: 134,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    color:
                                                        constants.appMainColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/exploreImage.png"),
                                                        fit: BoxFit.cover)),
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: Container(
                                                          height: 104,
                                                          width: 160,
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Get 20% discount on dry cleaning',
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Text(
                                                                  'First dry cleaning service of the month',
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          8,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    //   Navigator.of(context).push(
                                                                    //   MaterialPageRoute(builder: (context) => ViewOffers())
                                                                    // );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 83,
                                                                    height: 32,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(200)),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Start Now",
                                                                        style: GoogleFonts.inter(
                                                                            color:
                                                                                constants.appMainColor,
                                                                            fontSize: 14),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ])),
                                                    ))),
                                          );
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      buildIndicator(),
                                      SizedBox(height: 20),
                                      Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Top Categories',
                                                    style: GoogleFonts.inter(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0XFF121212)),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          PageRouteBuilder(
                                                            pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) {
                                                              return Categories(
                                                                  categories);
                                                            },
                                                            transitionsBuilder:
                                                                (context,
                                                                    animation,
                                                                    secondaryAnimation,
                                                                    child) {
                                                              return FadeTransition(
                                                                opacity:
                                                                    animation,
                                                                child: child,
                                                              );
                                                            },
                                                          ));
                                                    },
                                                    child: Container(
                                                      child: Text(
                                                        'View All',
                                                        style: GoogleFonts.inter(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0XFF6B7280)),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                            SizedBox(height: 5),
                                            Container(
                                                // height: 210,
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                  categories == null
                                                      ? SizedBox()
                                                      : Wrap(
                                                          // mainAxisAlignment:
                                                          //     MainAxisAlignment
                                                          //         .spaceBetween,
                                                          children: [
                                                              ...categories!
                                                                  .map(
                                                                (e) => customCategoryButton(
                                                                    category:
                                                                        "${e["name"]}",
                                                                    svgImage:
                                                                        "${e["icon"]}"),
                                                              )
                                                            ]),
                                                ])),
                                            SizedBox(height: 40),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Top Rated Service Providers',
                                                      style: GoogleFonts.inter(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0XFF121212)),
                                                    ),
                                                    Text(
                                                      'See All',
                                                      style: GoogleFonts.inter(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0XFF6B7280)),
                                                    ),
                                                  ]),
                                            ),
                                            ListView.builder(
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: provider.value[
                                                              "user_object"][
                                                          "top_rated_service_providers"] ==
                                                      null
                                                  ? 0
                                                  : provider
                                                      .value["user_object"][
                                                          "top_rated_service_providers"]
                                                      .length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, bottom: 8),
                                                  child: Container(
                                                    height: 75,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 2,
                                                          color:
                                                              Color(0XFFE5E7EB),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 8.0),
                                                            child: CircleAvatar(
                                                              radius: 25,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                "${provider.value["user_object"]["top_rated_service_providers"][index]["profile_image"]}",
                                                              ),
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${provider.value["user_object"]["top_rated_service_providers"][index]["service"]}",
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    PhosphorIcons
                                                                        .star_fill,
                                                                    color: Colors
                                                                        .orangeAccent,
                                                                    size: 13,
                                                                  ),
                                                                  Text(
                                                                    "${provider.value["user_object"]["top_rated_service_providers"][index]["rating"]}",
                                                                    style: GoogleFonts.inter(
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0XFF6B7280)),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          4.2,
                                                                      width:
                                                                          4.2,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        color: Color(
                                                                            0XFF6B7280),
                                                                      ),
                                                                      child: Text(
                                                                          ""),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "${provider.value["user_object"]["top_rated_service_providers"][index]["service"]}",
                                                                    style: GoogleFonts.inter(
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0XFF6B7280)),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                    child: Text(
                                                                      "${provider.value["user_object"]["recommendation"].length} Recommended",
                                                                      style: GoogleFonts.inter(
                                                                          fontSize:
                                                                              8,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Color(0XFF6B7280)),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            4.0),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          4.2,
                                                                      width:
                                                                          4.2,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        color: Color(
                                                                            0XFF6B7280),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                    child: Text(
                                                                      "0 Completed Projects",
                                                                      style: GoogleFonts.inter(
                                                                          fontSize:
                                                                              8,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Color(0XFF6B7280)),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                              
                                                                mywidgets.showHireSheet(
                                                                    context:
                                                                        context,
                                                                    sp_id:
                                                                        "${provider.value["user_object"]["top_rated_service_providers"][index]["service_provider_id"]}",
                                                                    service:
                                                                        provider.value["user_object"]["top_rated_service_providers"][index]["service"]??"");
                                                              },
                                                              child: Container(
                                                                width: 69,
                                                                height: 32,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: constants
                                                                            .appMainColor,
                                                                        width:
                                                                            2),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            200)),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Hire me",
                                                                    style: GoogleFonts.inter(
                                                                        color: constants
                                                                            .appMainColor,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ]))
                                    ],
                                  ),
                                ),
                              )
                  ],
                ),
    );
  }

  customCategoryButton(
      {required String category, required String svgImage, Function? action}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return CategoryDetails(title: category);
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
      child: Container(
          margin: EdgeInsets.only(left: 7, right: 7, bottom: 10, top: 10),
          height: 96,
          width: 104,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0XFFE5E7EB), width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0XFFEAF1FF),
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 2, color: constants.appMainColor)),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(svgImage),
                  ),
                ),
                Text(
                  category,
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF121212)),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 3,
        effect: WormEffect(
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: constants.appMainColor,
            dotColor: Colors.black12),
      );

  Widget expandableWidget({required postIndex}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0, bottom: 8),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                          onTap: () {
                            Map<dynamic, dynamic> user = {
                              "first_name": posts[postIndex]["author_name"],
                              "last_name": "",
                              "user_id": posts[postIndex]["user_id"],
                              "data": posts[postIndex],
                            };
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ServiceProviderAccount(
                                            user: posts[postIndex]
                                                ["user_id"])));
                          },
                          child: CachedNetworkImage(
                            imageUrl: posts[postIndex]["author_image"],
                            imageBuilder: (context, imageProvider) => Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => Icon(Icons.person,
                                size: 50, color: Colors.grey),
                            errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey),
                          )),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              posts[postIndex]["author_name"],
                              style: GoogleFonts.inter(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            "${posts[postIndex]["kyc"]}".toString() ==
                                    "approved"
                                ? SvgPicture.asset(
                                    "assets/svg/verified-badge.svg")
                                : Container(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              PhosphorIcons.star_fill,
                              color: Colors.orangeAccent,
                              size: 13,
                            ),
                            Text(
                              "${posts[postIndex]["service_provider_rating"]}",
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: Color(0XFF6B7280)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 4.2,
                                width: 4.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0XFF6B7280),
                                ),
                                child: Text(""),
                              ),
                            ),
                            Text(
                              "${posts[postIndex]["service"]}",
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: Color(0XFF6B7280)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            "${GetTimeAgo.parse(DateTime.parse(posts[postIndex]["created_at"]))}",
                            style: GoogleFonts.inter(
                                fontSize: 12, color: Color(0XFF6B7280)),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    SvgPicture.asset("assets/svg/more.svg")
                  ],
                ),
              ),
              // Text(posts[postIndex].toString()),
              Container(
                  // width: MediaQuery.of(context).size.width*0.72,
                  alignment: Alignment.topLeft,
                  child: ReadMoreText(
                    posts[postIndex]["body"],
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                    trimCollapsedText: "See More",
                    textAlign: TextAlign.start,
                    trimExpandedText: "See Less",
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    callback: (val) {},
                  )),
              (posts[postIndex]["media"] == "null" ||
                      posts[postIndex]["media"] == "[]")
                  ? SizedBox()
                  : categorizePost(posts[postIndex]["media"]) == "image"
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 290,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Builder(
                                builder: (BuildContext context) {
                                  return CachedNetworkImage(
                                    imageUrl: json.decode(posts[postIndex]
                                            ["media"]
                                        .toString()
                                        .replaceAll('\\', ''))[0],
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 290,
                                      decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    // placeholder: (context, url) => Container(
                                    //   width: 60,
                                    //   height: 60,
                                    //   child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.grey),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      : Builder(builder: (context) {
                          Future<dynamic> generateVideoThumbnail(
                              String videoPath) async {
                            final thumbnail =
                                await VideoThumbnail.thumbnailData(
                              video: videoPath,
                              imageFormat: ImageFormat.PNG,
                              maxWidth: 200, // Adjust the width as needed
                              quality:
                                  100, // Adjust the quality (0 - 100) as needed
                            );
                            return thumbnail;
                          }

                          return FutureBuilder<dynamic>(
                            future: generateVideoThumbnail(json.decode(
                                posts[postIndex]["media"]
                                    .toString()
                                    .replaceAll('\\', ''))[0]),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                final image = Image.memory(snapshot.data!);
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditPost(
                                                  mediaType: "video",
                                                  mediaPath: json.decode(
                                                      posts[postIndex]["media"]
                                                          .toString()
                                                          .replaceAll(
                                                              '\\', ''))[0],
                                                  type: "video",
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 290,
                                      decoration: BoxDecoration(),
                                      child: Stack(
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 290,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                    image: image.image,
                                                    fit: BoxFit.cover),
                                              )),
                                          Center(
                                            child: Icon(
                                              Icons.play_circle,
                                              size: 50,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Center(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    // child: CircularProgressIndicator()
                                  ),
                                ); // You can display a loading indicator here.
                              }
                            },
                          );
                        }),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(onTap: () {
                      print(posts[postIndex]["status_id"]);
                      DataProvider provider =
                          Provider.of<DataProvider>(context, listen: false);
                      GetStorage box = GetStorage();
                      var recentList = box.read("like") ?? [];
                      if (recentList.contains(
                          "${posts[postIndex]["id"]}-${(provider.userType == "serviceProvider" ? provider.sp_user_id : provider.client_user_id)}")) {
                        // unlikePost(status_id: posts[postIndex]["status_id"]);
                        setState(() {
                          recentList.remove(
                              "${posts[postIndex]["id"]}-${(provider.userType == "serviceProvider" ? provider.sp_user_id : provider.client_user_id)}");
                          box.write(
                              "like", recentList == null ? [] : (recentList));

                          posts[postIndex]["liked"] = null;
                        });
                      } else {
                        likePost(status_id: posts[postIndex]["status_id"]);
                        setState(() {
                          box.write(
                              "like",
                              recentList == null
                                  ? [
                                      "${posts[postIndex]["id"]}-${(provider.userType == "serviceProvider" ? provider.sp_user_id : provider.client_user_id)}"
                                    ]
                                  : (recentList +
                                      [
                                        "${posts[postIndex]["id"]}-${(provider.userType == "serviceProvider" ? provider.sp_user_id : provider.client_user_id)}"
                                      ]));

                          posts[postIndex]["liked"] = true;
                        });
                      }
                    }, child: Builder(builder: (context) {
                      GetStorage box = GetStorage();
                      DataProvider provider =
                          Provider.of<DataProvider>(context, listen: false);
                      var recentList = box.read("like") ?? [];
                      return Row(
                        children: [
                          posts[postIndex]["liked"] == null &&
                                  !recentList.contains(
                                      "${posts[postIndex]["id"]}-${(provider.userType == "serviceProvider" ? provider.sp_user_id : provider.client_user_id)}")
                              ? Icon(PhosphorIcons.heart, color: Colors.black)
                              : Icon(PhosphorIcons.heart_fill,
                                  color: constants.appMainColor),
                          Builder(builder: (context) {
                            int count = int.parse(
                                "${posts[postIndex]["liked"] == null && !recentList.contains("${posts[postIndex]["id"]}-${(provider.userType == "serviceProvider" ? provider.sp_user_id : provider.client_user_id)}") ? 0 : 1}");
                            return Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                "${(int.parse(posts[postIndex]["likes"]) + int.parse(count.toString()))}",
                                style: GoogleFonts.inter(
                                    fontSize: 13, color: Colors.black),
                              ),
                            );
                          }),
                        ],
                      );
                    })),
                    Row(
                      children: [
                        Icon(
                          PhosphorIcons.eye,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            "${posts[postIndex]["views"]}",
                            style: GoogleFonts.inter(
                                fontSize: 13, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Share.share("${posts[postIndex]["body"]}");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset("assets/svg/share.svg"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }

//  void justPlaying(){

//   }
}
