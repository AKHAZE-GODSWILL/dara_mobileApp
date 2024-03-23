import '../../main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/DataProvider.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:dara_app/screens/homepage/viewProject.dart';
import 'package:cached_network_image/cached_network_image.dart';

// import 'package:flutter_ph/**/osphor_icons/flutter_phosphor_icons.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key, required this.userType}) : super(key: key);
  final userType;
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  String selected = "ongoing";
  bool isLoading = false;
  List? allProjects;
  List ongoingProjects = [];
  List completedProjects = [];
  List confirmProjects = [];

  void refreshProjectPage({required projectIndex}) {
    // mywidgets.displayToast(msg: "Offer Index initiated");
    setState(() {
      allProjects!.removeAt(projectIndex);
    });
  }

  void viewAllProjects() {
    // DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    setState(() {
      isLoading = true;
    });

    myProjects(context).then((value) {
      // mywidgets.displayToast(msg: "making the request");

      if (value["status"] == true && value["message"] == "success") {
        setState(() {
          allProjects = value["data"];

          allProjects!.forEach((element) {
            if (element["status"] == "ongoing") {
              ongoingProjects.add(element);
            } else if (element["status"] == "completed") {
              completedProjects.add(element);
            } else {
              confirmProjects.add(element);
            }
          });
        });
      } else if (value["status"] == "Network Error") {
        mywidgets.displayToast(
            msg: "Network Error. Check your Network Connection and try again");
      } else {
        allProjects = [];
        mywidgets.displayToast(msg: value["message"]);
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    viewAllProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 19),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Projects",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black12)),
                    child: Container(
                        child: Transform.scale(
                            scale: 0.5,
                            child: SvgPicture.asset("assets/svg/more.svg")))),
              ],
            ),
          ),
          Stack(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 50,
                  child: Container(
                    // padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // selected == "ongoing"
                        //     ? Text("ongoi")
                        //     :
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "ongoing";
                            });
                          },
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.29,
                              height: 50,
                              child: Center(
                                child: Text("Ongoing"),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xFFf3f4f6)),
                            ),
                          ),
                        ),
                        // selected == "confirm"
                        //     ? Text("")
                        //     :
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "confirm";
                            });
                          },
                          child: Center(
                            child: Container(
                              child: Center(
                                child: Text("Confirm"),
                              ),
                              width: MediaQuery.of(context).size.width * 0.27,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xFFf3f4f6)),
                            ),
                          ),
                        ),
                        // selected == "completed"
                        //     ? Text("")
                        //     :
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = "completed";
                            });
                          },
                          child: Center(
                            child: Container(
                              child: Center(
                                child: Text("Completed"),
                              ),
                              width: MediaQuery.of(context).size.width * 0.29,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xFFf3f4f6)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFf3f4f6)),
                ),
              ),
              AnimatedAlign(
                alignment: selected == "ongoing"
                    ? Alignment.centerLeft
                    : selected == "confirm"
                        ? Alignment.center
                        : Alignment.centerRight,
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                  width: MediaQuery.of(context).size.width * 0.27,
                  height: 40,
                  child: Center(
                    child: Text(
                      selected == "ongoing"
                          ? "Ongoing"
                          : selected == "confirm"
                              ? "Confirm"
                              : "Completed",
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
          (isLoading)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    CircularProgressIndicator(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ],
                )
              : allProjects!.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        Center(
                          child: Text(
                            "No Project Found",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ],
                    )
                  : selected == "ongoing"
                      ? ongoingProjects.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                ),
                                Center(
                                  child: Text(
                                    "No Ongoing Project Found",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                ),
                              ],
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: ongoingProjects.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return ViewProject(
                                                  selected: selected,
                                                  projectDetail:
                                                      ongoingProjects[index],
                                                  refreshProjectPage:
                                                      refreshProjectPage,
                                                  projectIndex: index,
                                                );
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
                                          setState(() {
                                            selected = "ongoing";
                                            isLoading = false;
                                            allProjects;
                                            ongoingProjects = [];
                                            completedProjects = [];
                                            confirmProjects = [];
                                            viewAllProjects();
                                          });
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0, right: 12),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, bottom: 0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 8.0),
                                                        child: Stack(
                                                          children: [
                                                            CachedNetworkImage(
                                                              imageUrl:
                                                                  ongoingProjects[
                                                                          index]
                                                                      [
                                                                      "profile_image"],
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                width: 46,
                                                                height: 46,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  image: DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .cover),
                                                                ),
                                                              ),
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Container(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          CircularProgressIndicator()),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(
                                                                      Icons
                                                                          .person,
                                                                      size: 50,
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 32),
                                                              child: Container(
                                                                child: Text(""),
                                                                height: 12,
                                                                width: 12,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            2),
                                                                    color: Colors
                                                                        .green),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 3),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.78,
                                                            child: RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "${dataProvider.userType != "client" ? ongoingProjects[index]["customer_first_name"] : ongoingProjects[index]["service_provider_first_name"]}",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ])),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5.0),
                                                            child: Text(
                                                              "${ongoingProjects[index]["start_date"] ?? ""} - ${ongoingProjects[index]["end_date"] ?? ""}",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.78,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          2.0),
                                                                  child: Text(
                                                                    "NGN ${ongoingProjects[index]["price"]}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                // Spacer(),
                                                                InkWell(
                                                                  onTap: () {},
                                                                  child:
                                                                      Container(
                                                                    width: 90,
                                                                    height: 26,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xFFfff9c3),
                                                                        borderRadius:
                                                                            BorderRadius.circular(200)),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "${ongoingProjects[index]["status"]}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Color(0xFFca8a03),
                                                                            fontSize: 13),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8),
                                            child: Divider(),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            )
                      : selected == "confirm"
                          ? confirmProjects.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                    ),
                                    Center(
                                      child: Text(
                                        "No Confirm Project Found",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                    ),
                                  ],
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      itemCount: confirmProjects.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                      animation,
                                                      secondaryAnimation) {
                                                    return ViewProject(
                                                      selected: selected,
                                                      projectDetail:
                                                          confirmProjects[
                                                              index],
                                                      refreshProjectPage:
                                                          refreshProjectPage,
                                                      projectIndex: index,
                                                    );
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
                                              setState(() {
                                                selected = "confirm";
                                                isLoading = false;
                                                allProjects;
                                                ongoingProjects = [];
                                                completedProjects = [];
                                                confirmProjects = [];
                                                viewAllProjects();
                                              });
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 12.0, right: 12),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0, bottom: 0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 8.0),
                                                            child: Stack(
                                                              children: [
                                                                CachedNetworkImage(
                                                                  imageUrl: confirmProjects[
                                                                          index]
                                                                      [
                                                                      "profile_image"],
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    width: 46,
                                                                    height: 46,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image: DecorationImage(
                                                                          image:
                                                                              imageProvider,
                                                                          fit: BoxFit
                                                                              .cover),
                                                                    ),
                                                                  ),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Container(
                                                                          width:
                                                                              50,
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              CircularProgressIndicator()),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .person,
                                                                          size:
                                                                              50,
                                                                          color:
                                                                              Colors.grey),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              32),
                                                                  child:
                                                                      Container(
                                                                    child: Text(
                                                                        ""),
                                                                    height: 12,
                                                                    width: 12,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                100),
                                                                        border: Border.all(
                                                                            color: Colors
                                                                                .white,
                                                                            width:
                                                                                2),
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 3),
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.78,
                                                                child: RichText(
                                                                    text: TextSpan(
                                                                        children: [
                                                                      TextSpan(
                                                                        text:
                                                                            "${dataProvider.userType != "client" ? confirmProjects[index]["customer_first_name"] : confirmProjects[index]["service_provider_first_name"]}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.black),
                                                                      ),
                                                                    ])),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            5.0),
                                                                child: Text(
                                                                  "${confirmProjects[index]["start_date"]} - ${confirmProjects[index]["end_date"] ?? ""}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.78,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          2.0),
                                                                      child:
                                                                          Text(
                                                                        "NGN ${confirmProjects[index]["price"]}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            90,
                                                                        height:
                                                                            26,
                                                                        decoration: BoxDecoration(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                209,
                                                                                176),
                                                                            borderRadius:
                                                                                BorderRadius.circular(200)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "${confirmProjects[index]["status"]}",
                                                                            style:
                                                                                TextStyle(color: Color(0XFFF97316), fontSize: 13),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8),
                                                child: Divider(),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                )
                          : completedProjects.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                    ),
                                    Center(
                                      child: Text(
                                        "No Completed Project Found",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                    ),
                                  ],
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      itemCount: completedProjects.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                      animation,
                                                      secondaryAnimation) {
                                                    return ViewProject(
                                                      selected: selected,
                                                      projectDetail:
                                                          completedProjects[
                                                              index],
                                                      refreshProjectPage:
                                                          refreshProjectPage,
                                                      projectIndex: index,
                                                    );
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
                                              setState(() {
                                                selected = "completed";
                                                isLoading = false;
                                                allProjects;
                                                ongoingProjects = [];
                                                completedProjects = [];
                                                confirmProjects = [];
                                                viewAllProjects();
                                              });
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 12.0, right: 12),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0, bottom: 0),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 8.0),
                                                            child: Stack(
                                                              children: [
                                                                CachedNetworkImage(
                                                                  imageUrl: completedProjects[
                                                                          index]
                                                                      [
                                                                      "profile_image"],
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    width: 46,
                                                                    height: 46,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      image: DecorationImage(
                                                                          image:
                                                                              imageProvider,
                                                                          fit: BoxFit
                                                                              .cover),
                                                                    ),
                                                                  ),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Container(
                                                                          width:
                                                                              50,
                                                                          height:
                                                                              50,
                                                                          child:
                                                                              CircularProgressIndicator()),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .person,
                                                                          size:
                                                                              50,
                                                                          color:
                                                                              Colors.grey),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              32),
                                                                  child:
                                                                      Container(
                                                                    child: Text(
                                                                        ""),
                                                                    height: 12,
                                                                    width: 12,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                100),
                                                                        border: Border.all(
                                                                            color: Colors
                                                                                .white,
                                                                            width:
                                                                                2),
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // Text(dataProvider.userType.toString()),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 3),
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.78,
                                                                child: InkWell(
                                                                  child: RichText(
                                                                      text: TextSpan(children: [
                                                                    TextSpan(
                                                                      text:
                                                                          "${dataProvider.userType != "client" ? completedProjects[index]["customer_first_name"] : completedProjects[index]["service_provider_first_name"]}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ])),
                                                                  onTap: () {
                                                                    print(completedProjects[
                                                                        index]);
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            5.0),
                                                                child: Text(
                                                                  "${completedProjects[index]["start_date"]} - ${completedProjects[index]["end_date"] ?? ""}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black54),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.78,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          2.0),
                                                                      child:
                                                                          Text(
                                                                        "NGN ${completedProjects[index]["price"]}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            90,
                                                                        height:
                                                                            26,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Color(0xFFdcfce7),
                                                                            borderRadius: BorderRadius.circular(200)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "${completedProjects[index]["status"]}",
                                                                            style:
                                                                                TextStyle(color: Color(0xFF21c55e), fontSize: 13),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8),
                                                child: Divider(),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                )
        ],
      ),
    );
  }
}
