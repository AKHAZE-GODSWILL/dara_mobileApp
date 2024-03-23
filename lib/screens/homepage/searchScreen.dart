import 'dart:convert';
import 'package:dara_app/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:dara_app/widget/custom_circle.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/aboutMe.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/getVerified.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/businnesInfo.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/personalInfo.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/loginSettings.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/withDrawalAccount.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/notificationSettings.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List skills = ["Plumber", "Designer", "Solar", "Tailor", "Web developer"];
  // bool isSearching = false;
  List<dynamic>? serviceProviders;
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
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Text("")),
          centerTitle: false,
          titleSpacing: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 40),
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Row(
                      children: [
                        Container(
                          height: 48,
                          width: 52,
                          alignment: Alignment.center,
                          child: SvgPicture.asset("assets/svg/search.svg"),
                        ),
                        Container(
                          height: 48,
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Center(
                            child: TextFormField(
                              // focusNode: textNode,
                              // onChanged: (value) {
                              //   setState(() {
                              //     isSearching = true;
                              //   });
                              // },
                              textInputAction: TextInputAction.go,

                              onFieldSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  GetStorage box = GetStorage();
                                  var recentList = box.read("search");

                                  box.write(
                                      "search",
                                      recentList == null
                                          ? [value]
                                          : (recentList + [value]));
                                  circularCustom(context);

                                  searchServiceProviders(query: value.trim())
                                      .then((value) {
                                    if (value["status"] == true) {
                                      setState(() {
                                        // getX.write((widget.userType == "serviceProvider")? constants.GETX_SP_FEEDS:constants.GETX_CLIENT_FEEDS, value["user_object"]["posts"]);
                                        // serviceProviders.clear();
                                        serviceProviders = value["data"];
                                      });
                                    } else if (value["status"] ==
                                        "Network Error") {
                                      mywidgets.displayToast(
                                          msg:
                                              "Network Error. Check your Network Connection and try again");
                                    } else {
                                      mywidgets.displayToast(
                                          msg: value["message"]);
                                    }

                                    Navigator.pop(context);
                                  });
                                }
                              },
                              keyboardType: TextInputType.text,
                              // controller: firstNameController,

                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 20),
                                focusedBorder: OutlineInputBorder(
                                  gapPadding: 0,
                                  borderSide: BorderSide
                                      .none, // Remove the border when focused
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide
                                      .none, // Remove the border when enabled
                                ),
                                hintText: "Search",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: null,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: serviceProviders != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "${serviceProviders!.length} results found",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: serviceProviders == null
                              ? 0
                              : serviceProviders!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: InkWell(
                                  onTap: () {
                                    print(serviceProviders![index].toString());
                                  },
                                  child: Container(
                                    height: 80,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2,
                                          color: Color(0XFFE5E7EB),
                                        ),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundImage: NetworkImage(
                                                  "${serviceProviders![index]["service_provider profile_image"]}"),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${serviceProviders![index]["first_name"] ?? ""} ${serviceProviders![index]["last_name"] ?? ""}",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  "${serviceProviders![index]!["kyc"]}"
                                                              .toString() ==
                                                          "approved"
                                                      ? SvgPicture.asset(
                                                          "assets/svg/verified-badge.svg")
                                                      : Container(),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    PhosphorIcons.star_fill,
                                                    color: Colors.orangeAccent,
                                                    size: 13,
                                                  ),
                                                  Text(
                                                    "${serviceProviders![index]["rating"]}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black54),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                      height: 4.2,
                                                      width: 4.2,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.black54,
                                                      ),
                                                      child: Text(""),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${serviceProviders![index]["service"] ?? ""}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black54),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Text(
                                                      "0 Recommended",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                      height: 4.2,
                                                      width: 4.2,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Text(
                                                      "${serviceProviders![index]["projects_completed"]} Completed Projects",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: InkWell(
                                              onTap: () {
                                                mywidgets.showHireSheet(
                                                    context: context,
                                                    sp_id: serviceProviders![
                                                            index]
                                                        ["service_provider_id"],
                                                    service: serviceProviders![
                                                            index]
                                                        ["service"]??"");
                                              },
                                              child: Container(
                                                width: 69,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: constants
                                                            .appMainColor,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            200)),
                                                child: Center(
                                                  child: Text(
                                                    "Hire me",
                                                    style: TextStyle(
                                                        color: constants
                                                            .appMainColor,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recent Searches",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  // skills.clear();
                                  GetStorage box = GetStorage();
                                  box.remove("search");
                                });
                              },
                              child: Text(
                                "Clear all",
                                style: TextStyle(
                                    color: constants.appMainColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Builder(builder: (context) {
                        GetStorage box = GetStorage();
                        var recentList = box.read("search");
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            // physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                recentList == null ? 0 : recentList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 8),
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  // decoration: BoxDecoration(
                                  //   border: Border.all(
                                  //     width: 2,
                                  //     color: Color(0XFFE5E7EB),
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(8)
                                  // ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            circularCustom(context);

                                            searchServiceProviders(
                                                    query: recentList[index]
                                                        .trim())
                                                .then((value) {
                                              if (value["status"] == true) {
                                                setState(() {
                                                  // getX.write((widget.userType == "serviceProvider")? constants.GETX_SP_FEEDS:constants.GETX_CLIENT_FEEDS, value["user_object"]["posts"]);
                                                  // serviceProviders.clear();
                                                  serviceProviders =
                                                      value["data"];
                                                });
                                              } else if (value["status"] ==
                                                  "Network Error") {
                                                mywidgets.displayToast(
                                                    msg:
                                                        "Network Error. Check your Network Connection and try again");
                                              } else {
                                                mywidgets.displayToast(
                                                    msg: value["message"]);
                                              }

                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            child: Text(
                                              recentList[index],
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              recentList.removeAt(index);
                                              box.write("search", recentList);
                                              recentList = box.read("search");
                                            });
                                          },
                                          child: Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    ],
                  ),
          ),
        ));
  }
}
