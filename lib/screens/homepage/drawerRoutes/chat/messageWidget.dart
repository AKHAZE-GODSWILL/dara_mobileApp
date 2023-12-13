
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:dara_app/main.dart';
import 'package:dara_app/models/messageModel.dart';
import 'package:dara_app/screens/homepage/drawerRoutes/chat/viewMedia.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:simple_waveform_progressbar/simple_waveform_progressbar.dart';
import 'package:video_player/video_player.dart';

class MessageCard extends StatefulWidget{
  MessageCard({Key? key, required this.message}):super(key: key);
  final MessageModel message;
  State<MessageCard> createState()=> _MessageCard();

}

class _MessageCard extends State<MessageCard>{
  late VideoPlayerController videoPlayerController;
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  String fileName = "";
  double _sliderValue = 0.0;
  double audioDuration = 0.0;
  double currentDuration = 0.0;
  late Timer sliderUpdateTimer;

  final List<double> values = [];
  
  
  initializeSound(){

    _audioPlayer = AudioPlayer();

    _audioPlayer.setSourceUrl(widget.message.filePath).then((value) {
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
      print('Audio playback completed');
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

  
  @override
  void initState() {

    (widget.message.mediaType=="sound recording")?  initializeSound():();

   (widget.message.mediaType=="video")? videoPlayerController = VideoPlayerController.file(File(widget.message.filePath))
   :();


   (widget.message.mediaType=="video")? videoPlayerController.initialize().then((value) {
    videoPlayerController.setVolume(1);
   }):();

  //  var range = Random();
  //  for(int i = 0; i<100; i++){
  //   values.add(range.nextInt(100)*1.0);
  //  }
    super.initState();
  }

  @override
  void dispose(){

    (widget.message.mediaType=="sound recording")? _audioPlayer.dispose():();
    (widget.message.mediaType=="video")? videoPlayerController.dispose():();
    super.dispose();
  }

  Widget build(BuildContext context){

    if(widget.message.type == "source"&& widget.message.mediaType == "none"){
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: ConstrainedBox(constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width-45,
            
          ),
          
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16),
               topRight: Radius.circular(0),
                bottomLeft: Radius.circular(16),
                 bottomRight:Radius.circular(16) ),),
            color: constants.appMainColor,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 45, right: 10, top: 10, bottom: 25),
                  child: Text(widget.message.message, 
                  
                  style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                    )),
                ),
              Positioned(
                bottom: 4,
                right: 5,
                child: Row(
                  
                  children: [
                    
                      
                      Text("${widget.message.time}",
              
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                    )
                      ),
              
                     SizedBox(width: 4,),
              
                            
                  ],
                ),
              )
              ],
            ),
          ),),
        ),
      );
    }

    else if(widget.message.type == "destination"&& widget.message.mediaType == "none"){
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: ConstrainedBox(constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width-45,
            
          ),
          
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(0),
              
               topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                 bottomRight:Radius.circular(16) ),),
            color: Colors.white,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 45, top: 10, bottom: 25),
                  child: Text("${widget.message.message}", 
                  
                  style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                    )),
                ),
              Positioned(
                bottom: 4,
                left: 10,
                child: Row(
                  
                  children: [
                    
                      
                      Text("${widget.message.time}",
              
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                    )
                      ),
              
                     SizedBox(width: 4,),
              
                            
                  ],
                ),
              )
              ],
            ),
          ),),
        ),
      );
    }

    else if(widget.message.type == "source"&& widget.message.mediaType == "sound recording"){
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: ConstrainedBox(constraints: BoxConstraints(
            maxWidth: 240,
            
          ),
          
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16),
               topRight: Radius.circular(0),
                bottomLeft: Radius.circular(16),
                 bottomRight:Radius.circular(16) ),),
            color: constants.appMainColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (isPlaying) {
                            await _audioPlayer.pause();
                          } else {
                            await _audioPlayer.play(UrlSource(widget.message.filePath));
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        child: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle, color: Colors.white),
                      ),
                      
                      Container(
                        width: 200,
                        height: 20,
                        child: Slider(
                          value: _sliderValue,
                          min: 0.0,
                          max: audioDuration,
                          onChanged: (value) {
                            setState(() {
                              _sliderValue = value;
                              _audioPlayer.seek(Duration(seconds: value.toInt()));
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  
            
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: StreamBuilder<Duration>(
                      stream: _audioPlayer.onDurationChanged,
                      builder: (context, snapshot) {
                        return Text(
                          '${_formatDuration(currentDuration)} / ${_formatDuration(audioDuration)}',
                          style: TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),),
        ),
      );
    }

    // else if(widget.message.type == "destination"&& widget.message.mediaType == "sound recording"){
    //   return;
    // }

    else if(widget.message.type == "source"&& widget.message.mediaType == "image"){
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Container(
            constraints: BoxConstraints(
              minHeight: 150,
              maxWidth: 230
            ),
            // width: MediaQuery.of(context).size.width/1.4,
            decoration: BoxDecoration(
              color: constants.appMainColor,
              borderRadius: BorderRadius.circular(16)
            ),
            child: Column(
              
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ViewMedia(
                        mediaType: widget.message.mediaType, 
                        mediaPath: widget.message.filePath)
                    ));
                  },
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 150,
                      maxHeight: 200,
                      minWidth: 230,
                      maxWidth: 230
                      ),
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                            File(widget.message.filePath),
                            fit: BoxFit.cover),),
                            
                            ),
                ),
                
                
            
               widget.message.message != null? Text("${widget.message.message}",
                    style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                                )
                ): SizedBox(),
              ],

              // Card(
                  
              //     margin: EdgeInsets.all(3),
              //     shape: RoundedRectangleBorder(
              //       borderRadius:BorderRadius.circular(16)
              //     ),
              //     child: Image.file(
              //       File(imgPath),
              //       fit: BoxFit.fill),
              //   ),
            ),
          ),
        ),
      );
    }

    // else if(widget.message.type == "destination"&& widget.message.mediaType == "image"){
    //   return;
    // }

    else if(widget.message.type == "source"&& widget.message.mediaType == "video"){
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Container(
            constraints: BoxConstraints(
              minHeight: 150,
              maxWidth: 230
            ),
            // width: MediaQuery.of(context).size.width/1.4,
            decoration: BoxDecoration(
              color: constants.appMainColor,
              borderRadius: BorderRadius.circular(16)
            ),
            child: Column(
              
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ViewMedia(
                        mediaType: widget.message.mediaType, 
                        mediaPath: widget.message.filePath)
                    ));
                  },
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 150,
                      maxHeight: 200,
                      minWidth: 230,
                      maxWidth: 230
                      ),
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      VideoPlayer(videoPlayerController),
                      Center(
                        child: Icon(Icons.play_circle,size: 50,),
                      )
                    ],
                  ),),
                            
                            ),
                ),
                
                
            
                widget.message.message != null? Text("${widget.message.message}",
                    style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                                )
                ): SizedBox(),
              ],

              // Card(
                  
              //     margin: EdgeInsets.all(3),
              //     shape: RoundedRectangleBorder(
              //       borderRadius:BorderRadius.circular(16)
              //     ),
              //     child: Image.file(
              //       File(imgPath),
              //       fit: BoxFit.fill),
              //   ),
            ),
          ),
        ),
      );
    }

    else if(widget.message.type == "source"&& widget.message.mediaType == "document"){
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: ConstrainedBox(constraints: BoxConstraints(
            maxWidth: 230,
            
          ),
          
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16),
               topRight: Radius.circular(0),
                bottomLeft: Radius.circular(16),
                 bottomRight:Radius.circular(16) ),),
            color: constants.appMainColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: InkWell(
                    onTap: () async{
                              _openFile();
                            }, 
                    child: Container(
                      width: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.file_present, color: Colors.white,), 
                    
                          Container(
                            width: 150,
                            child: Text(path.basename(widget.message.filePath), 
                              style: GoogleFonts.inter(
                                color: Colors.white
                              ),
                              overflow: TextOverflow.ellipsis,
                              ),
                          )
                        ],
                      ),
                    ),
                  )
                )
              ],
            ),
          ),),
        ),
      );
    }

    // else if(widget.message.type == "destination"&& widget.message.mediaType == "video"){
    //   return;
    // }

    // else if(widget.message.type == "source"&& widget.message.mediaType == "file"){
    //   return;
    // }

    // else if(widget.message.type == "destination"&& widget.message.mediaType == "file"){
    //   return;
    // }

    else{
      return Scaffold(
        body: Text("Error happened somewhere"),
      ); 
    }


  }


  Future<void> _openFile() async {
    if (widget.message.filePath != null) {
      final result = await OpenFile.open(widget.message.filePath);
      if (result.type != ResultType.done) {
        // Error handling
      }
    }
  }

  String _formatDuration(double seconds) {
    final int s = seconds.toInt() % 60;
    final int m = (seconds ~/ 60) % 60;
    final int h = seconds ~/ 3600;
    return '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}