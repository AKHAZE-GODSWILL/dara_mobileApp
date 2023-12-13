import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dara_app/Firebase/Widgets/photoView.dart';
import 'package:dara_app/Firebase/Widgets/recordPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../Model/Message.dart';
import '../Utils/Provider.dart';
import '../Utils/colors.dart';
import '../Utils/utils.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isMe;
  final QueryDocumentSnapshot snapshot;

  const MessageWidget({
    required this.message,
    required this.isMe,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 15,
          ),
          !isMe
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: buildMessageReceiver(context),
                )
              : Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: buildMessageSender(context),
                ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }

  Widget buildMessageReceiver(context) {
    var data = Provider.of<Utils>(context, listen: false);
    var datas = Provider.of<DataProviders>(context, listen: false);
//    var date = data
//        .formatTime(message.createdAt);
    var date = data.compareDateChat(message.createdAt);
    return Column(
      children: [
        Bubble(
          color: Color(0xFFF4F6FF),
          radius: Radius.circular(7),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              message.message!.contains('https://') ||
                      message.message!.contains('http://')
                  ? datas.categorizeUrl(message.message.toString()) == 'image'
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Hero(
                            tag: message.message.toString(),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return PhotoView(
                                        message.message,
                                        message.message,
                                      );
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                height: 170,
                                width: 250,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.network(
                                      message.message.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : datas.categorizeUrl(message.message.toString()) ==
                              'audio'
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return AudioApp(
                                          kUrl: message.message,
                                          tag: message.message);
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Hero(
                                      tag: message.message.toString(),
                                      child: Icon(
                                        Icons.play_circle_filled,
                                        size: 35,
                                        color: Colors.white,
                                      )),
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: Colors.white,
                                      inactiveTrackColor: Colors.white,
                                      trackShape: RoundedRectSliderTrackShape(),
                                      trackHeight: 5.0,
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 12.0),
                                      thumbColor: Color(0xFFEBCDEB),
                                      overlayColor: Colors.white,
                                      overlayShape: RoundSliderOverlayShape(
                                          overlayRadius: 15.0),
                                      tickMarkShape: RoundSliderTickMarkShape(),
                                      activeTickMarkColor: Colors.white,
                                      inactiveTickMarkColor: Colors.white,
                                      valueIndicatorShape:
                                          PaddleSliderValueIndicatorShape(),
                                      valueIndicatorColor: Color(0xFFEBCDEB),
                                      valueIndicatorTextStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Slider(
                                      value: 0,
                                      onChanged: (double value) {},
                                      min: 0.0,
                                      max: 10.0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : datas.categorizeUrl(message.message.toString()) ==
                                  'doc'
                              ? InkWell(
                                  onTap: () {
                                    data.opeLink(message.message);
                                  },
                                  child: Tab(
                                    text: 'Open this Document/Download',
                                    icon: Icon(FontAwesomeIcons.file, size: 40),
                                  ))
                              : datas.categorizeUrl(
                                          message.message.toString()) ==
                                      'link'
                                  ? Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child: InkWell(
                                        onTap: () {
                                          data.opeLink(message.message);
                                        },
                                        child: Text(
                                          message.message.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: isMe
                                                  ? Colors.blue
                                                  : Colors.blue),
                                          textAlign: isMe
                                              ? TextAlign.end
                                              : TextAlign.start,
                                        ),
                                      ),
                                    )
                                  : Container()
                  : Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          message.productImage == null ||
                                  message.productImage!.isEmpty
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Hero(
                                    tag: message.message.toString(),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return PhotoView(
                                                message.productImage,
                                                message.productImage,
                                              );
                                            },
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 170,
                                        width: 250,
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Image.network(
                                              message.productImage.toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          Text(
                            message.message.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                color: isMe
                                    ? messagereceivertextcolor
                                    : messagereceivertextcolor),
                            textAlign: isMe ? TextAlign.end : TextAlign.start,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        message.read == true && !snapshot.metadata.hasPendingWrites
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    PhosphorIcons.check_light,
                    color: Color(0xFF4F4F4F),
                    // messagesendercontainercolor
                  ),
                  Icon(
                    PhosphorIcons.check_light,
                    color: Color(0xFF4F4F4F),
                    // messagesendercontainercolor
                  ),
                  Text(
                    " $date",
                    style: TextStyle(
                      color: Color(0xFF4F4F4F),
                    ),
                  )
                ],
              )
            : message.read == false && snapshot.metadata.hasPendingWrites
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        PhosphorIcons.clock,
                        size: 18,
                        color: Color(0xFF4F4F4F),
                      ),
                      Text(
                        " $date",
                        style: TextStyle(color: Color(0xFF4F4F4F)),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        PhosphorIcons.check_light,
                        color: Color(0xFF4F4F4F),
                      ),
                      Text(
                        " $date",
                        style: TextStyle(color: Color(0xFF4F4F4F)),
                      )
                    ],
                  )
      ],
    );
  }

  Widget buildMessageSender(context) {
    var data = Provider.of<Utils>(context, listen: false);
    var datas = Provider.of<DataProviders>(context, listen: false);
//    var date = data
//        .formatTime(message.createdAt);
    var date = data.compareDateChat(message.createdAt);
    return Column(
      children: [
        Bubble(
          radius: Radius.circular(7),
          color: messagesendercontainercolor,
          child: Column(
            children: [
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  message.message!.contains('https://') ||
                          message.message!.contains('http://')
                      ? datas.categorizeUrl(message.message.toString()) ==
                              'image'
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Hero(
                                tag: message.message.toString(),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return PhotoView(
                                            message.message,
                                            message.message,
                                          );
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 170,
                                    width: 250,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Image.network(
                                          message.message.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : datas.categorizeUrl(message.message.toString()) ==
                                  'audio'
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return AudioApp(
                                              kUrl: message.message,
                                              tag: message.message);
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Hero(
                                          tag: message.message.toString(),
                                          child: Icon(
                                            Icons.play_circle_filled,
                                            size: 35,
                                          )),
                                      SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: Color(0xFF9B049B),
                                          inactiveTrackColor: Color(0xFF9B049B),
                                          trackShape:
                                              RoundedRectSliderTrackShape(),
                                          trackHeight: 5.0,
                                          thumbShape: RoundSliderThumbShape(
                                              enabledThumbRadius: 12.0),
                                          thumbColor: Color(0xFFEBCDEB),
                                          overlayColor: Color(0xFF9B049B),
                                          overlayShape: RoundSliderOverlayShape(
                                              overlayRadius: 15.0),
                                          tickMarkShape:
                                              RoundSliderTickMarkShape(),
                                          activeTickMarkColor:
                                              Color(0xFF9B049B),
                                          inactiveTickMarkColor:
                                              Color(0xFF9B049B),
                                          valueIndicatorShape:
                                              PaddleSliderValueIndicatorShape(),
                                          valueIndicatorColor:
                                              Color(0xFFEBCDEB),
                                          valueIndicatorTextStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Slider(
                                          value: 0,
                                          onChanged: (double value) {},
                                          min: 0.0,
                                          max: 10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : datas.categorizeUrl(
                                          message.message.toString()) ==
                                      'doc'
                                  ? InkWell(
                                      onTap: () {
                                        data.opeLink(message.message);
                                      },
                                      child: Tab(
                                        text: 'Open this Document/Download',
                                        icon: Icon(FontAwesomeIcons.file,
                                            size: 40),
                                      ))
                                  : datas.categorizeUrl(
                                              message.message.toString()) ==
                                          'link'
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                          child: InkWell(
                                            onTap: () {
                                              data.opeLink(message.message);
                                            },
                                            child: Text(
                                              message.message.toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: isMe
                                                      ? Colors.blue
                                                      : Colors.blue),
                                              textAlign: isMe
                                                  ? TextAlign.end
                                                  : TextAlign.start,
                                            ),
                                          ),
                                        )
                                      : Container()
                      : Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  message.productImage == null ||
                                          message.productImage!.isEmpty
                                      ? Container()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Hero(
                                            tag: message.message.toString(),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) {
                                                      return PhotoView(
                                                        message.productImage,
                                                        message.productImage,
                                                      );
                                                    },
                                                    transitionsBuilder:
                                                        (context,
                                                            animation,
                                                            secondaryAnimation,
                                                            child) {
                                                      return FadeTransition(
                                                        opacity: animation,
                                                        child: child,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 170,
                                                width: 250,
                                                child: Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Image.network(
                                                      message.productImage
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  Text(
                                    message.message.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        color: isMe
                                            ? messagesendertextcolor
                                            : messagesendertextcolor),
                                    textAlign:
                                        isMe ? TextAlign.end : TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Container(
                  //       margin: EdgeInsets.only(left: 5, right: 5),
                  //       height: 3,
                  //       width: 3,
                  //       decoration:
                  //           BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
                  //     ),
                  //     // Text(message.username),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 4.0),
                  //       child: Text(
                  //         date,
                  //         style: TextStyle(color: Colors.lightBlueAccent, fontSize: 13),
                  //         textAlign: TextAlign.end,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
        ),
        message.read == true && !snapshot.metadata.hasPendingWrites
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    PhosphorIcons.check_light,
                    color: messagesendercontainercolor,
                    // messagesendercontainercolor
                  ),
                  Icon(
                    PhosphorIcons.check_light,
                    color: messagesendercontainercolor,
                    // messagesendercontainercolor
                  ),
                  Text(
                    " $date",
                    style: TextStyle(
                      color: messagesendercontainercolor,
                    ),
                  )
                ],
              )
            : message.read == false && snapshot.metadata.hasPendingWrites
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        PhosphorIcons.clock,
                        size: 18,
                        color: messagesendercontainercolor,
                      ),
                      Text(
                        " $date",
                        style: TextStyle(color: messagesendercontainercolor),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        PhosphorIcons.check_light,
                        color: messagesendercontainercolor,
                      ),
                      Text(
                        " $date",
                        style: TextStyle(color: messagesendercontainercolor),
                      )
                    ],
                  )
      ],
    );
  }
}
