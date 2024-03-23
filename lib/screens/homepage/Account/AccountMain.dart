import 'dart:io';
import 'Posts.dart';
import 'Reviews.dart';
import 'Overview.dart';
import 'package:dara_app/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/businnesInfo.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/personalInfo.dart';

enum TypeSelected { OVERVIEW, POST, REVIEW }

class AccountMain extends StatefulWidget {
  const AccountMain({Key? key, required this.backToHome}) : super(key: key);
  final Function backToHome;
  @override
  State<AccountMain> createState() => _AccountMainState();
}

class _AccountMainState extends State<AccountMain> {
  String updatedImage = "";
  String imgPath = "";

  String imgPath_Url = "";
  String imgExt = "";
  File? readyUploadImage;
  bool hasImg = false;

  getImageGallery(DataProvider provider) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((selectedImage) {
      if (selectedImage == null) return;
      readyUploadImage = File(selectedImage.path);
      setState(() {
        imgPath = readyUploadImage!.path;
        imgExt = imgPath.split(".").last;
        hasImg = true;
        imgPath_Url = "";
      });

      updateBanner(
        imageFile: readyUploadImage,
      ).then((value) {
        Fluttertoast.showToast(msg: "Updated Successfully");
        reloadUserObject().then((value) {
          if ((provider.userType == "serviceProvider")) {
            provider.set_sp_login_info(
                value: value,
                firstName: value["user_object"]["personal_information"]
                    ["first_name"],
                lastName: value["user_object"]["personal_information"]
                    ["last_name"],
                email: value["user_object"]["personal_information"]["email"],
                id: value["user_object"]["personal_information"]["id"]
                    .toString(),
                access_token: value["access_token"],
                profile_image:
                    (value["user_object"]["address_information"] != null)
                        ? value["user_object"]["address_information"]
                            ["profile_image"]
                        : "");
          } else {
            provider.set_client_login_info(
                value: value,
                firstName: value["user_object"]["personal_information"]
                    ["first_name"],
                lastName: value["user_object"]["personal_information"]
                    ["last_name"],
                email: value["user_object"]["personal_information"]["email"],
                id: value["user_object"]["personal_information"]["id"]
                    .toString(),
                access_token: value["access_token"],
                profile_image:
                    (value["user_object"]["address_information"] != null)
                        ? value["user_object"]["address_information"]
                            ["profile_image"]
                        : "");
          }
        });
      });
    });
  }

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
                          child:  provider.value["user_object"]
                                      ["personal_information"]["banner"]==null?
                                      Image.asset(
                                  "assets/accBg.png",
                                  fit: BoxFit.cover,
                                )
                                      :(imgPath.isEmpty
                              ? Image.network(
                                  provider.value["user_object"]
                                      ["personal_information"]["banner"]??"",
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(imgPath),
                                  fit: BoxFit.cover,
                                ))),
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
                                                widget.backToHome(index: 0);
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
                          ),
                          InkWell(
                            onTap: () {
                              getImageGallery(provider);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 20,
                                  left: 10,
                                  bottom: 10,
                                  top: MediaQuery.of(context).size.height *
                                      0.10),
                              child: Align(
                                alignment: Alignment.topRight,
                                child:
                                    SvgPicture.asset("assets/svg/camera2.svg"),
                              ),
                            ),
                          )
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
                            top: MediaQuery.of(context).size.height * 0.23),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: provider.value["user_object"]
                                      ["address_information"]["profile_image"],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 80,
                                    height: 80,
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
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: InkWell(
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
                                            )).then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                            "assets/svg/camera.svg"),
                                      ),
                                    ))
                              ],
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
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                      )).then((value) {
                                    setState(() {});
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      SvgPicture.asset("assets/svg/edit.svg"),
                                ))
                          ],
                        ),
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
                    "${provider.value["user_object"]["personal_information"]["first_name"]} ${provider.value["user_object"]["personal_information"]["last_name"]}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text:
                          "${provider.value["user_object"]["service_information"][0]["service"]}",
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    TextSpan(
                      text:
                          "# ${provider.value["user_object"]["service_information"][0]["skills"]} ",
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
                        "${provider.value["user_object"]["personal_information"]["projects_completed"]}",
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
                        "${provider.value["user_object"]["personal_information"]["rating"]}/5.0",
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
                        "0",
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
                    : Reviews(provider.value["user_object"]
                        ["personal_information"]["service_provider"])
          ],
        ),
      ),
    );
  }
}
