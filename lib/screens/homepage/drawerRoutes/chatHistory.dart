
import 'package:dara_app/main.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/chat/chatPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatHistory extends StatefulWidget {
  const ChatHistory({Key? key}) : super(key: key);

  @override
  State<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {

  bool isOnline = true;

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
                    "Chat History",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
        ),
        actions: [
          
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.black12)),
                        child: Container(
                            child: Transform.scale(
                                scale: 0.5,
                                child: SvgPicture.asset("assets/svg/more.svg")))),
                  )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey
                    )
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 48,
                        width: 52,
                        alignment: Alignment.center,
                        child: SvgPicture.asset("assets/svg/search.svg"),
                      ),

                      Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width*0.75,
                        child: TextFormField(
                            // focusNode: textNode,
                            onChanged: (value){
                          setState(() {
                            
                          });
                        },
                            keyboardType: TextInputType.text,
                            // controller: firstNameController,
                            
                            decoration: InputDecoration(
                              focusedBorder:OutlineInputBorder(
                            gapPadding: 0,
                            borderSide: BorderSide.none, // Remove the border when focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none, // Remove the border when enabled
                          ),
                              hintText: "Search",
                            ),
                          ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ListView.builder(

                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:  10, 
                     // usersList.length,
                     itemBuilder: (context, index){
                      return Padding(
                      
                       padding: const EdgeInsets.only(left: 4, right:4, top:1, bottom:1),
                       child: Container(
                        margin: EdgeInsets.all(5),
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Center(
                              child: CustomChatCard()
                            )       
                          ],
                        )
                       ),
                     );}
                  ),
            ],
          ),
        ),
      )
    );
  }

  CustomChatCard(){
    return InkWell(

              onTap: (){
                    // print(user.isOnline);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ChatPage()
                    ));
              },

              child: ListTile(
                            leading: Container(

                              width: 52,
                              height: 52,
                              child: Stack(
                                children:[
                                   Center(
                                     child: Container(
                                                        
                                  
                                     width: 48,
                                     height: 48,
                                     decoration: BoxDecoration(
                                        // color: constants.appMainColor ,
                                        // borderRadius: BorderRadius.circular(15)
                                     ),
                                                            
                                     child: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage("assets/profile.png"),
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.white,
                                              ),
                                     
                                     
                                    //  user.img== "" ? Icon(Icons.person,
                                    //                       size: 24, color: Colors.white)  
                                    //       :CachedNetworkImage(
                                    //       imageUrl: user.img,
                                    //       imageBuilder: (context, imageProvider) => Container(
                                    //         width: 48,
                                    //         height: 48,
                                    //         decoration: BoxDecoration(
                                    //           borderRadius: BorderRadius.circular(15),
                                    //           image: DecorationImage(
                                    //             image: imageProvider, fit: BoxFit.cover),
                                    //         ),
                                    //       ),
                                    //       placeholder: (context, url) => CircularProgressIndicator(),
                                    //       errorWidget: (context, url, error) => Icon(Icons.error),
                                    //       ) ,
                                                        
                                ),
                                   ),

                               isOnline? Positioned(
                                  top: 0,
                                  right:0,
                                  child: CircleAvatar(
                                    radius: 7.3,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.green,
                                    ),
                                  ),
                                )
                                :Positioned(
                                  top: 0,
                                  right:0,
                                  child: CircleAvatar(
                                    radius: 7.3,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.grey,
                                    ),
                                  ),
                                )
                                ]
                              ),
                            ),
                        
                            title:Text("Daniel Smith",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),),
                        
                            subtitle: 
                            Text("Perfect! will see into it",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                                ),),
                        
                            trailing: Column(
                              children: [

                                Text("08:44 pm",
                                style:TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                                ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                                ,
                                // user.seen == false?
                                CircleAvatar(
                                  radius:10,
                                  backgroundColor: constants.appMainColor ,
                                  child: Text("2", 
                                    style: TextStyle(color: Colors.white)
                                  )
                                )
                              ],
                            )
                            ) ,
          );
  }
}
