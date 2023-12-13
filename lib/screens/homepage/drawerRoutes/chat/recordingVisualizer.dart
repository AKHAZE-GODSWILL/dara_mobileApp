


import 'package:dara_app/main.dart';
import 'package:flutter/material.dart';

class RecordingVisualizer extends StatefulWidget{
  RecordingVisualizer({Key? key, required this.animDuration}):super(key: key);

  final int animDuration;
  State<RecordingVisualizer> createState()=> _RecordingVisualizerState();
}

class _RecordingVisualizerState extends State<RecordingVisualizer> with SingleTickerProviderStateMixin{
  Animation<double>? animation;
  AnimationController? animationController;

  @override
  void initState() {
    animationController =AnimationController(vsync: this,duration: Duration(milliseconds: widget.animDuration));
    final curvedAnimation = CurvedAnimation(parent: animationController!, curve: Curves.easeInOutCubic);
    animation = Tween<double>(begin: 0,end: 50).animate(curvedAnimation)..addListener(() {
      setState(() {
        
      });
    });

    animationController!.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose(){
    animationController!.dispose();
    animation!.removeListener(() { });
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
          width:8,
          height: animation!.value,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: constants.appMainColor
          ),
        ),
    );
  }
}