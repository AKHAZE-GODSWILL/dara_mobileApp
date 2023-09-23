import 'package:dara_app/screens/homepage/Notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 8, right: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("assets/profile.png"),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi Michael!",
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            PhosphorIcons.map_pin,
                            color: Colors.black54,
                            size: 18,
                          ),
                          Text(
                            "Lagos Nigeria",
                            style: TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return Notifications();
                            // MainOnboard();
                            // HomePageWidget();
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        )
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.black12)),
                          child: Icon(
                            PhosphorIcons.bell,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Container(
                            height: 15,
                            width: 23,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            child: Center(
                                child: Text(
                              "9+",
                              style: TextStyle(color: Colors.white, fontSize: 13),
                            )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(),
          Container(
            height: MediaQuery.of(context).size.height*0.746,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:0.0, bottom: 8),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage("assets/profile1.png"),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Daniel Smith",
                                        style:
                                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            PhosphorIcons.star_fill,
                                            color: Colors.orangeAccent,
                                            size: 13,
                                          ),
                                          Text(
                                            "4.2",
                                            style: TextStyle(fontSize: 12, color: Colors.black54),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              height: 4.2,
                                              width: 4.2,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.black54,
                                              ),
                                              child: Text(""),
                                            ),
                                          ),
                                          Text(
                                            "Electrical Consultant | Solar Engineer",
                                            style: TextStyle(fontSize: 12, color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "6h",
                                          style: TextStyle(fontSize: 12, color: Colors.black54),
                                        ),
                                      ),

                                    ],
                                  ),
                                  Spacer(),
                                  SvgPicture.asset("assets/svg/more.svg")
                                ],
                              ),
                            ),
                            Text("Lorem ipsum dolor sit amet consectetur. Donec vulputate tristique sit quis tristique sit ut ultrices. "
                                "Adipiscing pulvinar eros arcu scelerisque lectus scelerisque... See more",
                              style: TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 290,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/provider.png", fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0, bottom: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.heart, color: Colors.black45,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          "267",
                                          style: TextStyle(fontSize: 13, color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.eye, color: Colors.black45,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          "2,447",
                                          style: TextStyle(fontSize: 13, color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset("assets/svg/share.svg")
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:8.0, bottom: 8),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage("assets/profile1.png"),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Daniel Smith",
                                        style:
                                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            PhosphorIcons.star_fill,
                                            color: Colors.orangeAccent,
                                            size: 13,
                                          ),
                                          Text(
                                            "4.2",
                                            style: TextStyle(fontSize: 12, color: Colors.black54),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              height: 4.2,
                                              width: 4.2,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.black54,
                                              ),
                                              child: Text(""),
                                            ),
                                          ),
                                          Text(
                                            "Electrical Consultant | Solar Engineer",
                                            style: TextStyle(fontSize: 12, color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "6h",
                                          style: TextStyle(fontSize: 12, color: Colors.black54),
                                        ),
                                      ),

                                    ],
                                  ),
                                  Spacer(),
                                  SvgPicture.asset("assets/svg/more.svg")
                                ],
                              ),
                            ),
                            Text("Lorem ipsum dolor sit amet consectetur. Donec vulputate tristique sit quis tristique sit ut ultrices. "
                                "Adipiscing pulvinar eros arcu scelerisque lectus scelerisque... See more",
                              style: TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 290,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/provider.png", fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0, bottom: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.heart, color: Colors.black45,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          "267",
                                          style: TextStyle(fontSize: 13, color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(PhosphorIcons.eye, color: Colors.black45,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          "2,447",
                                          style: TextStyle(fontSize: 13, color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset("assets/svg/share.svg")
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  )
                ],
              ),
            ),
          )


          ],
        ),

    );
  }
}
