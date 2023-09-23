import 'package:dara_app/screens/homepage/home.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:svg_flutter/svg.dart';

import '../../Provider/DataProvider.dart';
import '../home/homePage.dart';
import 'Account/AccountMain.dart';
import 'Offers.dart';
import 'Projects.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';

class Bottombar extends StatefulWidget {
  final initial;

  Bottombar({this.initial});

  @override
  _BottombarState createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  PageController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = PageController(
        viewportFraction: 1,
        initialPage: widget.initial == null ? 0 : widget.initial);
  }

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // DataProvider dataProvider =
    //     Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      body: pageIndex == 0
          ? HomePage()
          : pageIndex == 1
              ? Offers()
              : pageIndex == 2
                  ? Container()
                  : pageIndex == 3
                      ? Projects()
                      : AccountMain(),
      bottomNavigationBar: buildMyNavBar(context,

          // dataProvider
      ),
    );
  }

  BottomNavigationBar buildMyNavBar(
      BuildContext context
      // DataProvider dataProvider
      ) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
          // dataProvider.setValue(index);
        },
        enableFeedback: false,
        useLegacyColorScheme: false,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.black38),
        unselectedLabelStyle: TextStyle(color: Colors.black38),
        fixedColor: Colors.black38,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/homeBold.svg"),
            activeIcon: SvgPicture.asset("assets/svg/homeOutline.svg"),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/noteBold.svg"),
              activeIcon: SvgPicture.asset("assets/svg/noteOut.svg"),
              label: "Offers"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/postOut.svg"), label: "Post"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/projectOut.svg"),
              activeIcon: SvgPicture.asset("assets/svg/project.svg"),
              label: "Projects"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/profile.svg"),
              activeIcon:  SvgPicture.asset("assets/svg/profileOut.svg"),
              label: "Account"),
        ]);
  }
}
