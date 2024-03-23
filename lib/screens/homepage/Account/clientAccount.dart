import 'package:dara_app/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/personalInfo.dart';

class ClientAccount extends StatefulWidget {
  const ClientAccount({Key? key, required this.backToHome}) : super(key: key);
  final Function backToHome;
  @override
  State<ClientAccount> createState() => _ClientAccountState();
}

class _ClientAccountState extends State<ClientAccount> {
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
                          child: Image.network(
                            provider.value["user_object"]["address_information"]
                                ["profile_image"],
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
                          Padding(
                            padding: EdgeInsets.only(
                                right: 10,
                                top: MediaQuery.of(context).size.height * 0.10),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
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
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                      "assets/svg/camera2.svg"),
                                ),
                              ),
                            ),
                          ),
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
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(provider
                                          .value["user_object"]
                                      ["address_information"]["profile_image"]),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.white,
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: SvgPicture.asset(
                                        "assets/svg/camera.svg")),
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
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      SvgPicture.asset("assets/svg/edit.svg"),
                                )),
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
                    "${provider.value["user_object"]["personal_information"]["first_name"] ?? ""} ${provider.value["user_object"]["personal_information"]["last_name"] ?? ""}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${provider.value["user_object"]["personal_information"]["projects_completed"] ?? ""}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Completed Projects",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      children: [
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
                              "Recommendations",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Ranking: "),
                                SvgPicture.asset("assets/svg/ranking.svg"),
                                Text(
                                  " Rising Star",
                                  style: TextStyle(
                                      color: Color(0xFFf97315),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFFf3f4f6)),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: MediaQuery.of(context).size.width *
                                      (double.parse(
                                          "${provider.value["user_object"]["personal_information"]["rating"] ?? "0"}")),
                                  height: 8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFFf97315)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Complete ${provider.value["user_object"]["personal_information"]["projects_completed"] ?? ""} more projects to become an expert guru",
                              style: TextStyle(
                                  color: Colors.black26, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.93,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFf97315)),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 15, right: 15),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                    child: Row(
                      children: [
                        Icon(
                          PhosphorIcons.map_pin,
                             size: 20,
                                color: Colors.blue,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Lagos, Nigeria",
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
