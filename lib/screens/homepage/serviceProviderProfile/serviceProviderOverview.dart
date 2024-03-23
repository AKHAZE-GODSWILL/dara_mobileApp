import '../../../main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class Overview extends StatefulWidget {
  var data;
  Overview({this.data});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8, left: 15, right: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Business Information",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
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
                        "${widget.data["state"]}, Nigeria",
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      child: SvgPicture.asset("assets/svg/briefcase.svg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "${widget.data["service"]}",
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        child: SvgPicture.asset("assets/svg/medal-star.svg"),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  // width:90,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFbcd2ff),
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        "${widget.data["skills"]}",
                                        style: TextStyle(
                                            color: constants.appMainColor,
                                            fontSize: 11),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Icon(
                      PhosphorIcons.lightning,
                      size: 19,
                      color: Colors.black54,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "${widget.data["experience"]}",
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8, left: 15, right: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "About Me",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${widget.data["bio"]}",
                      style: TextStyle(fontSize: 13),
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
