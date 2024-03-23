import 'package:dara_app/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:dara_app/screens/chat/Chat.dart';
import '../../../Firebase/Firebase_service.dart';
import 'package:dara_app/Firebase/Model/User.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/screens/homepage/Account/Posts.dart';
import 'package:dara_app/screens/homepage/Account/Reviews.dart';
import 'package:dara_app/screens/homepage/serviceProviderProfile/serviceProviderOverview.dart';

enum TypeSelected { OVERVIEW, POST, REVIEW }

class ServiceProviderAccount extends StatefulWidget {
  const ServiceProviderAccount({Key? key, required this.user})
      : super(key: key);
  final user;

  @override
  State<ServiceProviderAccount> createState() => _ServiceProviderAccountState();
}

class _ServiceProviderAccountState extends State<ServiceProviderAccount> {
  TypeSelected selected = TypeSelected.OVERVIEW;

  Map? data;

  @override
  void initState() {
    getServiceProvider(widget.user.toString()).then((value) {

      setState(() {
        data = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                                child: data!["banner"] == null
                                    ? Image.asset(
                                        "assets/accBg.png",
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        "${data!["banner"]}",
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
                                              border: Border.all(
                                                  color: Colors.white38)),
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
                                              border: Border.all(
                                                  color: Colors.white38)),
                                          child: Container(
                                              child: Transform.scale(
                                                  scale: 0.5,
                                                  child: SvgPicture.asset(
                                                      "assets/svg/moreWhite.svg")))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  top: MediaQuery.of(context).size.height *
                                      0.23),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        "${data!["profile_image"]}"),
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.white,
                                  ),
                                  InkWell(
                                    onTap: () {
                                  
                                      List<User> users = [
                                        User(
                                            lastMessage: '',
                                            urlAvatar:
                                                "${data!["profile_image"]}",
                                            userMobile: data!["phone"].toString(),
                                            lastMessageTime: DateTime.now(),
                                            idUser:
                                                "${data!["service_provider_id"]}",
                                            name:
                                                '${data!["first_name"]} ${data!["last_name"]}',
                                            read: true,
                                            id: data!["service_provider_id"],
                                            status: true,
                                            docid: data!["service_provider_id"],
                                            fcmToken:
                                                '${data!["fcm_token"].toString()}')
                                      ];

                                      // //----------------------//
                                      FirebaseApi.addUserChat(
                                        token2: device_token,
                                        token: users[0].fcmToken,
                                        urlAvatar2:
                                            provider.client_profile_image,
                                        name2: provider.client_first_name,
                                        recieveruserId2: provider.userType
                                                    .toString() ==
                                                "client"
                                            ? provider.client_user_id.toString()
                                            : provider.sp_user_id.toString(),
                                        recieveruserId: users[0].idUser,
                                        idArtisan: provider.userType
                                                    .toString() ==
                                                "client"
                                            ? provider.client_user_id.toString()
                                            : provider.sp_user_id.toString(),
                                        artisanMobile: provider.userType
                                                    .toString() ==
                                                "client"
                                            ? provider
                                                .value["user_object"]["personal_information"]
                                                    ["phone"]
                                                .toString()
                                            : provider
                                                .value["user_object"]["personal_information"]
                                                    ["phone"]
                                                .toString(),
                                        userMobile: users[0].userMobile,
                                        idUser: users[0].idUser.toString(),
                                        urlAvatar: users[0].urlAvatar,
                                        name: users[0].name,
                                      );
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) {
                                          return ChatPage(
                                              support: true,
                                              newchat: true,
                                              // shipments: e.value,
                                              // pickup: e.value.pickup,
                                              // dropoff: e.value.dropoff,
                                              productSend: true,
                                              user: users[0]);
                                        },
                                      ));

                                      // seperated
                                      // splited
                                    },
                                    child: Container(
                                        height: 40,
                                        width: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: constants.appMainColor,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: SvgPicture.asset(
                                            "assets/svg/message.svg")),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 15, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(data.toString()),
                        Row(
                          children: [
                            Text(
                              "${data!["first_name"]} ${data!["last_name"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            "${data!["kyc"]}".toString() == "approved"
                                ? SvgPicture.asset(
                                    "assets/svg/verified-badge.svg")
                                : Container(),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                onTap: () {
                                
                                  mywidgets.showHireSheet(
                                      context: context,
                                      sp_id: "${data!["service_provider_id"]}",
                                      service:  data!["service"]??"");
                                  // sendNotification(
                                  //     title: "Dara message",
                                  //     body: "message",
                                  //     token:
                                  //         "c4twC7NGRP6lZ5ELH0_czu:APA91bEuHSp3mt7aH2rvnVMnCxDGOD-vg1SajiLwTPl2rhI6xaJ31fOKYYnLvRqkHxIQmvtUVpwwf7hMSa35RrbzeqikhihGH0vTvOEhDj8YhRUrDNRZrdLsECIq1Bob1QSVEwekxXcD");
                                },
                                child: Container(
                                  width: 69,
                                  height: 32,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: constants.appMainColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Center(
                                    child: Text(
                                      "Hire me",
                                      style: TextStyle(
                                          color: constants.appMainColor,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    "assets/svg/trustedProRanking.svg"),
                                Text(
                                  " Trusted Pro",
                                  style: TextStyle(
                                      color: Color(0xFF22C55E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                )
                              ],
                            ),
                            height: 24,
                            width: 84,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF22C55E)),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: "${data!["service"]}",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                          TextSpan(
                            text: " ${data!["skills"]}",
                            style: TextStyle(
                                fontSize: 13, color: constants.appMainColor),
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
                              "${data!["projects_completed"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Completed Projects",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
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
                              "${data!["rating"]}/5.0",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Client Ratings",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
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
                              "${data!["projects_completed"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Recommended",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
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
                                        },
                                        child: Center(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: 50,
                                            child: Center(
                                              child: Text("OverView"),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Color(0xFFf3f4f6)),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                      ),
                                selected != TypeSelected.POST
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = TypeSelected.POST;
                                          });
                                        },
                                        child: Center(
                                          child: Container(
                                            child: Center(
                                              child: Text("Posts"),
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Color(0xFFf3f4f6)),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                      ),
                                selected != TypeSelected.REVIEW
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = TypeSelected.REVIEW;
                                          });
                                        },
                                        child: Center(
                                          child: Container(
                                            child: Center(
                                              child: Text("Reviews"),
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Color(0xFFf3f4f6)),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
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
                            margin:
                                EdgeInsets.only(top: 5, left: 15, right: 15),
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
                      ? Overview(data: data)
                      : selected == TypeSelected.POST
                          ? Posts()
                          : Reviews(data!["service_provider_id"])
                ],
              ),
            ),
    );
  }
}
