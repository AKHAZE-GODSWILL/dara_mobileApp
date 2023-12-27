import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:dara_app/main.dart';
import 'package:dara_app/screens/authentication/login.dart';
import 'package:dara_app/screens/homepage/Notification.dart';
import 'package:dara_app/screens/homepage/categoriesPage.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/chatHistory.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/daraSupport.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/settings/settingsPage.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/shareApp.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/wallet.dart';
import 'package:dara_app/screens/homepage/expandableWidget.dart';
import 'package:dara_app/screens/homepage/searchScreen.dart';
import 'package:dara_app/screens/homepage/serviceProviderProfile/ServiceProviderAccount.dart';
import 'package:dara_app/utils/apiRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.userType}) : super(key: key);
  final String userType;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int activeIndex = 0;
  bool isConversations = true;
  bool isDrawerOpened = false;
  // bool isLoading = false;
  List<dynamic> posts = [];

  refreshUser(){
    
    setState(() {
      posts = getX.read((widget.userType == "serviceProvider")? constants.GETX_SP_FEEDS:constants.GETX_CLIENT_FEEDS) ?? [];
      // isLoading = true;
    });
    
    reloadUserObject().then((value) {

                            print("The final Value of what was resulted from the request was :$value");

                            if(value["status"]== true){
                              setState(() {
                                getX.write((widget.userType == "serviceProvider")? constants.GETX_SP_FEEDS:constants.GETX_CLIENT_FEEDS, value["user_object"]["posts"]);
                                posts = value["user_object"]["posts"];
                                print(posts);
                              });
                              
                            }
                            else if(value["status"] == "Network Error"){
                              mywidgets.displayToast(msg: "Network Error. Check your Network Connection and try again");
                            }
                            else{
                              mywidgets.displayToast(msg: value["message"]);
                            }

                            setState(() {
                              // isLoading = false;
                            });
                          });
  }

  @override
  void initState() {
    print("The init state");
    refreshUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context, listen: true);
    return Scaffold(
       key: _scaffoldKey,
      drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              // color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                                          imageUrl: (provider.userType== "serviceProvider")? provider.sp_profile_image!:provider.client_profile_image!,
                                          imageBuilder: (context, imageProvider) => Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider, fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) => CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => Icon(Icons.person,
                                         size: 50, color:Colors.grey),
                                          ),

                Row(
                  children: [
                    Text((provider.userType == "serviceProvier")?
                      "${provider.sp_first_name} ${provider.sp_last_name}":"${provider.client_first_name} ${provider.client_last_name}",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
                    ),

                    SvgPicture.asset("assets/svg/verified-badge.svg")
                  ],
                ),

                Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/ranking.svg"),
                  Text(" Rising Star", style: GoogleFonts.inter(
                      color: Color(0xFFf97315),
                      fontWeight: FontWeight.bold,
                      fontSize: 10
                      ),)
                ],
              ),
              height: 24,
              width: 85,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFf97315)),
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            SizedBox(height: 5,),

            InkWell(
              onTap: (){

                if(provider.userType == "serviceProvider"){
                  provider.setUserType(userTier: "client");
                }
                else{
                  provider.setUserType(userTier: "serviceProvider");
                }

                Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => Login()),
                                (route) => false,
                              );
              },
              child: Text(
                       (provider.userType == "serviceProvider")? "Use Dara as client":"Use Dara as a Service Provider",
                        style: GoogleFonts.inter(
                          color: constants.appMainColor,
                          fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
              ],
            )
          ),
          ListTile(
            leading: SvgPicture.asset("assets/svg/wallet.svg"),
            title: Text((provider.userType == "serviceProvider")? 'Wallet':'Wallet (Available Soon)', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)
              ),
            onTap: () {
                (provider.userType == "serviceProvider")? Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return WalletPage();
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        )
                      ):();
            },
          ),
          ListTile(
            leading: SvgPicture.asset("assets/svg/chat-history.svg"),
            title: Text('Chat History', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)),
            onTap: () {
              
              // Navigator.pop(context); // Close the drawer
              Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return ChatHistory();
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
          ),
          ListTile(
            leading: SvgPicture.asset("assets/svg/settings.svg"),
            title: Text('Settings', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)),
            onTap: () {
              
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return Settings();
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
          ),

          ListTile(
            leading: SvgPicture.asset("assets/svg/support.svg"),
            title: Text('Support', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)),
            onTap: () {
              // Add your settings page navigation logic here
              
              Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return DaraSupport();
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
          ),

          Divider(),

          ListTile(
            leading: SvgPicture.asset("assets/svg/share.svg"),
            title: Text('Share the App', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)),
            onTap: () {
              Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return ShareApp();
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
          ),

          ListTile(
            leading: SvgPicture.asset("assets/svg/about-us.svg"),
            title: Text('About Us', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)),
            onTap: () {
              // Add your settings page navigation logic here
              Navigator.pop(context); // Close the drawer
            },
          ),

          ListTile(
            leading:  SvgPicture.asset("assets/svg/logout.svg"),
            title: Text('Log Out', style: GoogleFonts.inter(
              fontSize: 12,fontWeight:FontWeight.bold)),
            onTap: () {

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => Login()),
                  (route) => false,
                );
            },
          ),
        ],


      ),
    ),
      body:(posts.length == 0)? Center(child: Text("No Feeds yet")):Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 8, right: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap:(){
                      
                      print("The Open drawer button clicked");
                      // Scaffold.of(context).openDrawer();
                      _scaffoldKey.currentState?.openDrawer();
                      
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: 
                      // CircleAvatar(
                      //   radius: 25,
                      //   backgroundImage: AssetImage("assets/profile.png"),
                      // ),

                       CachedNetworkImage(
                                          imageUrl: (provider.userType== "serviceProvider")? provider.sp_profile_image!:provider.client_profile_image!,
                                          imageBuilder: (context, imageProvider) => Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider, fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) => CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => Icon(Icons.person,
                                         size: 50, color:Colors.grey),
                        ) 
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (provider.userType == "serviceProvider")? "Hi ${provider.sp_first_name}!": "Hi ${provider.client_first_name}!",
                        style:
                            GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            PhosphorIcons.map_pin,
                            color: Color(0XFF374151),
                            size: 18,
                          ),
                          Text(
                            "Lagos Nigeria",
                            style: GoogleFonts.inter(fontSize: 13, color: Color(0XFF374151)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),

                  (provider.userType == "client")? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: (){
                          Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return SearchPage();
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
                      child: Container(
                              height: 48,
                              width: 48,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: Colors.black12)),
                              child: SvgPicture.asset("assets/svg/search.svg"),
                        ),
                    ),
                  )
                    :SizedBox(),



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
                              style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
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

            SizedBox(height: (provider.userType == "client")? 5 :0,),

          (provider.userType == "client")? Stack(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.95,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     !isConversations? InkWell(
                        onTap: (){
                          setState(() {
                            isConversations = true;
                          });
                          print("first");
                        },
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.425,
                            height: 50,
                            child: Center(child: Text("Conversations", 
                              style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight:FontWeight.bold
                              )
                            ),),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color:  Color(0xFFf3f4f6)
                            ),
                          ),
                        ),
                      ):Container(),
                      isConversations? InkWell(
                        onTap: (){
                          print("second");
                          setState(() {
                            isConversations = false;
                          });
                        },
                        child: Center(
                          child: Container(
                            child: Center(child: Text("Explore",
                              style: GoogleFonts.inter(
                                color:Colors.black,
                                fontSize: 14,
                                fontWeight:FontWeight.bold  
                              ),
                            ),),
                            width: MediaQuery.of(context).size.width*0.425,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color:  Color(0xFFf3f4f6)
                            ),
                          ),
                        ),
                      ):Container()
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color:  Color(0xFFf3f4f6)
                  ),
                ),
              ),
              AnimatedAlign(
                alignment: isConversations ? Alignment.centerLeft : Alignment.centerRight,
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  margin: EdgeInsets.only(top: 5, left: 15, right: 15),
                  width: MediaQuery.of(context).size.width*0.45,
                  height: 40,
                  child: Center(
                    child: Text(isConversations?"Conversations":"Explore",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight:FontWeight.bold),),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: constants.appMainColor,
                  ),
                ),
              ),

            ],
          ):SizedBox(),

          SizedBox(height: (provider.userType == "client")? 10 :0,),

         (provider.userType == "serviceProvider")? Container(
            height: MediaQuery.of(context).size.height*0.746,
            child:ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context,index){
              return expandableWidget(postIndex: index);
            }),
          )
          
          :(isConversations == true )? Container(
            height: MediaQuery.of(context).size.height*0.68,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context,index){
              return expandableWidget(postIndex: index);
            }),
          ) 
          
          ////////////////////////////////////////// If the explore option is picked this widget should run
          /// this widget should contain a carousel that has different Id's
          /// when ever a carousel is picked, fetch the details from the backend and display. 
          /// Each carousel must have the same specific format
          :Container(
            height: MediaQuery.of(context).size.height*0.68,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              padding: EdgeInsets.zero,
              child: Column(
                children: [

                  SizedBox(height:20),

                  CarouselSlider.builder(
                  options:CarouselOptions(
                  height:134,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds:5),
                  onPageChanged:(index,reason){
                  setState(()=> activeIndex = index);
                  },
                  viewportFraction: 1,
                  enlargeCenterPage:true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height
                  ),
                  itemCount: 3,
                  itemBuilder: (context, index, realIndex){
                    return Padding(
                      padding: const EdgeInsets.only(left:10, right:10, bottom: 5),
                      child: Container(
                        height: 134,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                              color: constants.appMainColor,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                              image: AssetImage("assets/exploreImage.png"),
                              fit: BoxFit.cover)
                            ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 104,
                              width:  160,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Text(
                                    'Get 20% discount on dry cleaning',
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight:FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                          
                                  Text(
                                    'First dry cleaning service of the month',
                                    style: GoogleFonts.inter(
                                      fontSize: 8,
                                      fontWeight:FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                          
                                  InkWell(
                                onTap: (){
                                //   Navigator.of(context).push(
                                //   MaterialPageRoute(builder: (context) => ViewOffers())
                                // );
                                },
                                child: Container(
                                  width: 83,
                                  height: 32,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(200)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Start Now",
                                      style: GoogleFonts.inter(
                                          color:  constants.appMainColor,
                                          fontSize: 14),),
                                  ),
                                ),
                              ),
                                ]
                              )
                            ),
                          )
                        )
                      ),
                    );
                  },
    
                  
    
                  
                ),

              SizedBox(height:10),

              buildIndicator(),

              SizedBox(height:20),


                  Padding(
                    padding: EdgeInsets.all(10),
                    child:Column(
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text(
                              'Top Categories',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight:FontWeight.bold,
                                color: Color(0XFF121212)
                              ),
                            ),

                            InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) {
                                      return Categories();
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
                              child: Container(
                                child: Text(
                                  'View All',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight:FontWeight.bold,
                                    color: Color(0XFF6B7280)
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),

                        SizedBox(height:5),

                        Container(
                          height: 210,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  customCategoryButton(category: "Plumbing", svgImage: "assets/svg/waterTap.svg"),
                                  customCategoryButton(category: "Car Repair", svgImage: "assets/svg/automotive.svg"),
                                  customCategoryButton(category: "Laundry", svgImage: "assets/svg/washing-machine.svg"),
                                ]
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  customCategoryButton(category: "Electrical", svgImage: "assets/svg/plug.svg"),
                                  customCategoryButton(category: "Painting", svgImage: "assets/svg/roller.svg"),
                                  customCategoryButton(category: "Carpentry", svgImage: "assets/svg/tools.svg"),
                                ]
                              ),
                            ]
                          )
                        ),

                        SizedBox(height:40),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal:10),
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text(
                              'Top Rated Service Providers',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight:FontWeight.bold,
                                color: Color(0XFF121212)
                              ),
                            ),

                            Text(
                              'See All',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight:FontWeight.bold,
                                color: Color(0XFF6B7280)
                              ),
                            ),
                          ]
                        ),  
                        ),

                        ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
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
                                            "Plumber",
                                            style: GoogleFonts.inter(fontSize: 12, color: Color(0XFF6B7280)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              "20 Recommended",
                                              style: GoogleFonts.inter(
                                                fontSize: 8, 
                                                fontWeight: FontWeight.bold,
                                                color: Color(0XFF6B7280)),
                                            ),
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
                                            ),
                                          ),
                            
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              "51 Completed Projects",
                                              style: GoogleFonts.inter(
                                                fontSize: 8, 
                                                fontWeight: FontWeight.bold,
                                                color: Color(0XFF6B7280)),
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
                                        style: GoogleFonts.inter(
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


                      ]
                    )
                  )

                ],
              ),
            ),
          ) 


          ],
        ),

    );
  }

  customCategoryButton({ required String category, required String svgImage, Function? action}){
    return Container(
      height: 96,
      width: 104,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0XFFE5E7EB),
          width:2
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 48,
              width: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0XFFEAF1FF),
                shape: BoxShape.circle,
                border: Border.all(
                  width:2,
                  color: constants.appMainColor
                )
              ),
              child: SvgPicture.asset(svgImage),
            ),
      
            Text(
              category,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight:FontWeight.bold,
                color: Color(0XFF121212)
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        
        activeIndex: activeIndex,
        count: 3,

        effect: WormEffect(
          dotWidth: 10,
          dotHeight:10,
          activeDotColor: constants.appMainColor,
          dotColor: Colors.black12
        ),


  );

  Widget expandableWidget ({required postIndex}){
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
                                  Map<dynamic, dynamic> user = {
                                    "first_name": posts[postIndex]["author_name"],
                                    "last_name": "",
                                    "user_id": posts[postIndex]["user_id"]
                                  };
                                  Navigator.push(context,MaterialPageRoute(
                                    builder: (context)=> ServiceProviderAccount(user: user ))
                                );
                                },
                                child: CachedNetworkImage(
                                          imageUrl: posts[postIndex]["author_image"],
                                          imageBuilder: (context, imageProvider) => Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider, fit: BoxFit.cover),
                                            ),
                                          ),
                                          placeholder: (context, url) => CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => Icon(Icons.person,
                                         size: 50, color:Colors.grey),
                        )
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  posts[postIndex]["author_name"],
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
                        // width: MediaQuery.of(context).size.width*0.72,
                        alignment: Alignment.center,
                        child: ReadMoreText(
                          posts[postIndex]["body"],
                          style: GoogleFonts.inter(fontSize:12, color:Colors.black),
                          trimCollapsedText: "See More",
                          trimExpandedText:"See Less",
                          trimLines: 3,
                          trimMode: TrimMode.Line,
                          callback: (val) {
                          },
                        )
                        
                        // Text(posts[postIndex]["body"],
                        //     maxLines: maxLineNumber,
                        //     overflow: TextOverflow.ellipsis,
                        //     style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                        // ),
                      ),
                      
                      (posts[postIndex]["media"] == "null" || posts[postIndex]["media"] == "[]")? SizedBox() 
                    :Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 290,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                                          imageUrl: posts[postIndex]["media"],
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
                                          //   child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => Icon(Icons.person,
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
                                Icon(PhosphorIcons.heart, color: Colors.black,),
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

//  void justPlaying(){

//   }
}
