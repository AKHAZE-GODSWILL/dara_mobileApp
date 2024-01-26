import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class Reviews extends StatefulWidget {
  String ?id;
   Reviews(this.id);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  List? reviews;

  final textNode = FocusNode();
  final _textEditingController = TextEditingController();
  final passwordFocusNode = FocusNode();

  @override
  initState() {
    super.initState();
    DataProvider provider = Provider.of<DataProvider>(context, listen: false);
    fetchReview(widget.id)
        .then((value) {
     setState(() {
        reviews = value;
     });
    });
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return reviews ==null? 
    Center(child: CircularProgressIndicator(),)
    :Padding(
      padding: EdgeInsets.all(20), 
      child:  Column(
      children: [
        ...reviews!.map((e) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 8),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  NetworkImage("${e["author_image"]}"),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${e["author"]} ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                               Container(
                                width: MediaQuery.of(context).size.width*0.41,
                                 child: Text(
                                  "${e["review"]} ",
                                  style: TextStyle(
                                      fontSize: 12),
                                                               ),
                               ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.all(2.0),
                              //       child: Icon(
                              //         PhosphorIcons.star_fill,
                              //         color: Colors.orangeAccent,
                              //         size: 12,
                              //       ),
                              //     ),
                                  
                              //   ],
                              // ),
                            ],
                          ),
                          Spacer(),
                          Text(
                             "${GetTimeAgo.parse(DateTime.parse("${e["created_at"]}"))}",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black87),
                          )
                          // SvgPicture.asset("assets/svg/more.svg")
                        ],
                      ),
                    ),
                    Text(
                      "",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    )
                  ],
                ),
              ),
              Divider()
            ],
          );
        })
      ],
    ),
      );

  }
}
