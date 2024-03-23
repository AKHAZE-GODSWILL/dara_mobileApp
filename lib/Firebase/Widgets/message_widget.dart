import 'dart:io';
import 'dart:async';
import '../Utils/utils.dart';
import '../Utils/colors.dart';
import '../Model/Message.dart';
import '../Utils/Provider.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dara_app/Firebase/Widgets/photoView.dart';
import 'package:dara_app/Firebase/Widgets/recordPlayer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class MessageWidget extends StatefulWidget {
  MessageWidget(
      {Key? key,
      required this.message,
      required this.isMe,
      required this.snapshot})
      : super(key: key);

  final Message message;
  final bool isMe;
  final QueryDocumentSnapshot snapshot;
  State<MessageWidget> createState() => _MessageWidget();
}

class _MessageWidget extends State<MessageWidget> {
  late AudioPlayer _audioPlayer;
  String recordingPath = "";
  bool isPlaying = false;
  bool isDownloading = false;
  double _sliderValue = 0.0;
  double audioDuration = 0.0;
  double currentDuration = 0.0;
  late Timer sliderUpdateTimer;

  initializeSound() {
    //
    _audioPlayer = AudioPlayer();
    _audioPlayer.setSourceUrl(widget.message.message!).then((value) {
      _audioPlayer.getDuration().then((value) {
        setState(() {
          audioDuration = value!.inSeconds.toDouble();
        });
      });
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        audioDuration = duration.inSeconds.toDouble();
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      // Add your action here, for example, showing a message when the audio is completed.
      // You can also reset the slider and isPlaying state, or perform any other desired action.
      setState(() {
        _sliderValue = 0.0;
        isPlaying = false;
      });
    });

    // Create a timer to update the slider value every 1 second
    sliderUpdateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _audioPlayer.getCurrentPosition().then((value) {
        setState(() {
          currentDuration = value?.inSeconds.toDouble() ?? 0.0;
          _sliderValue = currentDuration;
        });
      });
    });
  }

  // initRecording() async{
  //  Directory appDirectory =  await getApplicationDocumentsDirectory();
  //  recordingPath = appDirectory.path+'/'+DateTime.now().millisecondsSinceEpoch.toString() +
  //       '.aac';
  // }

  @override
  void initState() {
    // TODO: implement initState

    ////////////////////

    _audioPlayer = AudioPlayer();
    initializeSound();
    // initRecording();
    // downloadAudioFromFirebaseStorage(widget.message.message!, recordingPath!).then((value) {
    //   initializeSound();
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 15,
          ),
          !widget.isMe
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
    var date = data.compareDateChat(widget.message.createdAt);
    return Column(
      children: [
        Bubble(
          color: Color(0xFFF3F4F6),
          radius: Radius.circular(7),
          child: Column(
            crossAxisAlignment:
                widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              widget.message.message!.contains('https://') ||
                      widget.message.message!.contains('http://')
                  ? datas.categorizeUrl(widget.message.message.toString()) ==
                          'image'
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Hero(
                            tag: widget.message.message.toString(),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return PhotoView(
                                        widget.message.message,
                                        widget.message.message,
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
                                      widget.message.message.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : datas.categorizeUrl(
                                  widget.message.message.toString()) ==
                              'audio'
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return AudioApp(
                                          url: widget.message.message,
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
                              child: Row(
                                children: [
                                  Hero(
                                      tag: widget.message.message.toString(),
                                      child: Icon(
                                        Icons.play_circle_filled,
                                        size: 35,
                                        color: Colors.white,
                                      )),
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      inactiveTrackColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      trackShape: RoundedRectSliderTrackShape(),
                                      trackHeight: 5.0,
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 12.0),
                                      thumbColor:
                                          Color.fromARGB(255, 160, 182, 255),
                                      overlayColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      overlayShape: RoundSliderOverlayShape(
                                          overlayRadius: 15.0),
                                      tickMarkShape: RoundSliderTickMarkShape(),
                                      activeTickMarkColor:
                                          Color.fromARGB(255, 254, 254, 254),
                                      inactiveTickMarkColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      valueIndicatorShape:
                                          PaddleSliderValueIndicatorShape(),
                                      valueIndicatorColor:
                                          Color.fromARGB(255, 160, 182, 255),
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
                                      widget.message.message.toString()) ==
                                  'doc'
                              ? InkWell(
                                  onTap: () {
                                    data.opeLink(widget.message.message);
                                  },
                                  child: Tab(
                                    text: 'Open this Document/Download',
                                    icon: Icon(
                                      FontAwesomeIcons.file,
                                      size: 40,
                                    ),
                                  ))
                              : datas.categorizeUrl(
                                          widget.message.message.toString()) ==
                                      'link'
                                  ? Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child: InkWell(
                                        onTap: () {
                                          data.opeLink(widget.message.message);
                                        },
                                        child: Text(
                                          widget.message.message.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: widget.isMe
                                                  ? Colors.black
                                                  : Colors.black),
                                          textAlign: widget.isMe
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
                          widget.message.productImage == null ||
                                  widget.message.productImage!.isEmpty
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Hero(
                                    tag: widget.message.message.toString(),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return PhotoView(
                                                widget.message.productImage,
                                                widget.message.productImage,
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
                                              widget.message.productImage
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
                            widget.message.message.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                color:
                                    widget.isMe ? Colors.black : Colors.black),
                            textAlign: widget.isMe
                                ? TextAlign.end
                                : TextAlign
                                    .start, ////////////////////////////////////////////////////
                          ),
                        ],
                      ),
                    ),

              ////////////////////
              widget.message.read == true &&
                      !widget.snapshot.metadata.hasPendingWrites
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                  : widget.message.read == false &&
                          widget.snapshot.metadata.hasPendingWrites
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                          mainAxisAlignment: MainAxisAlignment.end,
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
          ),
        ),
      ],
    );
  }

  Widget buildMessageSender(context) {
    var data = Provider.of<Utils>(context, listen: false);
    var datas = Provider.of<DataProviders>(context, listen: false);
//    var date = data
//        .formatTime(message.createdAt);
    var date = data.compareDateChat(widget.message.createdAt);
    return Column(
      children: [
        Bubble(
          radius: Radius.circular(7),
          color: messagesendercontainercolor,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: widget.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: <Widget>[
                  widget.message.message!.contains('https://') ||
                          widget.message.message!.contains('http://')
                      ? datas.categorizeUrl(
                                  widget.message.message.toString()) ==
                              'image'
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Hero(
                                tag: widget.message.message.toString(),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return PhotoView(
                                            widget.message.message,
                                            widget.message.message,
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
                                          widget.message.message.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : datas.categorizeUrl(
                                      widget.message.message.toString()) ==
                                  'audio'
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return AudioApp(
                                              url: widget.message.message
                                                  .toString(),
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
                                  child: Row(
                                    children: [
                                      Hero(
                                          tag:
                                              widget.message.message.toString(),
                                          child: Icon(
                                            Icons.play_circle_filled,
                                            size: 30,
                                          )),
                                      SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          inactiveTrackColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          trackShape:
                                              RoundedRectSliderTrackShape(),
                                          trackHeight: 5.0,
                                          thumbShape: RoundSliderThumbShape(
                                              enabledThumbRadius: 12.0),
                                          thumbColor: Color.fromARGB(
                                              255, 160, 182, 255),
                                          overlayColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          overlayShape: RoundSliderOverlayShape(
                                              overlayRadius: 15.0),
                                          tickMarkShape:
                                              RoundSliderTickMarkShape(),
                                          activeTickMarkColor: Color.fromARGB(
                                              255, 254, 254, 254),
                                          inactiveTickMarkColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          valueIndicatorShape:
                                              PaddleSliderValueIndicatorShape(),
                                          valueIndicatorColor: Color.fromARGB(
                                              255, 160, 182, 255),
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
                                          widget.message.message.toString()) ==
                                      'doc'
                                  ? InkWell(
                                      onTap: () {
                                        data.opeLink(widget.message.message);
                                      },
                                      child: Tab(
                                        text: 'Open this Document/Download',
                                        icon: Icon(FontAwesomeIcons.file,
                                            size: 40),
                                      ))
                                  : datas.categorizeUrl(widget.message.message
                                              .toString()) ==
                                          'link'
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                          child: InkWell(
                                            onTap: () {
                                              data.opeLink(
                                                  widget.message.message);
                                            },
                                            child: Text(
                                              widget.message.message.toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: widget.isMe
                                                      ? Colors.blue
                                                      : Colors.blue),
                                              textAlign: widget.isMe
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
                                  widget.message.productImage == null ||
                                          widget.message.productImage!.isEmpty
                                      ? Container()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Hero(
                                            tag: widget.message.message
                                                .toString(),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) {
                                                      return PhotoView(
                                                        widget.message
                                                            .productImage,
                                                        widget.message
                                                            .productImage,
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
                                                      widget
                                                          .message.productImage
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
                                    widget.message.message.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        color: widget.isMe
                                            ? messagesendertextcolor
                                            : messagesendertextcolor),
                                    textAlign: widget.isMe
                                        ? TextAlign.end
                                        : TextAlign.start,
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
              widget.message.read == true &&
                      !widget.snapshot.metadata.hasPendingWrites
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
                  : widget.message.read == false &&
                          widget.snapshot.metadata.hasPendingWrites
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              PhosphorIcons.clock,
                              size: 18,
                              color: messagesendercontainercolor,
                            ),
                            Text(
                              " $date",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              PhosphorIcons.check_light,
                              color: Colors.white,
                            ),
                            Text(
                              " $date",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(double seconds) {
    final int s = seconds.toInt() % 60;
    final int m = (seconds ~/ 60) % 60;
    final int h = seconds ~/ 3600;
    return '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Future<void> downloadAudioFromFirebaseStorage(
      String storagePath, String localFilePath) async {
    try {
      final ref = FirebaseStorage.instance.ref(storagePath);
      final File localFile = File(localFilePath);

      await ref.writeToFile(localFile);
    } catch (e) {}
  }
}
