
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dara_app/main.dart';
import 'package:dara_app/screens/homepage/serviceProviderProfile/serviceProviderAccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class ExpandableWidget extends StatefulWidget{
  ExpandableWidget({Key? key, required this.specificPost}):super(key:key);
  final specificPost;
  State<ExpandableWidget> createState()=> _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget>{
  bool isTextExpanded = false;
  // dynamic containerHeight = 60.0;

  Widget build(BuildContext context){
    return Column(
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
                            child: InkWell(
                              onTap:(){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> ServiceProviderAccount())
                              );
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage("assets/profile1.png"),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daniel Smith",
                                style:
                                GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),
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
                                    style: GoogleFonts.inter(fontSize: 12, color: Color(0XFF6B7280)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      height: 4.2,
                                      width: 4.2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0XFF6B7280),
                                      ),
                                      child: Text(""),
                                    ),
                                  ),
                                  Text(
                                    "Electrical Consultant | Solar Engineer",
                                    style: GoogleFonts.inter(fontSize: 12, color: Color(0XFF6B7280)),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  "6h",
                                  style: GoogleFonts.inter(fontSize: 12, color:Color(0XFF6B7280)),
                                ),
                              ),
          
                            ],
                          ),
                          Spacer(),
                          SvgPicture.asset("assets/svg/more.svg")
                        ],
                      ),
                    ),
                     Container(
                      alignment: Alignment.centerLeft,
                      // width: MediaQuery.of(context).size.width*0.72,
                      child: ReadMoreText(
                        widget.specificPost["body"],
                        style: GoogleFonts.inter(fontSize:12, color:Colors.black),
                        trimCollapsedText: "See More",
                        trimExpandedText:"See Less",
                        trimLines: 3,
                        trimMode: TrimMode.Line,
                        callback: (val) {
                          setState(() {
                            isTextExpanded = !isTextExpanded;
                          });
                        },
                      )
                      
                      // Text(posts[postIndex]["body"],
                      //     maxLines: maxLineNumber,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                      // ),
                    ),
                    
                    
                  (widget.specificPost["media"] == "null" || widget.specificPost["media"] == "[]")? SizedBox() 
                    :Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 290,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                                        imageUrl: widget.specificPost["media"],
                                        imageBuilder: (context, imageProvider) => Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 290,
                                          decoration: BoxDecoration(
                                            // shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider, fit: BoxFit.cover),
                                          ),
                                        ),
                                        // placeholder: (context, url) => Container(
                                        //   width: 60,
                                        //   height: 60,
                                        //   child: CircularProgressIndicator()
                                        // ),
                                        errorWidget: (context, url, error) => Icon(Icons.wifi_off,
                                       size: 50, color:Colors.grey),
                                        ),
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
                              InkWell(
                                onTap: (){
                                  // mywidgets.displayToast(msg: "${widget.specificPost["media"].runtimeType}");
                                },
                                child: Icon(PhosphorIcons.heart, color: Colors.black,)),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  "267",
                                  style: GoogleFonts.inter(fontSize: 13, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(PhosphorIcons.eye, color: Colors.black,),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  "2,447",
                                  style: GoogleFonts.inter(fontSize: 13, color: Colors.black),
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
          );
  }
}