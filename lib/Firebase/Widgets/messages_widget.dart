import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dara_app/Provider/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Firebase_service.dart';
import '../Model/Message.dart';
import '../Utils/colors.dart';
import '../Utils/utils.dart';
import 'message_widget.dart';

class MessagesWidget extends StatefulWidget {
  final String idUser;
  final user;

  const MessagesWidget({
    this.user,
    required this.idUser,
  });

  @override
  _MessagesWidgetState createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  var chats;
  @override
  void initState() {
    var utils = Provider.of<DataProvider>(context, listen: false);
    super.initState();
    chats = FirebaseApi.getMessages(
        widget.idUser,
        '${utils.userId}-${widget.user.id}',
        '${widget.user.id}-${utils.userId}');
    // FirebaseApi.changeIndividualReadChats();
    // utils.changeIndividualReadChats();
  }

  @override
  Widget build(BuildContext context) {
    var utils = Provider.of<DataProvider>(context, listen: false);
    return Container(
      child: StreamBuilder(
        stream: chats,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List<Message> messageData;
          if (snapshot.hasData) {
            FirebaseApi.changeIndividualReadChats();
            messageData = snapshot.data!.docs
                .map((doc) => Message.fromMap(doc.data(), doc.id))
                .toList();
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: Theme(
                      data: Theme.of(context)
                          .copyWith(hintColor: messagesendercontainercolor),
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(messagesendercontainercolor),
                        strokeWidth: 2,
                        backgroundColor: Colors.white,
                      )),
                );
              default:
                if (snapshot.hasError) {
                  return buildText('Something Went Wrong Try later');
                } else {
                  final messages = messageData;
                  if (messages.isEmpty) {
                    return buildText('Say Hi!');
                  } else
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        //final message = messages;
                        return MessageWidget(
                          message: messages[index],
                          snapshot: snapshot.data!.docs[index],
                          isMe: messages[index].idUser == utils.userId,
                        );
                      },
                      // optional
                      // floatingHeader: true, // optional
                    );
                }
            }
          } else {
            return Center(
              child: Theme(
                  data: Theme.of(context)
                      .copyWith(hintColor: messagesendercontainercolor),
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(messagesendercontainercolor),
                    strokeWidth: 2,
                    backgroundColor: Colors.white,
                  )),
            );
          }
        },
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}
