import 'package:dara_app/Firebase/Model/User.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/main.dart';
import 'package:dara_app/screens/chat/Chat.dart';
import 'package:dara_app/screens/homepage/serviceProviderProfile/serviceProviderOverview.dart';
import 'package:dara_app/screens/homepage/serviceProviderProfile/serviceProviderPosts.dart';
import 'package:dara_app/screens/homepage/serviceProviderProfile/serviceProviderReviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../Firebase/Firebase_service.dart';

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

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: MediaQuery.of(context).size.height * 0.23),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage("assets/profile1.png"),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.white,
                            ),
                            InkWell(
                              onTap: () {
                                print(
                                    "'${widget.user["first_name"]} ${widget.user["last_name"]}'");
                                List<User> users = [
                                  User(
                                    lastMessage: '',
                                    urlAvatar: "",
                                    userMobile: "",
                                    lastMessageTime: DateTime.now(),
                                    idUser: widget.user["user_id"],
                                    name:
                                        '${widget.user["first_name"]} ${widget.user["last_name"]}',
                                    read: true,
                                    id: widget.user["user_id"],
                                    status: true,
                                    docid: widget.user["user_id"],
                                  )
                                ];

                                FirebaseApi.addUserChat(
                                  // shipment: e.value,
                                  token2: 'data.fcmToken',
                                  token: 'snapshot.data[index].fcmToken',
                                  urlAvatar2: provider.client_profile_image,
                                  name2: provider.client_first_name,
                                  recieveruserId2: provider.client_user_id,
                                  recieveruserId: users[0].idUser,
                                  idArtisan: provider.client_user_id.toString(),
                                  artisanMobile: provider.client_phone,
                                  userMobile: users[0].userMobile,
                                  idUser: users[0].idUser.toString(),
                                  urlAvatar: users[0].urlAvatar,
                                  name: users[0].name,
                                );
                                Navigator.of(context).push(MaterialPageRoute(
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

                                // User user = User(
                                //     name: '${widget.user["first_name"]} ${widget.user["last_name"]}',
                                //     lastMessage: '',
                                //     urlAvatar: '',
                                //   idUser: provider.client_user_id,
                                //   id: widget.user["user_id"],
                                //   // idArtisan: provider.userType == "serviceProvider"?"208":"285",
                                //     userMobile: "+234900000000",
                                //     lastMessageTime: DateTime.now(),
                                //
                                // );
                                //
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) {
                                //     return ChatPage(
                                //         support: true,
                                //         newchat: true,
                                //
                                //         // shipments: shipment,
                                //         // pickup: shipment.pickup,
                                //         // dropoff:shipment.dropoff,
                                //         productSend: true,
                                //         user: user);
                                //   },
                                // ));
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
                                      borderRadius: BorderRadius.circular(6)),
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
              padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${widget.user["first_name"]} ${widget.user["last_name"]}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SvgPicture.asset("assets/svg/verified-badge.svg"),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: InkWell(
                          onTap: () {
                            mywidgets.showHireSheet(context: context, sp_id: "");
                          },
                          child: Container(
                            width: 69,
                            height: 32,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: constants.appMainColor, width: 2),
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
                          SvgPicture.asset("assets/svg/trustedProRanking.svg"),
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
                      text:
                          "Plumbing Problems? We've Got the Fix! Your Local Plumbing Experts",
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    TextSpan(
                      text: " #PlumbingSolutions #YourPlumber #WaterWoesNoMore",
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
                                      width: MediaQuery.of(context).size.width *
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
                                      MediaQuery.of(context).size.width * 0.3,
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
                                      width: MediaQuery.of(context).size.width *
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
                                      MediaQuery.of(context).size.width * 0.3,
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
                                      width: MediaQuery.of(context).size.width *
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
                                      MediaQuery.of(context).size.width * 0.3,
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
      ),
    );
  }
}
