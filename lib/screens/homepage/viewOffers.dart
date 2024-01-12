import '../../main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dara_app/screens/chat/Chat.dart';
import 'package:dara_app/Firebase/Model/User.dart';
import 'package:dara_app/widget/custom_circle.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/Firebase/Firebase_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/callsScreen.dart';

class ViewOffers extends StatefulWidget {
  const ViewOffers(
      {Key? key,
      required this.offerDetail,
      required this.refreshOfferPage,
      required this.offerIndex})
      : super(key: key);
  final offerDetail;
  final offerIndex;
  final Function refreshOfferPage;
  @override
  State<ViewOffers> createState() => _ViewOffersState();
}

class _ViewOffersState extends State<ViewOffers> {
  bool isLoading = false;
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
                    "Offers Details",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Skill Needed",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.offerDetail["skill_needed"]),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Project Description",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.offerDetail["message"]),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Duration",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Started: N/A"),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Ended: N/A"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("N${widget.offerDetail["price"]}"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 8, right: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 64,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0XFFE5E7EB), width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CachedNetworkImage(
                          imageUrl: widget.offerDetail["sender_profile_image"],
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
                              child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.person, size: 50, color: Colors.grey),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.offerDetail["sender"],
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 85,
                            height: 18,
                            decoration: BoxDecoration(
                                color: Color(0XFFFDD4B7),
                                borderRadius: BorderRadius.circular(200)),
                            child: Center(
                              child: Text(
                                "Incoming Offer",
                                style: TextStyle(
                                    color: Color(0XFFF97316), fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          ///////////// The list is not necessary
                          List<User> users = [
                            User(
                              lastMessage: '',
                              urlAvatar: "",
                              userMobile: "",
                              lastMessageTime: DateTime.now(),
                              idUser: widget.offerDetail["sender_user_id"],
                              name: '${widget.offerDetail["sender"]}',
                              read: true,
                              id: widget.offerDetail["sender_user_id"],
                              status: true,
                              docid: widget.offerDetail["sender_user_id"],
                            )
                          ];

                          //----------------------//
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

                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return ChatPage(
                                      newchat: true,
                                      support: true,
                                      user: users[0]);
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
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: constants.appMainColor, width: 2),
                                borderRadius: BorderRadius.circular(6)),
                            child: SvgPicture.asset("assets/svg/message.svg")),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          /////////
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return CallsScreen(
                                    target_id:
                                        widget.offerDetail["sender_user_id"],
                                    target_name: widget.offerDetail["sender"],
                                    target_img: widget
                                        .offerDetail["sender_profile_image"],
                                  );
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
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(right: 10),
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: constants.appMainColor, width: 2),
                              borderRadius: BorderRadius.circular(6)),
                          child: Icon(
                            PhosphorIcons.phone,
                            color: constants.appMainColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              (provider.userType == "serviceProvider")
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            circularCustom(context);

                            rejectOffers(
                                    offer_id: widget.offerDetail["offer_id"])
                                .then((value) {
                              // mywidgets.displayToast(msg: "making the request");
                              print(
                                  "The final Value of what was resulted from the request was :$value");

                              if (value["status"] == true) {
                                setState(() {
                                  Navigator.pop(context);
                                  widget.refreshOfferPage(
                                      offerIndex: widget.offerIndex);
                                  CustomAcknowledgedDialog(widget.offerDetail);
                                });
                              } else if (value["status"] == "Network Error") {
                                Navigator.pop(context);
                                mywidgets.displayToast(
                                    msg:
                                        "Network Error. Check your Network Connection and try again");
                              } else {
                                Navigator.pop(context);
                                mywidgets.displayToast(msg: value["message"]);
                              }

                              setState(() {
                                isLoading = false;
                              });
                            });
                            // CustomAcknowledgedDialog();
                          },
                          child: Container(
                            width: 160,
                            height: 48,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color(0XFFEF4444), width: 2),
                                borderRadius: BorderRadius.circular(200)),
                            child: Center(
                              child: isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text(
                                      "Decline",
                                      style: TextStyle(
                                          color: Color(0XFFEF4444),
                                          fontSize: 14),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            // mywidgets.displayToast(msg: "${widget.offerDetail["offer_id"]}");
                            circularCustom(context);
                            acceptOffers(
                                    offer_id: widget.offerDetail["offer_id"])
                                .then((value) {
                              // mywidgets.displayToast(msg: "making the request");
                              print(
                                  "The final Value of what was resulted from the request was :$value");

                              if (value["status"] == "true") {
                                Navigator.pop(context);
                                setState(() {
                                  widget.refreshOfferPage(
                                      offerIndex: widget.offerIndex);
                                  CustomSuccessDialog(widget.offerDetail);
                                });
                              } else if (value["status"] == "Network Error") {
                                Navigator.pop(context);
                                mywidgets.displayToast(
                                    msg:
                                        "Network Error. Check your Network Connection and try again");
                              } else {
                                Navigator.pop(context);
                                mywidgets.displayToast(msg: value["message"]);
                              }

                              setState(() {
                                isLoading = false;
                              });
                            });
                            // CustomSuccessDialog();
                          },
                          child: Container(
                            width: 160,
                            height: 48,
                            decoration: BoxDecoration(
                                color: constants.appMainColor,
                                borderRadius: BorderRadius.circular(200)),
                            child: Center(
                              child: isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text(
                                      "Accept",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          (provider.userType == "serviceProvider")
                              ? CustomAcknowledgedDialog(widget.offerDetail)
                              : Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 48,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(0XFFEF4444), width: 2),
                              borderRadius: BorderRadius.circular(200)),
                          child: Center(
                            child: Text(
                              "Cancel Request",
                              style: TextStyle(
                                  color: Color(0XFFEF4444), fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 40)
            ],
          ),
        ));
  }

  ////////////////// Success Dialog
  CustomSuccessDialog(data) {
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
                          "Project hire from ${data["sender"]} Accepted",
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
                              Navigator.pop(context);
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
  CustomAcknowledgedDialog(data) {
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
                          "Project hire from ${data["sender"]} declined",
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
                              Navigator.pop(context);
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
