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
import 'package:dara_app/screens/homepage/reviewPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/callsScreen.dart';

class ViewProject extends StatefulWidget {
  final String selected;
  final projectDetail;
  final projectIndex;
  final Function refreshProjectPage;

  ViewProject(
      {required this.selected,
      required this.refreshProjectPage,
      required this.projectIndex,
      required this.projectDetail});

  @override
  State<ViewProject> createState() => _ViewProjectState();
}

class _ViewProjectState extends State<ViewProject> {
  String isSelected = "ongoing";
  @override
  void initState() {
    isSelected = widget.selected;
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
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
                    "Project Details",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Skill Needed",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.projectDetail["skill_needed"],
                        style: TextStyle(color: Colors.black54)),
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.projectDetail["description"],
                        style: TextStyle(color: Colors.black54)),
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Started:  ${widget.projectDetail["start_date"] ?? ""}",
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (isSelected == "ongoing" || isSelected == "confirm")
                        ? Text(
                            "Ended: ${widget.projectDetail["end_date"] ?? ""}",
                            style: TextStyle(color: Colors.black54))
                        : Text(
                            "Started: 08/05/23 (12:48 AM)",
                            style: TextStyle(color: Colors.black54),
                          ),
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("N ${widget.projectDetail["price"]}",
                        style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, bottom: 8, left: 8, right: 8),
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
                      child: ///////// Image //////
                          CachedNetworkImage(
                        imageUrl: widget.projectDetail["profile_image"],
                        imageBuilder: (context, imageProvider) => Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                            width: 46,
                            height: 46,
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
                          (provider.userType == "serviceProvider")
                              ? widget.projectDetail["customer_first_name"]
                              : widget
                                  .projectDetail["service_provider_first_name"],
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        (isSelected == "ongoing" || isSelected == "confirm")
                            ? Container(
                                width: 85,
                                height: 18,
                                decoration: BoxDecoration(
                                    color: Color(0XFFFDD4B7),
                                    borderRadius: BorderRadius.circular(200)),
                                child: Center(
                                  child: Text(
                                    widget.projectDetail["status"]
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Color(0XFFF97316), fontSize: 10),
                                  ),
                                ),
                              )
                            : Container(
                                width: 90,
                                height: 26,
                                decoration: BoxDecoration(
                                    color: Color(0xFFdcfce7),
                                    borderRadius: BorderRadius.circular(200)),
                                child: Center(
                                  child: Text(
                                    widget.projectDetail["status"],
                                    style: TextStyle(
                                        color: Color(0xFF21c55e), fontSize: 13),
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
                              urlAvatar:  widget.projectDetail["profile_image"],
                              userMobile: "",
                              lastMessageTime: DateTime.now(),
                              idUser: (provider.userType == "serviceProvider")
                                  ? widget.projectDetail["customer"]
                                  : widget.projectDetail["service_provider"],
                              name: (provider.userType == "serviceProvider")
                                  ? '${widget.projectDetail["customer_first_name"]}'
                                  : '${widget.projectDetail["service_provider_first_name"]}',
                              read: true,
                              id: (provider.userType == "serviceProvider")
                                  ? widget.projectDetail["service_provider"]
                                  : widget.projectDetail["customer"],
                              status: true,
                              docid: (provider.userType == "serviceProvider")
                                  ? widget.projectDetail["service_provider"]
                                  : widget.projectDetail["customer"])
                        ];

                        //----------------------//
                        FirebaseApi.addUserChat(
                          // shipment: e.value,
                          token2: 'data.fcmToken',
                          token: 'snapshot.data[index].fcmToken',
                          urlAvatar2: provider.client_profile_image,
                          name2: provider.client_first_name,
                          recieveruserId2:
                              provider.sp_user_id.toString() == null
                                  ? provider.client_user_id.toString()
                                  : provider.sp_user_id.toString(),
                          recieveruserId: users[0].idUser,
                          idArtisan: provider.sp_user_id.toString() == null
                              ? provider.client_user_id.toString()
                              : provider.sp_user_id.toString(),
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
                                  target_id: (provider.userType ==
                                          "serviceProvider")
                                      ? widget.projectDetail["customer"]
                                      : widget
                                          .projectDetail["service_provider"],
                                  target_name: (provider.userType ==
                                          "serviceProvider")
                                      ? widget
                                          .projectDetail["customer_first_name"]
                                      : widget.projectDetail[
                                          "service_provider_first_name"],
                                  target_img:
                                      widget.projectDetail["profile_image"],
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
            (provider.userType == "client")
                ? (isSelected == "ongoing" || isSelected == "confirm")
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: InkWell(
                          onTap: () {
                            ConfirmProjectCompletionDialog(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            decoration: BoxDecoration(
                                color: constants.appMainColor,
                                borderRadius: BorderRadius.circular(200)),
                            child: Center(
                              child: Text(
                                "Confirm Project Complete",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return ReviewService(
                                        projectDetail: widget.projectDetail);
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
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            decoration: BoxDecoration(
                                color: constants.appMainColor,
                                borderRadius: BorderRadius.circular(200)),
                            child: Center(
                              child: Text(
                                "Write a review",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      )
                // runs when the tier type selected is service provider
                : (isSelected == "ongoing" || isSelected == "confirm")
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: InkWell(
                          onTap: () {
                            showSubmitSheet(
                                widget.projectDetail["customer_first_name"]);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 48,
                            decoration: BoxDecoration(
                                color: constants.appMainColor,
                                borderRadius: BorderRadius.circular(200)),
                            child: Center(
                              child: Text(
                                "Complete Project",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
            SizedBox(height: 40)
          ],
        ),
      ),
    );
  }

  showSubmitSheet(name) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return SingleChildScrollView(
          child: Container(
              height: 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "End Project",
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                              "Feel free to leave a note for your client in the box provided, if you have any message",
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: Color(0XFF374151))),
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
                            "Message (Optional)",
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0XFF6B7280)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 209,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: Color(0XFFE5E7EB))),
                            child: TextFormField(
                              // focusNode: textNode,
                              onChanged: (value) {
                                setState(() {});
                              },
                              keyboardType: TextInputType.multiline,
                              textAlignVertical: TextAlignVertical.top,
                              maxLines: null,
                              expands: true,
                              minLines: null,
                              // controller: bioController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide
                                      .none, // Remove the border when focused
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide
                                      .none, // Remove the border when enabled
                                ),
                                hintText:
                                    "Describe what you want the client to know",
                                hintStyle: GoogleFonts.inter(
                                    fontSize: 12, color: Color(0XFF6B7280)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        circularCustom(context);
                        completeProject(
                                projectId: widget.projectDetail["project_id"])
                            .then((value) {
                          // mywidgets.displayToast(msg: "making the request");

                          if (value["status"].toString() == "true") {
                            Navigator.of(context, rootNavigator: true).pop();
                            setState(() {
                              isSelected = "confirm";
                            });
                            showDoneSheet(name);
                            // showProjectCompletionDialog();
                            widget.refreshProjectPage(
                                projectIndex: widget.projectIndex);
                            // project!.removeAt(index);
                          } else if (value["status"] == "Network Error") {
                            Navigator.pop(context);
                            mywidgets.displayToast(
                                msg:
                                    "Network Error. Check your Network Connection and try again");
                          } else {
                            Navigator.pop(context);
                            mywidgets.displayToast(msg: value["message"]);
                          }
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        decoration: BoxDecoration(
                            color: constants.appMainColor,
                            borderRadius: BorderRadius.circular(200)),
                        child: Center(
                          child: Text(
                            "Submit",
                            style: GoogleFonts.inter(
                                color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }

  showDoneSheet(name) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: Container(
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
                      "Congratulations",
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${name} project successfully concluded. Kindly wait for confirmation from your client.",
                      style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: Colors.black,
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
        ));
      },
    );
  }

  ConfirmProjectCompletionDialog(context) {
    return showDialog(
        barrierColor: Color(0XFF121212).withOpacity(0.7),
        context: context,
        builder: (ctx) {
          return StatefulBuilder(builder: (ctx, setState) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.9,
                    // height: 338,
                    // width: 320,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "You are confirming that your project was successfully completed",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                            // textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0XFF6B7280),
                                      decoration: TextDecoration.none),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  circularCustom(context);
                                  confirmProjectCompletion(
                                          project_id: widget
                                              .projectDetail["project_id"])
                                      .then((value) {
                                    // mywidgets.displayToast(msg: "making the request");

                                    if (value["status"].toString() == "true") {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();

                                      isSelected = "completed";

                                      showProjectCompletionDialog();
                                      widget.refreshProjectPage(
                                          projectIndex: widget.projectIndex);
                                      // project!.removeAt(index);
                                    } else if (value["status"] ==
                                        "Network Error") {
                                      Navigator.pop(context);
                                      mywidgets.displayToast(
                                          msg:
                                              "Network Error. Check your Network Connection and try again");
                                    } else {
                                      Navigator.pop(context);
                                      mywidgets.displayToast(
                                          msg: value["message"]);
                                    }
                                  });
                                },
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: constants.appMainColor,
                                      decoration: TextDecoration.none),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  showProjectCompletionDialog() {
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        Text(
                          "Congratulations",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Your project was successfully completed",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                          textAlign: TextAlign.center,
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
                                  style: TextStyle(
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
