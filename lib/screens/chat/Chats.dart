import 'Chat.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Firebase/Utils/utils.dart';
import '../../Provider/DataProvider.dart';
import '../../Firebase/Model/UserChat.dart';
import '../../Firebase/Utils/Provider.dart';
import 'package:get_storage/get_storage.dart';
import '../../Firebase/Firebase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListenIncoming extends StatefulWidget {
  @override
  _ListenIncomingState createState() => _ListenIncomingState();
}

class _ListenIncomingState extends State<ListenIncoming> {
  int index = 0;
  late PageController _myPage;

  @override
  void initState() {
    super.initState();
    _myPage =
        PageController(initialPage: 0, viewportFraction: 1, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Utils>(context, listen: false);
    String? userId =
        Provider.of<DataProvider>(context, listen: false).client_user_id == ""
            ? Provider.of<DataProvider>(context, listen: false).sp_user_id
            : Provider.of<DataProvider>(context, listen: false).client_user_id;
    // GetStorage box = GetStorage();
    // String userId = box.read("userId");

    Widget buildText(String text) => Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.black38),
            textAlign: TextAlign.center,
          ),
        );
    List<UserChat>? user;
    Widget widget = Scaffold(
      appBar: AppBar(
        // backgroundColor: primary,
        centerTitle: true,
        title: Text('Inbox',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        elevation: 0,
      ),
      // backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseApi.userChatStream(userId),
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
              ..sort((b, a) => a.lastMessageTime.compareTo(b.lastMessageTime));
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
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
              default:
                if (snapshot.hasError) {
                  return buildText('Something Went Wrong Try later');
                } else {
                  final users = chatData;
                  if (users.isEmpty) {
                    return buildText('No Users Found');
                  } else
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var date =
                            data.compareDate(users[index].lastMessageTime);

                        return Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(6),
                              border:
                                  Border.all(color: Colors.black26, width: 0.7),
                            ),
                            height: 90,
                            child: Center(
                              child: ListTile(
                                onTap: () async {
                                  // DeliveryMainModel shipment = DeliveryMainModel.fromJson(users[index].shipment);

                                  // users[index].idUser

                                  FirebaseApi.updateUsertoRead(
                                      idUser: users[index].idUser,
                                      idArtisan: userId);

                                  if (users[index].fcmToken.toString() !=
                                      data.fcmToken) {
                                    FirebaseApi.updateUserFCMToken(
                                      idUser: users[index].idUser,
                                      idArtisan: userId,
                                      token: data.fcmToken,
                                    );
                                  }

                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return ChatPage(
                                          support: true,
                                          newchat: true,
                                         
                                          productSend: true,
                                          user: users[index]);
                                    },
                                  ));
                                },
                                leading: InkWell(
                                  onTap: () {
                                
                                  },
                                  child: CircleAvatar(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    radius: 30,
                                    backgroundImage:
                                        users[index].urlAvatar.toString() == ""
                                            ? AssetImage("image/user.png")
                                            : NetworkImage(users[index]
                                                .urlAvatar
                                                .toString()) as ImageProvider,
                                  ),
                                ),
                                title: Text(
                                  users[index].name.toString().capitalize(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    users[index]
                                                .lastMessage
                                                .toString()
                                                .isEmpty ||
                                            users[index].lastMessage == null
                                        ? 'No Message Yet'
                                        : users[index].lastMessage.toString(),
                                    style: TextStyle(
                                        color: users[index].read == true
                                            ? Colors.black54
                                            : Colors.black,
                                        fontWeight: users[index].read == true
                                            ? null
                                            : FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(top: 42.0),
                                  child: Text(date,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black54)),
                                ),
                                //  subtitle:  Text(users[index].lastMessageTime),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: users.length,
                    );
                }
            }
          } else {
            return Center(
              child: Theme(
                  data: Theme.of(context)
                      .copyWith(hintColor: Constants().appMainColor),
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Constants().appMainColor),
                    strokeWidth: 2,
                    backgroundColor: Colors.white,
                  )),
            );
          }
        },
      ),
    );

    return widget;
  }
}
