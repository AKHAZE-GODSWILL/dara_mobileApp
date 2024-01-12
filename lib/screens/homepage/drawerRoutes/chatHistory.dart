import '../../chat/Chat.dart';
import 'package:intl/intl.dart';
import 'package:dara_app/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Provider/DataProvider.dart';
import 'package:dara_app/utils/constants.dart';
import '../../../Firebase/Model/UserChat.dart';
import '../../../Firebase/Firebase_service.dart';
import 'package:dara_app/Firebase/Model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:dara_app/screens/homepage/drawerRoutes/chat/chatPage.dart';

class ChatHistory extends StatefulWidget {
  const ChatHistory({Key? key}) : super(key: key);

  @override
  State<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  bool isOnline = true;
  List<UserChat>? user;

  formatTime(DateTime now) {
    final DateFormat formatter = DateFormat().add_jm();
    final String formatted = formatter.format(now);
    return formatted;
  }

  formatYear(DateTime now) {
    final DateFormat formatter = DateFormat('dd/MM/yy');
    final String formatted =
        formatter.format(now == null ? DateTime.now() : now);
    return formatted;
  }

  compareDate(DateTime date) {
    if (date == null) {
      return '...';
    } else if (date.difference(DateTime.now()).inHours.abs() <= 24) {
      var value = formatTime(date);
      return value;
    } else if (date.difference(DateTime.now()).inHours.abs() >= 24 &&
        date.difference(DateTime.now()).inHours.abs() <= 48) {
      return 'yesterday';
    } else {
      var value = formatYear(date);
      return value;
    }
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.black38),
          textAlign: TextAlign.center,
        ),
      );

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
    var utils = Provider.of<DataProvider>(context, listen: true);
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
                    "Chat History",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
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
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(width: 1, color: Colors.grey)),
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
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextFormField(
                            // focusNode: textNode,
                            onChanged: (value) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.text,
                            // controller: firstNameController,

                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                gapPadding: 0,
                                borderSide: BorderSide
                                    .none, // Remove the border when focused
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide
                                    .none, // Remove the border when enabled
                              ),
                              hintText: "Search",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                  stream: FirebaseApi.userChatStream(
                      (utils.userType == "serviceProvider"
                          ? utils.sp_user_id
                          : utils.client_user_id)),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      user = snapshot.data?.docs
                          .map((doc) => UserChat.fromMap(doc.data(), doc.id))
                          .toList();
                      List<UserChat> chatData = [];
                      for (var v in user!) {
                        chatData.add(v);
                      }
                      chatData
                        ..sort((b, a) =>
                            a.lastMessageTime.compareTo(b.lastMessageTime));
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: Theme(
                                data: Theme.of(context).copyWith(
                                    hintColor: Constants().appMainColor),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Constants().appMainColor),
                                  strokeWidth: 2,
                                  backgroundColor: Colors.white,
                                )),
                          );
                        default:
                          if (snapshot.hasError) {
                            return buildText('Something Went Wrong Try later');
                          } else {
                            final users = chatData;
                            if (users.isEmpty) {
                              return buildText('No Users Found');
                            } else
                              return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: users.length,
                                  itemBuilder: (context, index) {
                                    var date = compareDate(
                                        users[index].lastMessageTime);

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, right: 4, top: 1, bottom: 1),
                                      child: Container(
                                          margin: EdgeInsets.all(5),
                                          height: 80,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              Center(
                                                  child: CustomChatCard(
                                                      users[index], date))
                                            ],
                                          )),
                                    );
                                  });
                          }
                      }
                    } else {
                      return Center(
                        child: Theme(
                            data: Theme.of(context)
                                .copyWith(hintColor: Constants().appMainColor),
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Constants().appMainColor),
                              strokeWidth: 2,
                              backgroundColor: Colors.white,
                            )),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  CustomChatCard(UserChat user, date) {
    // mywidgets.displayToast(msg: "${user.lastMessage}");
    return InkWell(
      onTap: () {
        var utils = Provider.of<DataProvider>(context, listen: false);
        FirebaseApi.updateUsertoRead(
            idUser: user.idUser,
            idArtisan: utils.userType == "serviceProvider"
                ? utils.sp_user_id
                : utils.client_user_id);

        // if (users[index].fcmToken.toString() !=
        //     data.fcmToken) {
        //   FirebaseApi.updateUserFCMToken(
        //     idUser: users[index].idUser,
        //     idArtisan: userId,
        //     token: data.fcmToken,
        //   );
        // }

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ChatPage(
                support: true,
                newchat: true,

                // shipments: shipment,
                // pickup: shipment.pickup,
                // dropoff:shipment.dropoff,
                productSend: true,
                user: user);
          },
        ));
        // print(user.isOnline);
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) => ChatPage()
        // ));
      },
      child: ListTile(
          leading: Container(
            width: 52,
            height: 52,
            child: Stack(children: [
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
              isOnline
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 7.3,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    )
                  : Positioned(
                      top: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 7.3,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    )
            ]),
          ),
          title: Text(
            "${user.name}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
          subtitle: Text(
            user.lastMessage.toString().isEmpty || user.lastMessage == null
                ? 'No Message Yet'
                : user.lastMessage.toString(),
            style: TextStyle(
                color: user.read == true ? Colors.grey : Colors.black,
                fontSize: 13,
                fontWeight: user.read == true ? null : FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            children: [
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // user.seen == false?
              CircleAvatar(
                  radius: 10,
                  backgroundColor: constants.appMainColor,
                  child: Text("2", style: TextStyle(color: Colors.white)))
            ],
          )),
    );
  }
}
