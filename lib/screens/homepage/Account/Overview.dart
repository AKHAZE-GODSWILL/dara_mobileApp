

import 'package:dara_app/screens/homepage/drawerRoutes/settings/aboutMe.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/businnesInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';

import '../../../main.dart';


class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top:8.0, bottom: 8),
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
                        Text(" Rising Star", style: TextStyle(
                            color: Color(0xFFf97315),
                            fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.88,
                          height:8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFFf3f4f6)
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: MediaQuery.of(context).size.width*0.68,
                          height:8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFFf97315)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Complete 20 more projects to become an expert guru", style: TextStyle(
                        color: Colors.black26,
                        fontSize: 12
                    ),),
                  )
                ],
              ),
              height: 80,
              width: MediaQuery.of(context).size.width*0.93,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFf97315)),
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top:8.0, bottom: 8, left: 15, right: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Business Information", style: TextStyle(fontWeight: FontWeight.bold),),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return BusinessInfo();
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
                    child: SvgPicture.asset("assets/svg/edit.svg"))
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                child: Row(
                  children: [
                    Icon(PhosphorIcons.map_pin,
                      size: 19,
                      color: Colors.black54,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Lagos, Nigeria", style: TextStyle(fontSize: 12),),
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
                      child: Text("Cleaning / Laundry / Funmigation", style: TextStyle(fontSize: 12),),
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
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  // width:90,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFbcd2ff),
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        "Laundry Service",
                                        style: TextStyle(
                                            color: constants.appMainColor,
                                            fontSize: 11),),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  // width:90,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFbcd2ff),
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        "Fumigation",
                                        style: TextStyle(
                                            color: constants.appMainColor,
                                            fontSize: 11),),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  // width:90,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFbcd2ff),
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        "Indoor Cleaning",
                                        style: TextStyle(
                                            color: constants.appMainColor,
                                            fontSize: 11),),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){

                                },
                                child: Container(
                                  // width:90,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFbcd2ff),
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        "Outdoor Cleaning",
                                        style: TextStyle(
                                            color: constants.appMainColor,
                                            fontSize: 11),),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            
                          ],
                        )
                      ],
                    ),
                    

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Icon(PhosphorIcons.lightning,
                      size: 19,
                      color: Colors.black54,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("6 years experience", style: TextStyle(fontSize: 12),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),


        Padding(
          padding: const EdgeInsets.only(top:8.0, bottom: 8, left: 15, right: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Text("About Me", style: TextStyle(fontWeight: FontWeight.bold),),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return AboutMe();
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
                    child: SvgPicture.asset("assets/svg/edit.svg"))
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("""Hey there! I'm Michael, your friendly neighborhood laundry attendant and the proud owner of Sparkleen. I’m passionate about everything laundry-related, and I can't wait to share my expertise and love for clean, fresh-smelling clothes with you!

As a lifelong enthusiast of all things clean and tidy, I decided to turn my passion into a full-fledged laundry venture. With years of experience in the industry, I've honed my skills in the art of laundry, from battling stubborn stains to creating laundry masterpieces that leave my customers in awe. I believe that laundry is not just a chore; it's a chance to bring joy and comfort to people's lives, one freshly laundered garment at a time.

My mission is simple: to redefine the way you experience laundry services. I aim to transform the mundane chore of washing clothes into an enjoyable and hassle-free experience. My laundry is not just a place to get your clothes cleaned; it's a place to connect, relax, and be part of a vibrant laundry-loving community. I take great pride in offering top-notch service, meticulous attention to detail, and a commitment to exceeding your expectations.
                      """, style: TextStyle(fontSize: 13),)),
              )
            ],
          ),
        )
      ],
    );
  }
}