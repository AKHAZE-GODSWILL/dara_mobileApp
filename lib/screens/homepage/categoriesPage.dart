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
  const Categories({Key? key}) : super(key: key);

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
          leading: Container(),
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
            child: ListView(
              children: [
                customListWidget(
                    category: "Plumbing",
                    svgImage: "assets/svg/water-tap-black.svg"),
                customListWidget(
                    category: "Car Repairs",
                    svgImage: "assets/svg/automotive-black.svg"),
                customListWidget(
                    category: "Laundry",
                    svgImage: "assets/svg/washing-machine-black.svg"),
                customListWidget(
                    category: "Electrical Works",
                    svgImage: "assets/svg/plug-black.svg"),
                customListWidget(
                    category: "Painting",
                    svgImage: "assets/svg/roller-black.svg"),
                customListWidget(
                    category: "Carpentry",
                    svgImage: "assets/svg/tools-black.svg"),
                customListWidget(
                    category: "Hair Salon",
                    svgImage: "assets/svg/haircut-black.svg"),
                customListWidget(
                    category: "Generator",
                    svgImage: "assets/svg/generator-black.svg"),
                customListWidget(
                    category: "Cleaning",
                    svgImage: "assets/svg/cleaning-black.svg"),
                customListWidget(
                    category: "Gas Refill",
                    svgImage: "assets/svg/gas-cylinder-black.svg"),
                customListWidget(
                    category: "Fumigation",
                    svgImage: "assets/svg/pesticide-black.svg"),
                customListWidget(
                    category: "AC/Refrigerator",
                    svgImage: "assets/svg/air-conditioner-black.svg"),
                customListWidget(
                    category: "Beautification/Makeup",
                    svgImage: "assets/svg/cosmetics-black.svg"),
                customListWidget(
                    category: "Tv repair",
                    svgImage: "assets/svg/television-black.svg"),
                customListWidget(
                    category: "Home renovation",
                    svgImage: "assets/svg/renovation-black.svg"),
                customListWidget(
                    category: "Chef", svgImage: "assets/svg/chef-black.svg"),
                customListWidget(
                    category: "Catering",
                    svgImage: "assets/svg/buffet-black.svg"),
                customListWidget(
                    category: "Logistics/Dispatch",
                    svgImage: "assets/svg/delivery-black.svg"),
                customListWidget(
                    category: "Installation",
                    svgImage: "assets/svg/service-black.svg"),
                customListWidget(
                    category: "Gadget",
                    svgImage: "assets/svg/device-black.svg"),
                customListWidget(
                    category: "Photography/videography",
                    svgImage: "assets/svg/camera-black.svg"),
                customListWidget(
                    category: "Vehicle towing",
                    svgImage: "assets/svg/crane-truck-black.svg"),
                customListWidget(
                    category: "Vulcanizer",
                    svgImage: "assets/svg/vulcan-black.svg"),
                customListWidget(
                    category: "Welder", svgImage: "assets/svg/weld-black.svg"),
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
                  child: SvgPicture.asset(svgImage),
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
