import 'package:dara_app/main.dart';
import 'package:dara_app/screens/homepage/Account/clientAccount.dart';
import 'package:dara_app/screens/homepage/createPost.dart';
import 'package:dara_app/screens/homepage/discoverPage.dart';
import 'package:dara_app/screens/homepage/home.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dara_app/Provider/DataProvider.dart';
// import 'package:svg_flutter/svg.dart';
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
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    // DataProvider dataProvider =
    //     Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: pageIndex == 0
          ? HomePage(userType: provider.userType!,)
          : pageIndex == 1
              ? Offers()
              : (pageIndex == 2)? (provider.userType == "serviceProvider")?CreatePost(backToHome: backToHome,): DiscoverPage()
                  : pageIndex == 3
                      ? Projects()
                      : (provider.userType == "serviceProvider")?AccountMain(backToHome: backToHome):ClientAccount(backToHome: backToHome),
      bottomNavigationBar: buildMyNavBar(context,

          // dataProvider
      ),
    );
  }

  BottomNavigationBar buildMyNavBar(
      BuildContext context
      // DataProvider dataProvider
      ) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    
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
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black),

        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black),
        fixedColor: Colors.black38,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/svg/homeBold.svg",color: Colors.black,),
            activeIcon: SvgPicture.asset("assets/svg/homeOutline.svg"),
            label: "Home",
            
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/noteBold.svg",color: Colors.black,),
              activeIcon: SvgPicture.asset("assets/svg/noteOut.svg"),
              label: "Offers"),
          BottomNavigationBarItem(
              icon: (provider.userType == "serviceProvider")? SvgPicture.asset("assets/svg/postOut.svg",color: Colors.black,): SvgPicture.asset("assets/svg/discover.svg",color: Colors.black,),
              activeIcon: (provider.userType == "serviceProvider")? SvgPicture.asset("assets/svg/postOut.svg",color: constants.appMainColor,): SvgPicture.asset("assets/svg/discover-blue.svg"),
              label: (provider.userType == "serviceProvider")? "Post": "Discover",
              ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/projectOut.svg",color: Colors.black,),
              activeIcon: SvgPicture.asset("assets/svg/project.svg"),
              label: "Projects"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/profile.svg",color: Colors.black,),
              activeIcon:  SvgPicture.asset("assets/svg/profileOut.svg"),
              label: "Account"),
        ]);
  }

  void backToHome({required int index}){
    setState(() {
      pageIndex = index;
    });
  }
}
