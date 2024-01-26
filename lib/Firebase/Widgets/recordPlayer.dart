import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_service/audio_service.dart';
import 'package:easy_audio_player/widgets/players/basic_audio_player.dart';

class AudioApp extends StatefulWidget {
  String? url;
  AudioApp({this.url});

  @override
  State<AudioApp> createState() => _AudioAppState();
}

class _AudioAppState extends State<AudioApp> {
  ConcatenatingAudioSource? playlist;

  @override
  void initState() {
    super.initState();
    playlist = ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse(widget.url.toString()),
          tag: MediaItem(
              id: '1',
              artUri: Uri.parse('https://usedara.com/assets/logo.png'),
              title: 'Dara Recording'))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Text("")),
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
                    "Dara Record",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Spacer(),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Hero(
                    tag: widget.url.toString(),
                    child: BasicAudioPlayer(
                      playlist: playlist!,
                      autoPlay: true,
                    ),
                  ),
                ))));
  }
}
