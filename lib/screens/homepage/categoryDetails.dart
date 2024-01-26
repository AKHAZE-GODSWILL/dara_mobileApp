import 'package:dara_app/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/aboutMe.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/getVerified.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/businnesInfo.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/personalInfo.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/loginSettings.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/withDrawalAccount.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/notificationSettings.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  List? result;
  @override
  void initState() {
    super.initState();
    ServiceProviderByCategory(widget.title.toLowerCase()).then((value) {
      setState(() {
        result = value;
      });
    });
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
          title: Transform(
            transform: Matrix4.translationValues(-55, 0, 0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
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
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 30,
                                )))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    widget.title,
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
        body: result == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Center(child: CircularProgressIndicator()),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                ],
              )
            : result!.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                      Center(
                        child: Text(
                          "No Service Provider Found",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                    ],
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: result == null ? 0 : result!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                          child: Container(
                            height: 78,
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
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          AssetImage("assets/profile1.png"),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${result![index]["first_name"] ?? ""} ${result![index]["last_name"] ?? ""}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
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
                                            "${result![index]["rating"]}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              height: 4.2,
                                              width: 4.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.black54,
                                              ),
                                              child: Text(""),
                                            ),
                                          ),
                                          Text(
                                            "${result![index]["service"]} ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              "${result![index]["projects_completed"]} Recommended",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              height: 4.2,
                                              width: 4.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              "${result![index]["projects_completed"]}  Completed Projects",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        mywidgets.showHireSheet(
                                            context: context,
                                            sp_id: result![index]
                                                ["service_provider_id"]);
                                      },
                                      child: Container(
                                        width: 69,
                                        height: 32,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: constants.appMainColor,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(200)),
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
                            ),
                          ),
                        );
                      },
                    ),
                  ));
  }
}
