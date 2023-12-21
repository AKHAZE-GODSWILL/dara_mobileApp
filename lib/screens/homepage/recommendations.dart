import 'package:dara_app/screens/homepage/viewOffers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import '../../main.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({Key? key}) : super(key: key);

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        centerTitle: false,
        titleSpacing: 0,
        title: Transform(
          transform: Matrix4.translationValues(-55, 0, 0),
          child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border:
                          Border.all(color: Colors.black12)),
                      child: Container(
                          child: Transform.scale(
                              scale: 0.5,
                              child: IconButton(
                
                                  onPressed: (){
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
                  padding: const EdgeInsets.only(left:12.0),
                  child: Text(
                    "Recommendations",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                // Spacer(),
              ],
            ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Padding(
                          padding: const EdgeInsets.only(top:8.0, bottom: 8),
                          child: Container(
                            height: 68,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Color(0XFFE5E7EB),
                              ),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            "Plumber",
                                            style: TextStyle(fontSize: 12, color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              "20 Recommended",
                                              style: TextStyle(
                                                fontSize: 8, 
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
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                            
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              "51 Completed Projects",
                                              style: TextStyle(
                                                fontSize: 8, 
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
                                  onTap: (){
                                    mywidgets.showHireSheet(context: context, sp_id: "");
                                  },
                                  child: Container(
                                    width: 69,
                                    height: 32,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: constants.appMainColor, width: 2),
                                        borderRadius: BorderRadius.circular(200)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Hire me",
                                        style: TextStyle(
                                            color:   constants.appMainColor,
                                            fontSize: 14),),
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
    );
  }
}
