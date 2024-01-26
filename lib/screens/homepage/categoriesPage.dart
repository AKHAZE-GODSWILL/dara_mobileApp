import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:dara_app/screens/homepage/categoryDetails.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/aboutMe.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/getVerified.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/businnesInfo.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/personalInfo.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/loginSettings.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/withDrawalAccount.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/notificationSettings.dart';

class Categories extends StatefulWidget {
  List? categories;
  Categories(this.categories);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
                Padding(
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
                              child: IconButton(
                                onPressed: () {
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
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Categories",
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
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: widget.categories == null
                ? SizedBox()
                : ListView(
                    children: [
                      ...widget.categories!.map((e) {
                        return customListWidget(
                            category: "${e["name"]}", svgImage: "${e["icon"]}");
                      })
                    ],
                  )));
  }

  customListWidget({required String category, required String svgImage}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return CategoryDetails(title: category);
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ));
      },
      child: Container(
          height: 60,
          width: 104,
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     color: Color(0XFFE5E7EB),
          //     width:2
          //   ),
          //   borderRadius: BorderRadius.circular(10)
          // ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  child: Image.network(svgImage),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  category,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF121212)),
                ),
              ],
            ),
          )),
    );
    ;
  }
}
