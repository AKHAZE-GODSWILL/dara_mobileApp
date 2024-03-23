import 'dart:io';
import 'dart:async';
import 'package:dara_app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class EditPost extends StatefulWidget {
  EditPost(
      {Key? key,
      required this.mediaType,
      required this.mediaPath,
      this.type,
      this.index,
      this.deletePost})
      : super(key: key);
  final String mediaType;
  final String? mediaPath;
  final String? type;
  final int? index;
  final Function? deletePost;
  State<EditPost> createState() => _EditPost();
}

class _EditPost extends State<EditPost> {
  late VideoPlayerController videoPlayerController;
  bool isPlaying = false;

  int maxDuration = 30; // Maximum duration in seconds
  int elapsedDuration = 0; // To track elapsed time
  Timer? timer;

  @override
  void initState() {
    if (widget.type == null) {
      (widget.mediaType == "video")
          ? videoPlayerController =
              VideoPlayerController.file(File(widget.mediaPath!))
          : ();

      (widget.mediaType == "video")
          ? videoPlayerController.initialize().then((value) {
              videoPlayerController.setVolume(1);
            })
          : ();
    } else {
      (widget.mediaType == "video")
          ? videoPlayerController = VideoPlayerController.networkUrl(
              Uri.parse(widget.mediaPath.toString()))
          : ();

      (widget.mediaType == "video")
          ? videoPlayerController.initialize().then((value) {
              videoPlayerController.setVolume(1);
            })
          : ();
    }

    super.initState();
  }

  @override
  void dispose() {
    (widget.mediaType == "video") ? videoPlayerController.dispose() : ();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (widget.mediaType == "image") {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 0.8,
                    child:
                        Image.file(File(widget.mediaPath!), fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              widget.index == null
                  ? SizedBox()
                  : Container(
                      height: 91,
                      width: 64,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              widget.deletePost!(
                                  mdType: widget.mediaType,
                                  index: widget.index);
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 64,
                              width: 64,
                              decoration: BoxDecoration(
                                  color: constants.appMainColor,
                                  shape: BoxShape.circle),
                              child: Icon(
                                PhosphorIcons.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Remove",
                            style: GoogleFonts.inter(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
            ],
          ),
        ),
      );
    } else if (widget.mediaType == "video") {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        backgroundColor: Colors.black,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 0.8,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 300,
                                child: VideoPlayer(videoPlayerController))
                          ],
                        ),
                        Center(
                          child: IconButton(
                              onPressed: () {
                                if (isPlaying) {
                                  videoPlayerController.pause();
                                } else {
                                  videoPlayerController.play();

                                  timer = Timer.periodic(Duration(seconds: 1),
                                      (timer) {
                                    if (elapsedDuration >= maxDuration) {
                                      // Stop the video when the maximum duration is reached
                                      videoPlayerController.pause();
                                      videoPlayerController
                                          .seekTo(Duration.zero);
                                      setState(() {
                                        elapsedDuration = 0;
                                        isPlaying = false;
                                      });
                                      timer.cancel();
                                    } else {
                                      elapsedDuration++;
                                    }
                                  });
                                }

                                setState(() {
                                  isPlaying = !isPlaying;
                                });
                              },
                              icon: isPlaying
                                  ? Icon(
                                      Icons.pause_circle,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.play_circle,
                                      size: 50,
                                    )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              widget.index == null
                  ? SizedBox()
                  : Container(
                      height: 91,
                      width: 64,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              widget.deletePost!(
                                  mdType: widget.mediaType,
                                  index: widget.index);
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 64,
                              width: 64,
                              decoration: BoxDecoration(
                                  color: constants.appMainColor,
                                  shape: BoxShape.circle),
                              child: Icon(
                                PhosphorIcons.trash,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Remove",
                            style: GoogleFonts.inter(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Text("Error happened somewhere"),
      );
    }
  }
}
