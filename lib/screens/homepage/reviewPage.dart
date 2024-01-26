import '../../main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:dara_app/widget/custom_circle.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class ReviewService extends StatefulWidget {
  var projectDetail;
  ReviewService({this.projectDetail});
  @override
  State<ReviewService> createState() => _ReviewServiceState();
}

class _ReviewServiceState extends State<ReviewService> {
  bool isSelected = false;
  int rating = 0;
  String groupValue = "Maybe";

  final commentController = TextEditingController();
  String review = "";
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
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                          height: 42,
                          width: 42,
                          alignment: Alignment.center,
                          // decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(100),
                          //     border:
                          //     Border.all(color: Colors.black12)),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 24,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Write a review",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  width: 86,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // color: Colors.red,
                        width: 72,
                        height: 72,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  widget.projectDetail["profile_image"]),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Text(
                        (provider.userType == "serviceProvider")
                            ? widget.projectDetail["customer_first_name"]
                            : widget
                                .projectDetail["service_provider_first_name"],
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 200,
                  height: 52,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        height: 32,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  rating = 1;
                                });
                              },
                              child: Icon(
                                (rating >= 1)
                                    ? PhosphorIcons.star_fill
                                    : PhosphorIcons.star,
                                color: Colors.orangeAccent,
                                size: 32,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  rating = 2;
                                });
                              },
                              child: Icon(
                                (rating >= 2)
                                    ? PhosphorIcons.star_fill
                                    : PhosphorIcons.star,
                                color: Colors.orangeAccent,
                                size: 32,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  rating = 3;
                                });
                              },
                              child: Icon(
                                (rating >= 3)
                                    ? PhosphorIcons.star_fill
                                    : PhosphorIcons.star,
                                color: Colors.orangeAccent,
                                size: 32,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  rating = 4;
                                });
                              },
                              child: Icon(
                                (rating >= 4)
                                    ? PhosphorIcons.star_fill
                                    : PhosphorIcons.star,
                                color: Colors.orangeAccent,
                                size: 32,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  rating = 5;
                                });
                              },
                              child: Icon(
                                (rating >= 5)
                                    ? PhosphorIcons.star_fill
                                    : PhosphorIcons.star,
                                color: Colors.orangeAccent,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bad",
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            "Excellent",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 1, color: Color(0XFFE5E7EB))),
                          child: TextFormField(
                            // focusNode: textNode,
                            onChanged: (value) {
                              setState(() {
                                review = value;
                              });
                            },
                            keyboardType: TextInputType.multiline,
                            textAlignVertical: TextAlignVertical.top,
                            maxLines: null,
                            expands: true,
                            minLines: null,
                            maxLength: 1000,
                            controller: commentController,
                            decoration: InputDecoration(
                              counterText: "",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when focused
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when enabled
                              ),
                              hintText: "Type your comment here",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${commentController.text.length}/1000",
                      style: TextStyle(fontSize: 12, color: Color(0XFF9CA3AF)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  // color: Colors.green,
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Would you recommend Daniel services to other clients?",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                              value: "Yes",
                              groupValue: groupValue,
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value!;
                                });
                              }),
                          Text(
                            "Yes",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                              value: "No",
                              groupValue: groupValue,
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value!;
                                });
                              }),
                          Text(
                            "No",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                // Text(widget.projectDetail.toString()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(
                    onTap: () {
                      circularCustom(context);
                      uploadReview(
                              service_provider:
                                  widget.projectDetail["service_provider"],
                              review: review)
                          .then((value) {
                        if (value["status"].toString() == "true") {
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.of(context, rootNavigator: true).pop();
                        } else if (value["status"] == "Network Error") {
                        
                          Navigator.pop(context);
                          mywidgets.displayToast(
                              msg:
                                  "Network Error. Check your Network Connection and try again");
                        } else {
                          Navigator.pop(context);
                          mywidgets.displayToast(msg: value["message"]);
                        }
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      decoration: BoxDecoration(
                          color: constants.appMainColor,
                          borderRadius: BorderRadius.circular(200)),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ));
  }
}
