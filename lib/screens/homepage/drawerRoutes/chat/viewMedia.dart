import 'dart:io';
import 'package:dara_app/main.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:dara_app/models/messageModel.dart';



class ViewMedia extends StatefulWidget{
  ViewMedia({Key? key, required this.mediaType, required this.mediaPath}):super(key: key);
  final String mediaType;
  final String mediaPath;
  State<ViewMedia> createState()=> _ViewMedia();

}

class _ViewMedia extends State<ViewMedia>{
  late VideoPlayerController videoPlayerController;
  bool isPlaying = false;

  
  @override
  void initState() {
   (widget.mediaType=="video")? videoPlayerController = VideoPlayerController.file(File(widget.mediaPath))
   :();


   (widget.mediaType=="video")? videoPlayerController.initialize().then((value) {
    videoPlayerController.setVolume(1);
   }):();
    super.initState();
  }

  @override
  void dispose(){
    (widget.mediaType=="video")? videoPlayerController.dispose():();
    super.dispose();
  }

  Widget build(BuildContext context){

    if(widget.mediaType == "image"){
      return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric( vertical: 5),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)),
            child: Image.file(
                      File(widget.mediaPath),
                      fit: BoxFit.contain),
            
            ),
          ),
        ),
      );
    }

    else if(widget.mediaType == "video"){
      return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Center(
            child: AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(videoPlayerController),
                  Center(
                    child: IconButton(onPressed: (){
                      if(isPlaying){
                        videoPlayerController.pause();
                      }
                      else{
                        videoPlayerController.play();
                      }
                  
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                    }, icon: isPlaying? Icon(Icons.pause_circle,size: 50,):Icon(Icons.play_circle,size: 50,)),
                    
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    else{
      return Scaffold(
        body: Text("Error happened somewhere"),
      ); 
    }


  }
}